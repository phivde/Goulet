### -*-Makefile-*- pour préparer la page web de
###                "Programmer avec R"
##
## Copyright (C) 2018 Vincent Goulet
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet
## "Programmer avec R"
## http://gitlab.com/vigou3/programmer-avec-r


## Numéro de version extrait du document maître
MASTER = programmer-avec-r.pdf
REPOSURL = $(shell git show master:${MASTER:.pdf=.tex} \
	| grep "newcommand{\\\\reposurl" \
	| cut -d } -f 2 | tr -d {)
YEAR = $(shell git show master:${MASTER:.pdf=.tex} \
	| grep "newcommand{\\\\year" \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell git show master:${MASTER:.pdf=.tex} \
	| grep "newcommand{\\\\month" \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

## Dépôt GitLab et authentification
REPOSNAME = $(shell basename ${REPOSURL})
APIURL = https://gitlab.com/api/v4/projects/vigou3%2F${REPOSNAME}
OAUTHTOKEN = $(shell cat ~/.gitlab/token)

## Variables automatiques
TAGNAME = v${VERSION}


all: files commit

## Release links API
## changement à apporter à l'expression pour file_id:
## changer ${APIURL}/repository/tags/${TAGNAME}
## pour    ${APIURL}/releases/${TAGNAME}/assets/links
files:
	$(eval url=$(subst /,\/,$(patsubst %/,%,${REPOSURL})))
	$(eval file_id=$(shell curl --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	                             --silent \
	                             ${APIURL}/repository/tags/${TAGNAME} \
	                        | grep -o "/uploads/[a-z0-9]*/" \
	                        | cut -d/ -f3))
	cd content && \
	  awk 'BEGIN { FS = "/"; OFS = "/" } \
	       /^## Édition/ { print; getline; print; getline; \
	                       gsub(/[0-9]{4}\.[0-9]{2}(-[0-9]*[a-z]*)?/, "${VERSION}") } \
	       1' \
	      _index.md > tmpfile && \
	  mv tmpfile _index.md
	cd layouts/partials && \
	  awk 'BEGIN { FS = "/"; OFS = "/" } \
	       /${url}\/uploads/ { if (NF != 8) { \
		                       print "invalid number of fields in the uploads url" > "/dev/stderr"; \
				       exit 1; } \
				   $$7 = "${file_id}" } \
	       /${url}\/tags/ { if (NF != 8) { \
		                    print "invalid number of fields in the tags url" > "/dev/stderr"; \
				    exit 1; } \
		                $$7 = "${TAGNAME}" } 1' \
	       site-header.html > tmpfile && \
	  mv tmpfile site-header.html

commit:
	git commit content/_index.md layouts/partials/site-header.html \
	    -m "Updated web page for version ${VERSION}"; \
	git push


