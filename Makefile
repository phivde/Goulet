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

files:
	$(eval file_id=$(shell curl --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	                             --silent \
	                             ${APIURL}/releases/${TAGNAME}/assets/links \
	                       | sed -E 's/.*\"direct_asset_url\":\".*\/(uploads\/[^\"]*)\".*/\1/'))
	awk 'BEGIN { FS = "\""; OFS = "\"" } \
	     /file_id/ { $$2 = "${file_id}" } \
	     1' \
	    config.toml > tmpfile && \
	  mv tmpfile config.toml
	awk 'BEGIN { FS = "/"; OFS = "/" } \
	     /^## Édition/ { print; getline; print; getline; \
	                     gsub(/[0-9]{4}\.[0-9]{2}(-[0-9]*[a-z]*)?/, "${VERSION}") } \
	     1' \
	    content/_index.md > tmpfile && \
	  mv tmpfile content/_index.md

commit:
	git commit config.toml content/_index.md \
	    -m "Updated web page for version ${VERSION}"; \
	git push


