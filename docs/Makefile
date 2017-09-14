### -*-Makefile-*- pour mettre à jour la page web de
### "Programmer avec R"
##
## Copyright (C) 2017 Vincent Goulet
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet "Programmer avec R"
## http://github.com/vigou3/programmer-avec-r


## Document principal (source)
MASTER = ../programmer-avec-r.tex

## Numéro de version 
YEAR = $(shell grep "newcommand{\\\\year" ${MASTER} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month" ${MASTER} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

all: files commit

files:
	awk 'BEGIN { FS = "/"; OFS = "/" } \
	     /^## Édition/ { print; getline; print; getline; \
	                     gsub(/[0-9]{4}\.[0-9]{2}(-[0-9a-z]*)?/, "${VERSION}") } \
	     /\[documentation\]/ { $$3 = "v${VERSION}" } 1' \
	    index.md > tmpfile && \
	  mv tmpfile index.md
	cd _layouts && \
	  awk 'BEGIN { FS = "/"; OFS = "/" } \
	       /{{ site.github.releases_url }}/ { $$3 = "v${VERSION}" } 1' \
	       default.html > tmpfile && \
	  mv tmpfile default.html

commit:
	git commit index.md _layouts/default.html -m "Updated web page for version ${VERSION}"
	git push


