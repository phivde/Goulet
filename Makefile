### -*-Makefile-*- pour préparer "Programmer avec R"
##
## Copyright (C) 2019 Vincent Goulet
##
## 'make pdf' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave et compile le document maitre avec XeLaTeX.
##
## 'make tex' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave.
##
## 'make scripts' crée les fichiers .R à partir des fichiers .Rnw avec
## Sweave (et Stangle).
##
## 'make contrib' crée le fichier COLLABORATEURS.
##
## 'make Rout' crée les fichiers .Rout avec R CMD BATCH.
##
## 'make zip' crée l'archive de la distribution.
##
## 'make release' crée une nouvelle version dans GitLab, téléverse le
## fichier .zip et modifie les liens de la page web.
##
## 'make check-url' vérifie la validité de toutes les url présentes
## dans les sources du document.
##
## 'make all' est équivalent à 'make pdf' question d'éviter les
## publications accidentelles.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet "Programmer avec R"
## https://gitlab.com/vigou3/programmer-avec-r


## Principaux fichiers
MASTER = programmer-avec-r.pdf
ARCHIVE = ${MASTER:.pdf=.zip}
README = README.md
NEWS = NEWS
COLLABORATEURS = COLLABORATEURS
LICENSE = LICENSE

## Autres fichiers à inclure dans l'archive
CONTRIBUTING = CONTRIBUTING.md
OTHER = 100metres.data gabarit-documentation-fonction.R

## Le document maitre dépend de tous les fichiers .Rnw et de tous les
## fichiers .tex autres que lui-même qui n'ont pas de version .Rnw.
RNWFILES = $(wildcard *.Rnw)
TEXFILES = $(addsuffix .tex, \
                       $(filter-out $(basename ${RNWFILES} ${MASTER} $(wildcard solutions-*.tex)),\
                                    $(basename $(wildcard *.tex))))

## Les fichiers de script sont tous extraits des fichiers .Rnw.
## Certains fichiers .Rnw ne contiennent pas de fichier de script.
SCRIPTS = $(filter-out texte.R, \
	               ${RNWFILES:.Rnw=.R})

## Informations de publication extraites du fichier maitre
TITLE = $(shell grep "\\\\title" ${MASTER:.pdf=.tex} \
	| cut -d { -f 2 | tr -d })
