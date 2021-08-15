### -*-Makefile-*- pour préparer la page web de
###                "Programmer avec R"
##
## Copyright (C) 2021 Vincent Goulet
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet
## "Programmer avec R"
## http://gitlab.com/vigou3/programmer-avec-r


## Informations de version extraites du document maître
MASTER = programmer-avec-r.pdf
VERSIONINFO := $(shell \
  git show master:${MASTER:.pdf=.tex} | \
  awk 'BEGIN { FS = "[\{\}]" } \
       /\\reposurl/ { repos = $$4 } \
       /\\year/     { year = $$4 } \
       /\\month/    { month = $$4 } \
       END { print repos " " year " " month }')
REPOSURL = $(word 1,${VERSIONINFO})
YEAR = $(word 2,${VERSIONINFO})
MONTH = $(word 3,${VERSIONINFO})
VERSION = ${YEAR}.${MONTH}
TAGNAME = v${VERSION}

## Dépôt GitLab et authentification
REPOSNAME = $(shell basename ${REPOSURL})
APIURL = https://gitlab.com/api/v4/projects/vigou3%2F${REPOSNAME}
OAUTHTOKEN = $(shell cat ~/.gitlab/token)

## Extraire les url des fichiers joints à la mise en production
ASSETS := $(shell \
  curl --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
       --silent \
       ${APIURL}/releases/${TAGNAME}/assets/links | \
  sed 's/,/\n/g' | \
  awk 'BEGIN { FS = "\"" } \
       /direct_asset_url/ \
       { \
         sub(/.*\/uploads/, "uploads", $$4); \
         f = f " " $$4 \
       } \
       END { print f }')
ZIP_ID := $(filter %.zip,${ASSETS})

all: files commit

files:
	awk 'BEGIN { FS = "\""; OFS = "\"" } \
	     /version/ { $$2 = "${VERSION}" } \
	     /zip_id/ { $$2 = "${ZIP_ID}" } \
	     1' \
	    config.toml > tmpfile && \
	  mv tmpfile config.toml

commit:
	git commit config.toml content/_index.md \
	    -m "Updated web page for version ${VERSION}"; \
	git push


