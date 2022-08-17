### -*-Makefile-*- pour préparer "Programmer avec R"
##
## Copyright (C) 2021 Vincent Goulet
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
## 'make update-copyright' met à jour l'année de copyright dans toutes
## les sources du document
##
## 'make zip' crée l'archive de la distribution.
##
## 'make release' téléverse la distribution dans GitLab, crée une
## nouvelle version et modifie les liens de la page web.
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
MASTER := programmer-avec-r.pdf
ARCHIVE := ${MASTER:.pdf=.zip}
README := README.md
NEWS := NEWS
COLLABORATEURS := COLLABORATEURS
LICENSE := LICENSE

## Autres fichiers à inclure dans l'archive
CONTRIBUTING := CONTRIBUTING.md
OTHER := gabarit-documentation-fonction.R chanson.txt carburant.dat 100metres.dat

## Le document maitre dépend de tous les fichiers .Rnw; de tous les
## fichiers .tex autres que lui-même qui n'ont pas de version .Rnw;
## des fichiers partagés du répertoire 'share'.
RNWFILES := $(wildcard *.Rnw)
TEXFILES := $(addsuffix .tex, \
                       $(filter-out $(basename ${RNWFILES} ${MASTER} $(wildcard solutions-*.tex)),\
                                    $(basename $(wildcard *.tex))))
SHARE := share/license-by-sa.nw

## Les fichiers de script sont tous extraits des fichiers .Rnw. Un
## chapitre est livré avec deux fichiers d'accompagnement pour les
## exemples. Un fichier de script a une extension .sh.
SCRIPTS := ${RNWFILES:.Rnw=.R} sqrt.R tests-sqrt.R texte.sh 

## Informations de publication extraites du fichier maitre
TITLE := $(shell grep "\\\\title" ${MASTER:.pdf=.tex} \
	| cut -d { -f 2 | tr -d })
