### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet
## «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

###
### OPÉRATEURS
###

## Seuls les opérateurs de modulo, de division entière et
## d'égalité sont illustrés ici.
##
## L'opérateur modulo retourne le reste d'une division.
5 %% 2                     # 5/2 = 2 reste 1
5 %% 1:5                   # remarquer la périodicité
10 %% 1:15                 # x %% y = x si x < y

## Un nombre 'x' est pair si 'x mod 2 = 0' et il est impair si
## 'x mod 2 = 1'.
a <- c("Impair", "Pair")
x <- c(2, 3, 6, 8, 9, 11, 12)
x %% 2                     # pair ou impair?
2 - x %% 2                 # observer priorité des opérations
a[2 - x %% 2]              # indiçage à répétition

## La division entière retourne la partie entière de la
## division d'un nombre par un autre.
5 %/% 1:5
10 %/% 1:15

## L'opérateur à utiliser pour vérifier si deux valeurs sont
## égales est '==', et non '='. Utiliser le mauvais opérateur
## est une erreur commune --- et qui peut être difficile à
## détecter --- lorsque l'on programme en R.
5 = 2                      # erreur de syntaxe
5 == 2                     # comparaison
y = 2                      # pas un test...
y                          # ... plutôt une affectation

## Attention, toutefois: '==' vérifie l'égalité bit pour bit
## dans la représentation interne des nombres dans
## l'ordinateur. Ça fonctionne bien pour les entiers ou les
## valeurs booléennes, mais pas pour les nombres réels ou,
## plus insidieux, pour les nombres entiers provenant d'un
## calcul et qui ne sont entiers qu'en apparence.
##
## [Pour en savoir (un peu) plus:
##  http://floating-point-gui.de/formats/fp/]
1.2 + 1.4 + 2.8            # 5.4 en apparence
1.2 + 1.4 + 2.8 == 5.4     # non?!?
0.3/0.1 == 3               # à gauche: faux entier

###
### FONCTIONS UTILES
###

## Pour les exemples qui suivent, on se donne un vecteur non
## ordonné.
x <- c(50, 30, 10, 20, 60, 30, 20, 40)

## SUITES ET RÉPÉTITION

## La fonction 'seq' sert à générer des suites générales. Ses
## principaux arguments sont 'from', 'to' et 'by'.
seq(from = 1, to = 10)       # équivalent à 1:10
seq(10)                      # idem
seq(1, 10, by = 2)           # avec incrément autre que 1
seq(-10, 10, length.out = 5) # incrément automatique

## La fonction 'seq_len' génère une suite de longueur 'n' à
## partir de 1. C'est une version simplifiée et plus rapide de
## 'seq(..., length.out = n)'. De plus, elle est plus robuste
## lorsque l'argument est 0.
seq(10)                    # suite 1, 2, ..., 10
seq(1, length.out = 10)    # idem robuste
seq_len(10)                # équivalent et plus rapide
seq(0)                     # pas ce que l'on penserait!
seq(1, length.out = 0)     # plus prudent
seq_len(0)                 # plus simple

## La fonction 'seq_along' génère une suite de la longueur du
## vecteur en argument à partir de 1. C'est une version
## simplifiée et plus rapide de 'seq(..., along = x)' et de
## 'seq_len(length(x))'.
seq(1, along = x)            # suite de la longueur de x
seq_len(length(x))           # idem, mais deux fonctions
seq_along(x)                 # plus rapide, plus simple

## La fonction 'rep' permet de répéter des vecteurs de
## plusieurs manières différentes.
rep(1, 10)                  # utilisation de base
rep(x, 2)                   # répéter un vecteur
rep(x, each = 4)            # répéter chaque élément
rep(x, times = 2, each = 4) # combinaison des arguments
rep(x, length.out = 20)     # résultat de longueur déterminée
rep(x, times = 1:8)         # nombre de répétitions différent
                            # pour chaque élément de 'x'

## Pour les deux types de répétitions les plus usuels, il y a
## les fonctions 'rep.int' et 'rep_len' qui sont plus rapides
## que 'rep'.
rep.int(x, 2)              # seulement répétition 'times'
rep_len(x, 10)             # seulement répétition 'length.out'

## TRI ET OPÉRATIONS APPARENTÉES

## Classement en ordre croissant ou décroissant.
sort(x)                    # classement en ordre croissant
sort(x, decr = TRUE)       # classement en ordre décroissant
sort(c("abc", "B", "Aunt", "Jemima")) # chaînes de caractères
sort(c(TRUE, FALSE))       # FALSE vient avant TRUE

## La fonction 'order' retourne la position, dans le vecteur
## donné en argument, du premier élément selon l'ordre
## croissant, puis du deuxième, etc. Autrement dit, on obtient
## l'ordre dans lequel il faut extraire les données du vecteur
## pour les obtenir en ordre croissant.
order(x)                   # regarder dans le blanc des yeux
x[order(x)]                # équivalent à 'sort(x)'

## Rang des éléments d'un vecteur dans l'ordre croissant.
rank(x)                    # rang des élément de 'x'

## Renverser l'ordre d'un vecteur.
rev(x)

## Éléments distincts d'un vecteur.
unique(x)

## RECHERCHE
x                          # rappel
which(x >= 30)             # positions des éléments >= 30
which.min(x)               # position du minimum
which.max(x)               # position du maximum
match(20, x)               # position du premier 20 dans 'x'
match(c(20, 30), x)        # aussi pour plusieurs valeurs
60 %in% x                  # 60 appartient à 'x'
70 %in% x                  # 70 n'appartient pas à 'x'

## TESTS LOGIQUES

## Les fonctions 'any' et 'all' prennent en argument un
## vecteur booléen et elles indiquent, respectivement, si au
## moins une ou si toutes les valeurs sont TRUE.
any(c(TRUE, FALSE, FALSE))  # au moins une valeur TRUE
any(c(FALSE, FALSE, FALSE)) # aucune valeur TRUE
all(c(TRUE, TRUE, TRUE))    # toutes les valeurs TRUE
all(c(TRUE, FALSE, TRUE))   # aucune valeur TRUE

## Les fonctions sont des compléments l'une de l'autre: si
## 'any(x)' est TRUE, alors 'all(!x)' est FALSE, et
## vice-versa.
any(c(TRUE, FALSE, FALSE))   # TRUE
all(!c(TRUE, FALSE, FALSE))  # complément: FALSE
any(c(FALSE, FALSE, FALSE))  # FALSE
all(!c(FALSE, FALSE, FALSE)) # complément: TRUE

## Les fonctions sont habituellement utilisées avec une
## expression logique en argument.
x                          # rappel
x > 50                     # valeurs > 50?
x <= 50                    # valeurs <= 50?
any(x > 50)                # y a-t-il des valeurs > 50?
all(x <= 50)               # complément
all(x > 50)                # toutes les valeurs > 50?
any(x <= 50)               # complément

## ARRONDI
(x <- c(-21.2, -pi, -1.5, -0.2, 0, 0.2, 1.7823, 315))
round(x)                   # arrondi à l'entier
round(x, 2)                # arrondi à la seconde décimale
round(x, -1)               # arrondi aux dizaines
ceiling(x)                 # plus petit entier supérieur
floor(x)                   # plus grand entier inférieur
trunc(x)                   # troncature des décimales

## SOMMAIRES ET STATISTIQUES DESCRIPTIVES
sum(x)                     # somme des éléments
prod(x)                    # produit des éléments
diff(x)                    # x[2] - x[1], x[3] - x[2], etc.
mean(x)                    # moyenne des éléments
mean(x, trim = 0.125)      # moyenne sans minimum et maximum
var(x)                     # variance (sans biais)
sd(x)                      # écart type
max(x)                     # maximum
min(x)                     # minimum
range(x)                   # c(min(x), max(x))
diff(range(x))             # étendue de 'x'
median(x)                  # médiane (50e quantile) empirique
quantile(x)                # quantiles empiriques
quantile(x, 1:10/10)       # on peut spécifier les quantiles
summary(x)                 # plusieurs des résultats ci-dessus

