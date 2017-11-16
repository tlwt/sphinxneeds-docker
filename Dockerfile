# download base image ubuntu 16.10
FROM ubuntu:16.10
MAINTAINER "Till S. Witt <mail@tillwitt.de>"

RUN apt-get update

RUN apt-get -y install python-pip
RUN pip install --upgrade pip

RUN apt-get install nano

RUN pip install sphinxcontrib-needs
RUN pip install recommonmark
RUN pip install sphinx-rtd-theme

# installing pdf
RUN apt-get -y install texlive-latex-recommended
RUN apt-get -y install texlive-fonts-recommended
RUN apt-get -y install texlive-latex-extra
RUN apt-get -y install latexmk

RUN apt-get -y install default-jre
RUN apt-get -y install graphviz

# adds a local file to the image
ADD runAfterBoot.sh /tmp/
RUN chmod 755 /tmp/runAfterBoot.sh

workdir /project

RUN pip install sphinxcontrib-plantuml
RUN apt-get -y install default-jre
RUN apt-get -y install graphviz

RUN apt-get -y install wget

WORKDIR /tools
RUN wget https://netcologne.dl.sourceforge.net/project/plantuml/1.2017.19/plantuml.1.2017.19.jar

workdir /project

ADD tools/plantuml /usr/local/bin/
RUN chmod +x /usr/local/bin/plantuml


# starting the command line
ENTRYPOINT /tmp/runAfterBoot.sh