REPOSURL := $(shell grep "newcommand{\\\\reposurl" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
YEAR := $(shell grep "newcommand{\\\\year" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
MONTH := $(shell grep "newcommand{\\\\month" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
VERSION := ${YEAR}.${MONTH}

## Auteurs à exclure du fichier COLLABORATEURS (regex)
OMITAUTHORS := Vincent Goulet|Inconnu|unknown

## Outils de travail
SWEAVE := R CMD Sweave --encoding="utf-8"
TEXI2DVI := LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH := R CMD BATCH --no-timing
CP := cp -p
RM := rm -rf
MD := mkdir -p

## Indiquer à TeX de rechercher des fichiers dans texmf
export TEXINPUTS := ./texmf//:${TEXINPUTS}

## Dossier temporaire pour construire l'archive
BUILDDIR := tmpdir

## Dépôt GitLab et authentification
REPOSNAME := $(shell basename ${REPOSURL})
APIURL := https://gitlab.com/api/v4/projects/vigou3%2F${REPOSNAME}
OAUTHTOKEN := $(shell cat ~/.gitlab/token)

## Variable automatique
TAGNAME := v${VERSION}


all: pdf

FORCE: ;

%.tex %.R: %.Rnw
	${SWEAVE} '$<'

paquetages.Rout:
	echo "fichier paquetages.Rout sans intérêt"

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< | \
	  sed -e 's/`.*`//' \
	      -e 's/ *#-\*-.*//' \
	  > $<.tmp
	${RBATCH} $<.tmp $@
	${RM} $<.tmp

${MASTER}: ${MASTER:.pdf=.tex} ${MASTER:.pdf=.ist} \
	   ${RNWFILES:.Rnw=.tex} ${TEXFILES} ${SHARE} \
	   $(wildcard data/*) $(wildcard images/*)
	${TEXI2DVI} ${MASTER:.pdf=.tex}

${COLLABORATEURS}: FORCE
	git log --pretty="%an%n" | sort | uniq | \
	  awk 'BEGIN { print "Les personnes dont le nom [1] apparait ci-dessous ont contribué à\nl'\''amélioration de «${TITLE}»." } \
	       $$0 !~ "${OMITAUTHORS}" \
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
release: update-copyright zip check-status create-release create-link publish

.PHONY: update-copyright
update-copyright: ${MASTER:.pdf=.tex} ${RNWFILES} ${TEXFILES} ${SHARE}
	for f in $?; \
	    do sed -E '/^(#|%)* +Copyright \(C\)/s/-20[0-9]{2}/-$(shell date "+%Y")/' \
	           $$f > $$f.tmp && \
	           ${CP} $$f.tmp $$f && \
	           ${RM} $$f.tmp; \
	done

.PHONY: zip
zip: ${MASTER} ${README} ${NEWS} ${SCRIPTS:.R=.Rout} ${LICENSE} ${COLLABORATEURS} ${CONTRIBUTING}
	if [ -d ${BUILDDIR} ]; then ${RM} ${BUILDDIR}; fi
	${MD} ${BUILDDIR}
	touch ${BUILDDIR}/${README} && \
	  awk '(state == 0) && /^# / { state = 1 }; \
	       /^## Auteur/ { printf("## Édition\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${BUILDDIR}/${README}
	for f in ${SCRIPTS}; \
	    do sed -e 's/`.*`//' \
	           -e 's/ *#-\*-.*//' \
	           $$f > ${BUILDDIR}/$$f; \
	done
	${CP} ${MASTER} $(filter-out paquetages.Rout,${SCRIPTS:.R=.Rout}) \
	      ${NEWS} ${LICENSE} ${COLLABORATEURS} ${CONTRIBUTING} ${OTHER} \
	      ${BUILDDIR}
	cd ${BUILDDIR} && zip --filesync -r ../${ARCHIVE} *
	if [ -e ${COLLABORATEURS} ]; then ${RM} ${COLLABORATEURS}; fi
	${RM} ${BUILDDIR}

.PHONY: check-status
check-status:
	@{ \
	    printf "%s" "----- Checking status of working directory... "; \
	    branch=$$(git branch --list | grep ^* | cut -d " " -f 2-); \
	    if [ "$${branch}" != "master"  ] && [ "$${branch}" != "main" ]; \
	    then \
	        printf "\n%s\n" "not on branch master or main"; exit 2; \
	    fi; \
	    if [ -n "$$(git status --porcelain | grep -v '^??')" ]; \
	    then \
	        printf "\n%s\n" "uncommitted changes in repository; not creating release"; exit 2; \
	    fi; \
	    if [ -n "$$(git log origin/master..HEAD | head -n1)" ]; \
	    then \
	        printf "\n%s\n" "unpushed commits in repository; pushing to origin"; \
	        git push; \
	    else \
	        printf "%s\n" "ok"; \
	    fi; \
	}

.PHONY: create-release
create-release:
	@{ \
	    printf "%s" "----- Checking if a release already exists... "; \
	    http_code=$$(curl -I ${APIURL}/releases/${TAGNAME} 2>/dev/null \
	                     | head -n1 | cut -d " " -f2) ; \
	    if [ "$${http_code}" = "200" ]; \
	    then \
	        printf "%s\n" "yes"; \
	        printf "%s\n" "using the existing release"; \
	    else \
	        printf "%s\n" "no"; \
	        printf "%s" "Creating release on GitLab... "; \
	        name=$$(awk '/^# / { sub(/# +/, "", $$0); print $$0; exit }' ${NEWS}); \
	        desc=$$(awk ' \
	                      /^$$/ { next } \
	                      (state == 0) && /^# / { state = 1; next } \
	                      (state == 1) && /^# / { exit } \
	                      (state == 1) { print } \
	                    ' ${NEWS}); \
	        curl --request POST \
	             --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	             --output /dev/null --silent \
	             "${APIURL}/repository/tags?tag_name=${TAGNAME}&ref=master" && \
	        curl --request POST \
	             --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	             --data tag_name="${TAGNAME}" \
	             --data name="$${name}" \
	             --data description="$${desc}" \
	             --output /dev/null --silent \
	             ${APIURL}/releases; \
	        printf "%s\n" "done"; \
	    fi; \
	}

.PHONY: create-link
create-link: create-release
	@{ \
	    printf "%s\n" "----- Uploading package to registry..."; \
	    file_id=$$(curl --upload-file "${ARCHIVE}" \
	                    --header "PRIVATE-TOKEN: ${OAUTHTOKEN}"	\
	                    "${APIURL}/packages/generic/Programmer-avec-R/${VERSION}/${ARCHIVE}?select=package_file" \
	           | awk -F '[":,]' '{ print $$4 }'); \
	    curl --request POST \
	         --header "PRIVATE-TOKEN: ${OAUTHTOKEN}" \
	         --data name="${ARCHIVE}" \
	         --data url="${REPOSURL}/-/package_files/$${file_id}/download" \
	         --data link_type="package" \
	         --output /dev/null --silent \
	         ${APIURL}/releases/${TAGNAME}/assets/links; \
	    printf "%s\n" "done"; \
	}

.PHONY: publish
publish:
	@echo ----- Publishing the web page...
	git checkout pages && \
	  ${MAKE} && \
	  git checkout master
	@echo ----- Done publishing

.PHONY: check-url
check-url: ${MASTER:.pdf=.tex} ${RNWFILES} ${TEXFILES}
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
	      solutions-* \
	      *-[0-9][0-9][0-9].pdf \
	      *.aux *.bbl
