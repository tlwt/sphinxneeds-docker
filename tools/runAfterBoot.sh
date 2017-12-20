#!/bin/bash
echo sphinx

# folder to keep configuration
mkdir -p /project/input/
mkdir -p /project/tmp/
mkdir -p /project/output/
mkdir -p /project/output/pdf/


cd /project/tmp/
sphinx-quickstart -q -p "$Project" -a "$Author" -v "$Version" --suffix=.rst

## adding markdown support
echo "from recommonmark.parser import CommonMarkParser" >> conf.py
echo "source_parsers = {'.md': CommonMarkParser}" >> conf.py

#activating proper suffix line
sed -i "s/# source_suffix = \['.rst', '.md'\]/source_suffix = \['.rst', '.md'\]/g"  /project/tmp/conf.py

#removing wrong suffix line
sed -i "s/source_suffix = '.rst'//g"  /project/tmp/conf.py

#adding items to the navigation
sed -i "s/'relations.html',/'about.html','navigation.html','relations.html',/g"  /project/tmp/conf.py

#switching to readthedocs theme
sed -i "s/html_theme = 'alabaster'/import sphinx_rtd_theme \\nhtml_theme = 'sphinx_rtd_theme' \\nhtml_theme_path = [sphinx_rtd_theme.get_html_theme_path()]/g"  /project/tmp/conf.py

#removing blank page from PDF at the end of each chapter
sed -i "s/# Additional stuff for the LaTeX preamble./# Additional stuff for the LaTeX preamble. \\n'classoptions': ',openany,oneside'/g"  /project/tmp/conf.py

#activating extensions
sed -i "s/extensions = \[\]/extensions = \['sphinxcontrib.needs','sphinxcontrib.plantuml',\]/g"  /project/tmp/conf.py




# copying to tmp dir
/bin/cp -rf /project/input/* /project/tmp

# creating output
make latexpdf

# build html directly to target dir
make html

# requirements
#sphinx-build -b needs /project/tmp /project/output

rm -rf /project/output/html/
cp -rf /project/tmp/_build/html/ /project/output/html/
cp -rf /project/tmp/_build/latex/*.pdf /project/output/pdf/