REPOSURL = $(shell grep "newcommand{\\\\reposurl" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
YEAR = $(shell grep "newcommand{\\\\year" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

## Auteurs à exclure du fichier COLLABORATEURS (regex)
OMITAUTHORS = Vincent Goulet|Inconnu|unknown

## Outils de travail
SWEAVE = R CMD Sweave --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
CP = cp -p
RM = rm -rf

## Indiquer à TeX de rechercher des fichiers dans texmf
export TEXINPUTS := ./texmf//:${TEXINPUTS}

## Dossier temporaire pour construire l'archive
BUILDDIR = tmpdir

## Dépôt GitLab et authentification
REPOSNAME = $(shell basename ${REPOSURL})
APIURL = https://gitlab.com/api/v4/projects/vigou3%2F${REPOSNAME}
OAUTHTOKEN = $(shell cat ~/.gitlab/token)

## Variable automatique
TAGNAME = v${VERSION}


all: pdf

FORCE: ;

%.tex %.R: %.Rnw
	${SWEAVE} '$<'

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< | \
	  sed -e 's/`.*`//' \
	      -e 's/ *#-\*-.*//' \
	  > $<.tmp
	${RBATCH} $<.tmp $@
	${RM} $<.tmp

${MASTER}: ${MASTER:.pdf=.tex} ${RNWFILES:.Rnw=.tex} ${TEXFILES} ${SCRIPTS} \
	   $(wildcard data/*) $(wildcard images/*)
	${TEXI2DVI} ${MASTER:.pdf=.tex}

${COLLABORATEURS}: FORCE
	git log --pretty="%an%n" | sort | uniq | \
	  grep -v -E "${OMITAUTHORS}" | \
	  awk 'BEGIN { print "Les personnes dont le nom [1] apparait ci-dessous ont contribué à\nl'\''amélioration de «${TITLE}»." } \
	       { print $$0 } \
	       END { print "\n[1] Noms tels qu'\''ils figurent dans le journal du dépôt Git\n    ${REPOSURL}" }' > ${COLLABORATEURS}

.PHONY: pdf
pdf: ${MASTER}

.PHONY: tex
tex: ${RNWFILES:.Rnw=.tex}

.PHONY: scripts
scripts: ${SCRIPTS}

.PHONY: Rout
Rout: ${SCRIPTS:.R=.Rout}

.PHONY: contrib
contrib: ${COLLABORATEURS}

.PHONY: release
release: zip check-status upload create-release publish

.PHONY: zip
zip: ${MASTER} ${README} ${NEWS} ${SCRIPTS:.R=.Rout} ${LICENSE} ${COLLABORATEURS} ${CONTRIBUTING}
	if [ -d ${BUILDDIR} ]; then ${RM} ${BUILDDIR}; fi
	mkdir -p ${BUILDDIR}
	touch ${BUILDDIR}/${README} && \
	  awk '(state == 0) && /^# / { state = 1 }; \
	       /^## Auteur/ { printf("## Édition\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${BUILDDIR}/${README}
	for f in ${SCRIPTS}; \
	    do sed -e 's/`.*`//' \
	           -e 's/ *#-\*-.*//' \
	           $$f > ${BUILDDIR}/$$f; \
	done
	${CP} ${MASTER} ${SCRIPTS:.R=.Rout} ${NEWS} ${LICENSE} \
	      ${COLLABORATEURS} ${CONTRIBUTING} ${OTHER} \
	      ${BUILDDIR}
	cd ${BUILDDIR} && zip --filesync -r ../${ARCHIVE} *
	if [ -e ${COLLABORATEURS} ]; then ${RM} ${COLLABORATEURS}; fi
	${RM} ${BUILDDIR}

.PHONY: check-status
check-status:
	@echo ----- Checking status of working directory...
	@if [ "master" != $(shell git branch --list | grep '^*' | cut -d " " -f 2-) ]; then \
	     echo "not on branch master"; exit 2; fi
	@if [ -n "$(shell git status --porcelain | grep -v '^??')" ]; then \
	     echo "uncommitted changes in repository; not creating release"; exit 2; fi
	@if [ -n "$(shell git log origin/master..HEAD)" ]; then \
	    echo "unpushed commits in repository; pushing to origin"; \
	     git push; fi

.PHONY: upload
upload:
	@echo ----- Uploading archive to GitLab...
	$(eval upload_url_markdown=$(shell curl --form "file=@${ARCHIVE}" \
	                                        --header "PRIVATE-TOKEN: ${OAUTHTOKEN}"	\
	                                        --silent \
	                                        ${APIURL}/uploads \
	                                   | awk -F '"' '{ print $$12 }'))
	@echo Markdown ready url to file:
	@echo "${upload_url_markdown}"
	@echo ----- Done uploading files

.PHONY: create-release
create-release:
	@echo ----- Creating release on GitLab...
	if [ -e relnotes.in ]; then ${RM} relnotes.in; fi
	touch relnotes.in
	$(eval FILESIZE = $(shell du -h ${ARCHIVE} | cut -f1 | sed 's/\([KMG]\)/ \1o/'))
	awk 'BEGIN { ORS = " "; print "{\"tag_name\": \"${TAGNAME}\"," } \
	      /^$$/ { next } \
	      (state == 0) && /^# / { \
		state = 1; \
		out = $$2; \
	        for(i = 3; i <= NF; i++) { out = out" "$$i }; \
	        printf "\"description\": \"# Édition %s\\n", out; \
	        next } \
	      (state == 1) && /^# / { exit } \
	      state == 1 { printf "%s\\n", $$0 } \
	      END { print "\\n## Télécharger la distribution\\n${upload_url_markdown} (${FILESIZE})\"}" }' \
	     ${NEWS} >> relnotes.in
	curl --request POST \
	     --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	     "${APIURL}/repository/tags?tag_name=${TAGNAME}&ref=master"
	curl --data @relnotes.in \
	     --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	     --header "Content-Type: application/json" \
	     ${APIURL}/repository/tags/${TAGNAME}/release
	${RM} relnotes.in
	@echo ----- Done creating the release

.PHONY: publish
publish:
	@echo ----- Publishing the web page...
	git checkout pages && \
	  ${MAKE} && \
	  git checkout master
	@echo ----- Done publishing

.PHONY: check-url
check-url: ${MASTER:.pdf=.tex} ${RNWFILES} ${TEXFILES} ${SCRIPTS}
	@echo ----- Checking urls in sources...
	$(eval url=$(shell grep -E -o -h 'https?:\/\/[^./]+(?:\.[^./]+)+(?:\/[^ ]*)?' $? \
		   | cut -d \} -f 1 \
		   | cut -d ] -f 1 \
		   | cut -d '"' -f 1 \
		   | sort | uniq))
	for u in ${url}; \
	    do if curl --output /dev/null --silent --head --fail --max-time 5 $$u; then \
	        echo "URL exists: $$u"; \
	    else \
		echo "URL does not exist (or times out): $$u"; \
	    fi; \
	done

.PHONY: clean
clean:
	${RM} ${SCRIPTS:.R=.Rout} \
	      ${COLLABORATEURS} \
	      *-[0-9][0-9][0-9].R \
	      *.log *.blg *.out *.rel *~ Rplots* .RData

.PHONY: clean-all
clean-all: clean
	${RM} ${MASTER} \
	      ${ARCHIVE} \
	      ${RNWFILES:.Rnw=.tex} \
	      ${SCRIPTS} \
	      ${OTHER} \
	      solutions-* \
	      *-[0-9][0-9][0-9].pdf \
	      *.aux *.bbl