## SOMMAIRES CUMULATIFS ET COMPARAISONS ÉLÉMENT PAR ÉLÉMENT
(x <- sample(1:20, 6))
(y <- sample(1:20, 6))
cumsum(x)                  # somme cumulative de 'x'
cumprod(y)                 # produit cumulatif de 'y'
rev(cumprod(rev(y)))       # produit cumulatif renversé
cummin(x)                  # minimum cumulatif
cummax(y)                  # maximum cumulatif
pmin(x, y)                 # minimum élément par élément
pmax(x, y)                 # maximum élément par élément

## EXTRACTION DU DÉBUT ET DE LA FIN D'UN OBJET

## L'idée des fonctions 'head' et 'tail', c'est que l'on se
## positionne en tête ou en queue d'un objet pour effectuer
## des extractions ou des suppressions de composantes.
##
## Avec un argument positif, les fonctions extraient des
## composantes depuis la tête ou la queue de l'objet. Avec un
## argument négatif, elles suppriment des composantes à
## l'«autre bout» de l'objet.
head(x, 3)                 # trois premiers éléments
head(x, -2)                # tous sauf les deux derniers
tail(x, 3)                 # trois derniers éléments
tail(x, -2)                # tous sauf les deux premiers

## Les fonctions sont aussi valides sur les matrices et les
## data frames. Elles extraient ou suppriment alors des lignes
## entières.
m <- matrix(1:30, 5, 6)    # matrice 5 x 6
head(m, 3)                 # trois premières lignes
tail(m, -2)                # sans les deux premières lignes

## OPÉRATIONS SUR LES MATRICES
(A <- sample(1:10, 16, replace = TRUE))
dim(A) <- c(4, 4)          # conversion en une matrice 4 x 4
b <- c(10, 5, 3, 1)        # vecteur quelconque
A                          # matrice 'A'
t(A)                       # transposée
solve(A)                   # inverse
solve(A, b)                # solution de Ax = b
A %*% solve(A, b)          # vérification de la réponse
diag(A)                    # extraction de la diagonale de 'A'
diag(b)                    # matrice diagonale formée avec 'b'
diag(4)                    # matrice identité 4 x 4
(A <- cbind(A, b))         # matrice 4 x 5
nrow(A)                    # nombre de lignes de 'A'
ncol(A)                    # nombre de colonnes de 'A'
rowSums(A)                 # sommes par ligne
colSums(A)                 # sommes par colonne
apply(A, 1, sum)           # équivalent à 'rowSums(A)'
apply(A, 2, sum)           # équivalent à 'colSums(A)'
apply(A, 1, prod)          # produit par ligne avec 'apply'

###
### BIBLIOTHÈQUES ET PAQUETAGES
###

## La fonction 'search' retourne la liste des environnements
## dans lesquels R va chercher un objet (en particulier une
## fonction). '.GlobalEnv' est l'environnement de travail.
search()

## Liste de tous les packages installés sur votre système.
## Noter que MASS en fait partie. C'est un paquetage livré
## avec R, mais qui n'est pas chargé par défaut.
library()

## Chargement du package MASS qui contient plusieurs
## fonctions statistiques très utiles.
library("MASS")

## Liste des bibliothèques consultées par R.
.libPaths()

## Installation du paquetage actuar depuis le miroir canadien
## de CRAN.
##
## Si vous avez configuré une bibliothèque personnelle et
## qu'elle apparait dans le résultat de '.libPaths()',
## ci-dessus, le paquetage sera automatiquement installé dans
## celle-ci.
install.packages("actuar", repos = "http://cran.ca.r-project.org")

## Chargement du paquetage dans la session de travail. R
## recherche le paquetage dans toutes les bibliothèques de
## '.libPaths()'.
library("actuar")
