### -*-Makefile-*- pour préparer "Programmer avec R"
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make pdf' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave et compile le document maître avec XeLaTeX.
##
## 'make tex' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave.
##
## 'make contrib' crée le fichier COLLABORATEURS.
##
## 'make zip' crée l'archive contenant le code source des sections
## d'exemples.
##
## 'make release' crée une nouvelle version dans GitLab, téléverse le
## fichier .zip et modifie les liens de la page web.
##
## 'make all' est équivalent à 'make pdf' question d'éviter les
## publications accidentelles.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet "Programmer avec R"
## http://gitlab.com/vigou3/programmer-avec-r


## Principaux fichiers
MASTER = programmer-avec-r.pdf
ARCHIVE = programmer-avec-r.zip
README = README.md
COLLABORATEURS = COLLABORATEURS
OTHER = LICENSE \
	100metres.data

## Le document maître dépend de tous les fichiers .Rnw et des fichiers
## .tex et .R mentionnés ci-dessous.
RNWFILES = $(wildcard *.Rnw)
TEXFILES = \
	couverture-avant.tex \
	notices.tex \
	introduction.tex \
	collaboration.tex \
	texte.tex \
	rstudio.tex \
	emacs+ess.tex \
	git.tex \
	reponses.tex \
	colophon.tex \
	couverture-arriere.tex
SCRIPTS = \
	presentation.R \
	bases.R \
	implementation.R \
	algorithmique.R \
	donnees.R \
	application.R \
	internes.R \
	collaboration.R \
	debogage.R

## Informations de publication extraites du fichier maître
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
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf

## Dossier temporaire pour construire l'archive
BUILDDIR = tmpdir

## Dépôt GitLab et authentification
REPOSNAME = $(shell basename ${REPOSURL})
APIURL = https://gitlab.com/api/v4/projects/vigou3%2F${REPOSNAME}
OAUTHTOKEN = $(shell cat ~/.gitlab/token)

## Variables automatiques
TAGNAME = v${VERSION}
FILESIZE = $(shell du -h ${ARCHIVE} | cut -f1 | sed 's/\([KMG]\)/ \1o/')


all: pdf

.PHONY: tex pdf zip release upload create-release publish clean

FORCE: ;

pdf: $(MASTER)

tex: $(RNWFILES:.Rnw=.tex)

Rout: $(SCRIPTS:.R=.Rout)

release: zip upload create-release publish

%.tex: %.Rnw
	$(SWEAVE) '$<'

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< > $<.tmp
	$(RBATCH) $<.tmp $@
	$(RM) $<.tmp

$(MASTER): $(MASTER:.pdf=.tex) $(RNWFILES:.Rnw=.tex) $(TEXFILES) $(SCRIPTS)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

${COLLABORATEURS}: FORCE
	git log --pretty="%an%n" | sort | uniq | \
	  grep -v -E "${OMITAUTHORS}" | \
	  awk 'BEGIN { print "Les personnes dont le nom [1] apparait ci-dessous ont contribué à\nl'\''amélioration de «${TITLE}»." } \
	       { print $$0 } \
	       END { print "\n[1] Noms tels qu'\''ils figurent dans le journal du dépôt Git\n    ${REPOSURL}" }' > ${COLLABORATEURS}

zip: ${MASTER} ${README} ${SCRIPTS} ${SCRIPTS:.R=.Rout} ${OTHER}
	if [ -d ${BUILDDIR} ]; then ${RM} ${BUILDDIR}; fi
	mkdir -p ${BUILDDIR}
	touch ${BUILDDIR}/${README} && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Auteur/ { printf("## Édition\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${BUILDDIR}/${README}
	cp ${MASTER} ${SCRIPTS} ${SCRIPTS:.R=.Rout} ${OTHER} ${BUILDDIR}
	cd ${BUILDDIR} && zip --filesync -r ../${ARCHIVE} *
	${RM} ${BUILDDIR}

upload :
	@echo ----- Uploading archive to GitLab...
	$(eval upload_url_markdown=$(shell curl --form "file=@${ARCHIVE}" \
	                                        --header "PRIVATE-TOKEN: ${OAUTHTOKEN}"	\
	                                        --silent \
	                                        ${APIURL}/uploads \
	                                   | awk -F '"' '{ print $$12 }'))
	@echo Markdown ready url to file:
	@echo "${upload_url_markdown}"
	@echo ----- Done uploading files

create-release :
	@echo ----- Creating release on GitLab...
	@if [ -n "$(shell git status --porcelain | grep -v '^??')" ]; then \
	     echo "uncommitted changes in repository; not creating release"; exit 2; fi
	@if [ -n "$(shell git log origin/master..HEAD)" ]; then \
	    echo "unpushed commits in repository; pushing to origin"; \
	     git push; fi
	if [ -e relnotes.in ]; then rm relnotes.in; fi
	touch relnotes.in
	awk 'BEGIN { ORS = " "; print "{\"tag_name\": \"${TAGNAME}\"," } \
	      /^$$/ { next } \
	      /^## Historique/ { state = 1; next } \
              (state == 1) && /^### / { \
		state = 2; \
		out = $$2; \
	        for(i = 3; i <= NF; i++) { out = out" "$$i }; \
	        printf "\"description\": \"# Édition %s\\n", out; \
	        next } \
	      (state == 2) && /^### / { exit } \
	      state == 2 { printf "%s\\n", $$0 } \
	      END { print "\\n## Télécharger la distribution\\n${upload_url_markdown} (${FILESIZE})\"}" }' \
	     README.md >> relnotes.in
	curl --request POST \
	     --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	     "${APIURL}/repository/tags?tag_name=${TAGNAME}&ref=master"
	curl --data @relnotes.in \
	     --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	     --header "Content-Type: application/json" \
	     ${APIURL}/repository/tags/${TAGNAME}/release
	rm relnotes.in
	@echo ----- Done creating the release

publish:
	@echo ----- Publishing the web page...
	git checkout pages && \
	  ${MAKE} && \
	  git checkout master
	@echo ----- Done publishing

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	      *-[0-9][0-9][0-9].pdf \
	      *.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps


