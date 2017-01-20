### -*-Makefile-*- pour la page web de Introduction à la programmation en R
##
## Copyright (C) 2017 Vincent Goulet
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet Introduction à la programmation en R
## http://github.com/vigou3/introduction-programmation-r

all :
#	sed -e 's/<VERSION>/${VERSION}/g'             \
#	    index.md.in > index.md
	sed -e 's/<VERSION>/${VERSION}/g'     \
	    _layouts/default.html.in > _layouts/default.html
	git commit -a -m "Mise à jours de la page web pour l'édition ${VERSION}" && \
	git push

