### -*-Makefile-*- pour préparer Introduction à la programmation en R
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make pdf' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave, place les bonnes URL vers les vidéos dans le code source et
## compile le document maître avec XeLaTeX.
##
## 'make zip' crée l'archive contenant le code source des sections d'exemples.
##
## 'make release' crée une nouvelle version dans GitHub, téléverse les
## fichiers PDF et .zip et modifie les liens de la page web.
##
## 'make all' exécute les trois étapes ci-dessus.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet Introduction à la programmation en R
## http://github.com/vigou3/introduction-programmation-r

## Correspondances url des capsules sur YouTube.
#
#  TITRE ABRÉGÉ  	  CHAPITRE	ACT-2002			INTRO R
#  Présentation		  presentation	https://youtu.be/fs0LHQ7sDpI	https://youtu.be/PSQIKSKw_ys
#  Indiçage		  bases		https://youtu.be/sMd1IyTg-ic	https://youtu.be/cQUjdwgTyz4
#  Fonction order	  operateurs	https://youtu.be/pPLxbuEZmkA	https://youtu.be/uC-zkzwsCVY
#  Fonction outer	  operateurs	https://youtu.be/Ht04UiHnU_0	https://youtu.be/cyPUAnieWHw
#  Fonction apply	  avance	https://youtu.be/EN-a8bTefNk	https://youtu.be/8UQN6RRnsFA
#  Anatomie		  emacs+ess	https://youtu.be/xiNnHegDau8	https://youtu.be/KtmFDm2AKM4
#  Fichiers configuration emacs+ess	https://youtu.be/IsyQn7d2Ao0	https://youtu.be/jdtjBBkfhO0
#  Installation packages  packages	https://youtu.be/DL48oi2RKjM	https://youtu.be/mL6iNzjHMKE

## Document maître et archives
MASTER = introduction_programmation_r.pdf
CODE = Goulet_introduction_programmation_R.zip

## Numéro de version et numéro ISBN extraits du fichier maître
YEAR = $(shell grep "newcommand{\\\\year" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
VERSION = $(shell grep "newcommand{\\\\ednum" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)
ISBN = $(shell grep "newcommand{\\\\ISBN" ${MASTER:.pdf=.tex} \
	| cut -d } -f 2 | tr -d {)

## Le document maître dépend de tous les fichiers .tex et des fichiers
## .R mentionnés
RNWFILES = $(wildcard *.Rnw)
TEXFILES = \
	frontispice.tex \
	notices.tex \
	introduction.tex \
	emacs+ess.tex \
	rstudio.tex \
	packages.tex \
	reponses.tex
RFILES = \
	presentation.R \
	bases.R \
	operateurs.R \
	fonctions.R \
	avance.R \
	optimisation.R \
	rng.R

## Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf


all: pdf zip release

release: create-release upload publish

.PHONY: tex pdf zip release create-release upload publish clean

pdf: tex $(MASTER)

tex: $(RNWFILES:.Rnw=.tex)

%.tex: %.Rnw
	$(SWEAVE) '$<'
	if [ "$@" == "presentation.tex" ]; then \
	  sed -E -i "" \
	      -e "s:youtu.be/(presentation|fs0LHQ7sDpI):youtu.be/PSQIKSKw_ys:" $@; \
	fi
	if [ "$@" == "bases.tex" ]; then \
	  sed -E -i "" \
	      -e "s:youtu.be/(indicage|sMd1IyTg-ic):youtu.be/cQUjdwgTyz4:" $@; \
	fi
	if [ "$@" == "operateurs.tex" ]; then \
	  sed -E -i "" \
	      -e "s:youtu.be/(order|pPLxbuEZmkA):youtu.be/uC-zkzwsCVY:" \
	      -e "s:youtu.be/(outer|Ht04UiHnU_0):youtu.be/cyPUAnieWHw:" $@; \
	fi
	if [ "$@" == "avance.tex" ]; then \
	  sed -E -i "" \
	      -e "s:youtu.be/(apply|EN-a8bTefNk):youtu.be/8UQN6RRnsFA:" $@; \
	fi

$(MASTER): $(MASTER:.pdf=.tex) $(RNWFILES) $(RFILES) $(TEXFILES)
	case $? in \
	"emacs+ess.tex") \
	  sed -E -i "" \
	      -e "s:youtu.be/(anatomie|xiNnHegDau8):youtu.be/KtmFDm2AKM4:" \
	      -e "s:youtu.be/(configuration|IsyQn7d2Ao0):youtu.be/jdtjBBkfhO0:" emacs+ess.tex \
	  ;; \
	"packages.tex") \
	  sed -E -i "" \
	      -e "s:youtu.be/(packages|DL48oi2RKjM):youtu.be/mL6iNzjHMKE:" packages.tex \
	  ;; \
	esac
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

zip: $(RFILES)
	zip -j $(CODE) ${RFILES}

create-release :
	@echo ----- Creating release on GitHub...
	if [ -e relnotes.in ]; then rm relnotes.in; fi
	git commit -a -m "Édition ${VERSION}" && git push
	@echo '{"tag_name": "ed${VERSION}",' > relnotes.in
	@awk '/^# Historique/ {state=1; next} \
              (state==1) && /^## /{state=2; \
	                           out=$$2; \
	                           for(i=3;i<= NF;i++){out=out" "$$i}; \
	                           printf "\"name\": \"%s\",\n\"body\": \"\n",out; \
	                           next} \
	      (state==2) && /^## /{state=3; printf "\"\n"; next} \
	      state == 2 {print}' README.md >> relnotes.in
	@echo '"draft": false, "prerelease": false}' >> relnotes.in
#	curl --data @relnotes.in ${REPOSURL}/releases?access_token=${OAUTHTOKEN}
#	rm relnotes.in
	@echo ----- Done creating the release

upload :
	@echo ----- Getting upload URL from GitHub...
	$(eval upload_url=$(shell curl -s ${REPOSURL}/releases/latest \
	 			  | grep "^  \"upload_url\""  \
	 			  | cut -d \" -f 4            \
	 			  | cut -d { -f 1))
	@echo ${upload_url}
	@echo ----- Uploading the disk image to GitHub...
	curl -H 'Content-Type: application/zip' \
	     -H 'Authorization: token ${OAUTHTOKEN}' \
	     --upload-file ${DISTNAME}.dmg \
             -s -i "${upload_url}?&name=${DISTNAME}.dmg"
	@echo ----- Done uploading the disk image

publish :
	@echo ----- Publishing the web page...
	${MAKE} -C docs
	@echo ----- Done publishing

test:
	@echo ${YEAR}
	@echo ${VERSION}
	@echo ${ISBN}

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	*-[0-9][0-9][0-9].eps \
	*-[0-9][0-9][0-9].pdf \
	*.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps
