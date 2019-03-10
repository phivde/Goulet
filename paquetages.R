### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet
## «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

###
### SYSTÈME DE BASE
###

## La fonction 'search' retourne la liste des environnements
## dans lesquels R va chercher un objet (en particulier une
## fonction). '.GlobalEnv' est l'environnement de travail.
search()

## Liste de tous les packages installés sur votre système.
## Noter que MASS en fait partie. C'est un paquetage livré
## avec R, mais qui n'est pas chargé par défaut.
library()

###
### UTILISATION D'UN PAQUETAGE
###

## Chargement du package MASS qui contient plusieurs
## fonctions statistiques très utiles.
library("MASS")

###
### CRÉATION D'UNE BIBLIOTHÈQUE PERSONNELLE
###

## Liste des bibliothèques consultées par R. Votre
## bibliothèque personnelle devrait y apparaitre si vous avez
## suivi la procédure expliquée dans le chapitre.
.libPaths()

###
### INSTALLATION DE PAQUETAGES ADDITIONNELS
###

## Installation du paquetage actuar depuis le miroir canadien
## de CRAN.
##
## Si vous avez configuré une bibliothèque personnelle et
## qu'elle apparait dans le résultat de '.libPaths()',
## ci-dessus, le paquetage sera automatiquement installé dans
## celle-ci.
install.packages("actuar", repos = "https://cran.ca.r-project.org")

## Chargement du paquetage dans la session de travail. R
## recherche le paquetage dans toutes les bibliothèques de
## '.libPaths()'.
library("actuar")
