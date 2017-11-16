# download base image ubuntu 16.10
FROM ubuntu:16.10
MAINTAINER "Till S. Witt <mail@tillwitt.de>"

RUN apt-get update

# Install PIP
RUN apt-get -y install python-pip

# Latex/PDF support for Sphinx-docs
RUN apt-get -y install texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra latexmk

# install tooling
RUN apt-get install wget

# PlantUML tooling
RUN apt-get -y install default-jre
RUN apt-get -y install graphviz

# Install pip components
RUN pip install --upgrade pip
RUN pip install sphinxcontrib-needs
RUN pip install recommonmark
RUN pip install sphinx-rtd-theme
RUN pip install sphinxcontrib-plantuml

# make plantuml executable
ADD tools/plantuml /usr/local/bin/
RUN chmod +x /usr/local/bin/plantuml

# adds a local file to the image
ADD /tools/runAfterBoot.sh /tools/
RUN chmod 755 /tools/runAfterBoot.sh

WORKDIR /tools
ADD /tools/plantuml.1.2017.19.jar .

WORKDIR /project

# starting the command line
ENTRYPOINT /tools/runAfterBoot.sh
