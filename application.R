### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2017 Vincent Goulet
##
## Ce fichier fait partie du projet «Programmer avec R»
## http://github.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## http://creativecommons.org/licenses/by-sa/4.0/


###
### EXÉCUTION CONDITIONNELLE
###

## exemple d'erreur de test non unique

## exemples de tests if (TRUE == TRUE)

## Utilisation de if comme une fonction


## De l'inefficacité de 'ifelse'.
##
## Supposons que l'on veut une fonction *vectorielle* pour calculer
##
##   f(x) = x + 2, si x < 0
##        = x^2,   si x >= 0.
##
## On se tourne naturellement vers ifelse() pour ce genre de
## calcul. Voyons voir le temps de calcul.
x <- sample(-10:10, 1e6, replace = TRUE)
system.time(ifelse(x < 0, x + 2, x^2))

## Solution alternative n'ayant pas recours à ifelse().
f <- function(x)
{
   y <- numeric(length(x)) # contenant
   w <- x < 0              # x < 0 ou non
   y[w] <- x[w] + 2        # calcul pour les x < 0
   w <- !w                 # x >= 0 ou non
   y[w] <- x[w]^2          # calcul pour les x >= 0
   y
}
system.time(f(x))

###
### BOUCLES ITÉRATIVES ET CONTRÔLE DU FLUX
###

## diverses mises en oeuvre de la version simplifiée de Newton-Raphson
## dans SICP.

###
### FONCTIONS D'APPLICATION
###

## FONCTION 'apply'

## Création d'une matrice et d'un tableau à trois dimensions
## pour les exemples.
m <- matrix(sample(1:100, 20), nrow = 4, ncol = 5)
a <- array(sample(1:100, 60), dim = 3:5)

## Les fonctions 'rowSums', 'colSums', 'rowMeans' et
## 'colMeans' sont des raccourcis pour des utilisations
## fréquentes de 'apply'.
apply(m, 1, sum)           # sommes par ligne
rowSums(m)                 # idem, plus lisible
apply(m, 2, mean)          # moyennes par colonne
colMeans(m)                # idem, plus lisible

## Puisqu'il n'existe pas de fonctions comme 'rowMax' ou
## 'colProds', il faut utiliser 'apply'.
apply(m, 1, max)           # maximums par ligne
apply(m, 2, prod)          # produits par colonne

## L'argument '...' de 'apply' permet de passer des arguments
## à la fonction FUN.
f <- function(x, y) x + 2 * y # fonction à deux arguments
apply(m, 1, f, y = 2)         # argument 'y' passé dans '...'

## Lorsque 'apply' est utilisée sur un tableau, son résultat
## est de dimensions dim(X)[MARGIN], d'où le truc
## mnémotechnique donné dans le texte du chapitre.
apply(a, c(2, 3), sum)     # le résultat est une matrice
apply(a, 1, prod)          # le résultat est un vecteur

## L'utilisation de 'apply' avec les tableaux peut rapidement
## devenir confondante si l'on ne visualise pas les calculs
## qui sont réalisés.
##
## Nous reprenons ici les exemples du chapitre en montrant
## comment calculer le premier élément de chaque utilisation
## de 'apply'.
##
## Au besoin, réviser l'indiçage des tableaux au chapitre 3.
(x <- array(sample(0:10, 24, rep = TRUE), c(3, 4, 2)))
apply(x, 1, sum)      # sommes des 3 tranches horizontales
sum(x[1, , ])         # équivalent pour la première somme

apply(x, 2, sum)      # sommes des 4 tranches verticales
sum(x[, 1, ])         # équivalent pour la première somme

apply(x, 3, sum)      # sommes des 2 tranches transversales
sum(x[, , 1])         # équivalent pour la première somme

apply(x, c(1, 2), sum) # sommes des 12 carottes horizontales
sum(x[1, 1, ])         # équivalent pour la première somme

apply(x, c(2, 3), sum) # sommes des 6 carottes verticales
sum(x[, 1, 1])         # équivalent pour la première somme

apply(x, c(1, 3), sum) # sommes des 8 carottes transversales
sum(x[1, , 1])         # équivalent pour la première somme

## FONCTIONS 'lapply' ET 'sapply'

## La fonction 'lapply' applique une fonction à tous les
## éléments d'un vecteur ou d'une liste et retourne une liste,
## peu importe les dimensions des résultats.
##
## La fonction 'sapply' retourne un vecteur ou une matrice, si
## possible.
##
## Somme «interne» des éléments d'une liste.
(x <- list(1:10, c(-2, 5, 6), matrix(3, 4, 5)))
sum(x)                     # erreur
lapply(x, sum)             # sommes internes (liste)
sapply(x, sum)             # sommes internes (vecteur)

## Création de la suite 1, 1, 2, 1, 2, 3, 1, 2, 3, 4, ..., 1,
## 2, ..., 9, 10.
lapply(1:10, seq)          # résultat sous forme de liste
unlist(lapply(1:10, seq))  # résultat sous forme de vecteur

## Soit une fonction calculant la moyenne pondérée d'un
## vecteur. Cette fonction prend en argument une liste de deux
## éléments: 'donnees' et 'poids'.
fun <- function(x)
    sum(x$donnees * x$poids)/sum(x$poids)

## Nous pouvons maintenant calculer la moyenne pondérée de
## plusieurs ensembles de données réunis dans une liste
## itérée.
(x <- list(list(donnees = 1:7,
                poids = (5:11)/56),
           list(donnees = sample(1:100, 12),
                poids = 1:12),
           list(donnees = c(1, 4, 0, 2, 2),
                poids = c(12, 3, 17, 6, 2))))
sapply(x, fun)             # aucune boucle explicite!

## EXEMPLES ADDITIONNELS SUR L'UTILISATION DE L'ARGUMENT
## '...' AVEC 'lapply' ET 'sapply'

## Aux fins des exemples ci-dessous, nous créons d'abord une
## liste formée de nombres aléatoires.
##
## L'expression ci-dessous fait usage de l'argument '...' de
## 'lapply'. Pouvez-vous la décoder? Nous y reviendrons plus
## loin, ce qui compte pour le moment c'est simplement de
## l'exécuter.
x <- lapply(c(8, 12, 10, 9), sample, x = 1:10, replace = TRUE)

## Soit maintenant une fonction qui calcule la moyenne
## arithmétique des données d'un vecteur 'x' supérieures à une
## valeur 'y'.
##
## Vous remarquerez que cette fonction n'est pas vectorielle
## pour 'y', c'est-à-dire qu'elle n'est valide que lorsque 'y'
## est un vecteur de longueur 1.
fun <- function(x, y) mean(x[x > y])

## Pour effectuer ce calcul sur chaque élément de la liste
## 'x', nous pouvons utiliser 'sapply' plutôt que 'lapply',
## car chaque résultat est de longueur 1.
##
## Cependant, il faut passer la valeur de 'y' à la fonction
## 'fun'. C'est là qu'entre en jeu l'argument '...' de
## 'sapply'.
sapply(x, fun, 7)          # moyennes des données > 7

## Les fonctions 'lapply' et 'sapply' passent tout à tour les
## éléments de leur premier argument comme *premier* argument
## à la fonction, sans le nommer explicitement. L'expression
## ci-dessus est donc équivalente à
##
##   c(fun(x[[1]], 7), ..., fun(x[[4]], 7)
##
## Que se passe-t-il si l'on souhaite passer les valeurs à un
## argument de la fonction autre que le premier? Par exemple,
## supposons que l'ordre des arguments de la fonction 'fun'
## ci-dessus est inversé.
fun <- function(y, x) mean(x[x > y])

## Les règles d'appariement des arguments des fonctions en R
## font en sorte que lorsque les arguments sont nommés dans
## l'appel de fonction, leur ordre n'a pas d'importance. Par
## conséquent, un appel de la forme
##
##   fun(x, y = 7)
##
## est tout à fait équivalent à fun(7, x). Pour effectuer les
## calculs
##
##   c(fun(x[[1]], y = 7), ..., fun(x[[4]], y = 7)
##
## avec la liste définie plus haut, il s'agit de nommer
## l'argument 'y' dans '...' de 'sapply'.
sapply(x, y = 7)

## Décodons maintenant l'expression
##
##   lapply(c(8, 12, 10, 9), sample, x = 1:10, replace = TRUE)
##
## qui a servi à créer la liste. La définition de la fonction
## 'sample' est la suivante:
##
##   sample(x, size, replace = FALSE, prob = NULL)
##
## L'appel à 'lapply' est équivalent à
##
##   list(sample(8, x = 1:10, replace = TRUE),
##        ...,
##        sample(9, x = 1:10, replace = TRUE))
##
## Toujours selon les règles d'appariement des arguments, vous
## constaterez que les valeurs 8, 12, 10, 9 seront attribuées
## à l'argument 'size', soit la taille de l'échantillon.
##
## L'expression crée donc une liste comprenant quatre
## échantillons aléatoires de tailles différentes des nombres
## de 1 à 10 pigés avec remise.
##
## Une expression équivalente, quoique moins élégante, aurait
## recours à une fonction anonyme pour replacer les arguments
## de 'sample' dans l'ordre voulu.
lapply(c(8, 12, 10, 9),
       function(x) sample(1:10, x, replace = TRUE))

## La fonction 'sapply' est aussi très utile pour vectoriser
## une fonction qui n'est pas vectorielle. Supposons que l'on
## veut généraliser la fonction 'fun' pour qu'elle accepte un
## vecteur de seuils 'y'.
fun <- function(x, y)
    sapply(y, function(y) mean(x[x > y]))

## Utilisation sur la liste 'x' avec trois seuils.
sapply(x, fun, y = c(3, 5, 7))

## FONCTION 'mapply'

## Création de quatre échantillons aléatoires de taille 12.
x <- lapply(rep(12, 4), sample, x = 1:100)

## Moyennes tronquées à 0, 10, 20 et 30 %, respectivement, de
## ces quatre échantillons aléatoires.
mapply(mean, x, 0:3/10)

## PRODUIT EXTÉRIEUR
x <- c(1, 2, 4, 7, 10, 12)
y <- c(2, 3, 6, 7, 9, 11)
outer(x, y)                # produit extérieur
x %o% y                    # équivalent plus court
outer(x, y, "+")           # «somme extérieure»
outer(x, y, "<=")          # toutes les comparaisons possibles
outer(x, y, pmax)          # idem

