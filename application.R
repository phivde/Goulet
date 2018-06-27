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
### EXÉCUTION CONDITIONNELLE
###

## Il est quelque peu délicat d'illustrer l'utilisation de la
## fonction 'if' à l'extérieur d'une fonction. Nous aurons
## l'occasion de l'utiliser plusieurs fois dans les exemples
## de fonctions itératives, plus loin.
##
## Pour l'instant, contentons-nous de ces deux petits exemples
## qui démontrent un usage adéquat de 'if'.
x <- c(-1, 2, 3)
if (any(x < 0)) print("il y a des nombres négatifs")
if (all(x > 0)) print("tous les nombres sont positifs")

## Première erreur fréquente dans l'utilisation de 'if': la
## condition en argument n'est pas une valeur unique.
##
## Portez bien attention au message d'avertissement de R: le
## test a été effectué, mais uniquement avec la première
## valeur du vecteur booléen 'x < 0'. Comme, dans le présent
## exemple, la première valeur de 'x' est négatif,
## l'expression 'print' est exécutée.
if (x < 0)  print("il y a des nombres négatifs")

## Seconde erreur fréquente: tester que vrai est vrai. (Ce
## n'est pas une «erreur» au sens propre puisque la syntaxe
## est valide, mais c'est un non-sens sémantique, une forme de
## pléonasme comme «monter en haut» ou «deux jumeaux».)
##
## Voici un exemple de construction avec un test inutile. Le
## résultat de 'any' est déjà TRUE ou FALSE, alors pas besoin
## de vérifier si TRUE == TRUE ou si FALSE == TRUE.
if (any(x < 0) == TRUE) print("il y a des nombres négatifs")

## Détail intéressant sur la structure 'if ... else ...': il
## est possible de l'utiliser comme une fonction normale,
## c'est-à-dire d'affecter le résultat de la structure à une
## variable.
##
## D'abord, le style de programmation le plus usuel:
## l'affectation est effectuée à l'intérieur des clauses 'if'
## et 'else'.
f <- function(y)
{
    if (y < 0)
        x <- "rouge"
    else
        x <- "jaune"
    paste("la couleur est:", x)
}
f(-2)
f(3)

## Ensuite, la version où le résultat de 'if ... else ...' est
## directement affecté dans la variable. C'est plus compact et
## très lisible si la conséquence et l'alternative sont des
## expressions courtes.
f <- function(y)
{
    x <- if (y < 0) "rouge" else "jaune"
    paste("la couleur est:", x)
}
f(-2)
f(3)

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

## Solution alternative n'ayant pas recours à ifelse(). C'est
## plus long à programmer, mais l'exécution est néanmoins plus
## rapide.
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

## Méthode du point fixe
##
## Nous allons illustrer l'utilisation des boucles avec la
## méthode du point fixe. On dit qu'une valeur x est un «point
## fixe» d'une fonction f si cette valeur satisfait l'équation
##
##   x = f(x).
##
## La méthode numérique de recherche du point fixe d'une
## fonction f est simple et puissante: elle consiste à choisir
## une valeur de départ, puis à évaluer successivement f(x),
## f(f(x)), f(f(f(x))), ... jusqu'à ce que la valeur change
## «peu».
##
## L'algorithme est donc très simple:
##
## 1. Choisir une valeur de départ x[0].
## 2. Pour n = 1, 2, 3, ...
##    2.1 Calculer x[n] = f(x[n - 1])
##    2.2 Si |x[n] - x[n - 1]|/|x[n]| < TOL, passer à
##        l'étape 3.
## 3. Retourner la valeur x[n].
##
## Avant de poursuivre votre lecture, tentez d'identifier le
## meilleur type de boucle ('for', 'while' ou 'repeat') à
## utiliser pour programmer cet algorithme.

## Comme première illustration, supposons que nous avons
## besoin d'une fonction pour calculer la racine carrée d'un
## nombre, c'est à dire la valeur positive de y satisfaisant
## l'équation y^2 = x. Cette équation peut se réécrire sous
## forme de point fixe ainsi:
##
##   y = x/y.
##
## La méthode du point fixe ne converge pas avec cette
## fonction (l'algorithme oscille perpétuellement entre deux
## valeurs).
##
## Une variante de l'équation y^2 = x fonctionnera mieux (en
## fait, on peut démontrer que l'algorithme converge toujours
## pour cette fonction):
##
##   y = (y - x/y)/2.
##
## Voici une première mise en oeuvre de notre fonction 'sqrt'
## utilisant la méthode du point fixe. Puisqu'il faut au
## minimum vérifier si la valeur initiale est un point fixe,
## nous utilisons une boucle 'repeat'.
sqrt <- function(x, start = 1, TOL = 1E-10)
{
    repeat
    {
        y <- (start + x/start)/2
        if (abs(y - start)/y < TOL)
            break
        start <- y
    }
    y
}
sqrt(9, 1)
sqrt(225, 1)
sqrt(3047, 50)

## Formidable. Toutefois, si nous voulions utiliser la méthode
## du point fixe pour résoudre une autre équation, il faudrait
## écrire une nouvelle fonction qui serait pour l'essentiel
## identique, sinon pour le calcul de la fonction
## (mathématique) f(x) pour laquelle nous cherchons le point
## fixe.
##
## Créons donc une fonction de point fixe générale qui prendra
## f(x) en argument.
fixed_point <- function(FUN, start, TOL = 1E-10)
{
    repeat
    {
        x <- FUN(start)
        if (abs(x - start)/x < TOL)
            break
        start <- x
    }
    x
}

## Nous pouvons ensuite écrire une nouvelle fonction 'sqrt'
## utilisant 'fixed_point'. Nous y ajoutons un test de
## validité de l'argument, pour faire bonne mesure.
sqrt <- function(x)
{
    if (x < 0)
        stop("cannot compute square root of negative value")

    fixed_point(function(y) (y + x/y)/2, start = 1)
}
sqrt(9)
sqrt(25)
sqrt(3047)

###
### FONCTIONS D'APPLICATION
###

## FONCTION 'apply'

## La fonction 'apply' applique une fonction sur une ou
## plusieurs dimensions d'une matrice ou d'un tableau.
##
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
## Reprenons ici les exemples du chapitre en montrant comment
## calculer le premier élément de chaque utilisation de
## 'apply'.
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

## Aux fins des exemples ci-dessous, créons d'abord une liste
## formée de nombres aléatoires.
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

## Les fonctions 'lapply' et 'sapply' passent tour à tour les
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

## Application de la fonction 'fun' sur les échantillons de la
## liste 'x' avec un seuil différent pour chacun.
mapply(fun, x, c(3, 5, 7, 7))

## Création de quatre échantillons aléatoires de taille 12.
x <- lapply(rep(12, 4), sample, x = 1:100)

## Moyennes tronquées à 0, 10, 20 et 30 %, respectivement, de
## ces quatre échantillons aléatoires.
mapply(mean, x, 0:3/10)

## FONCTION 'tapply'

## Le jeu de données 'airquality' livré avec R contient les
## mesures quotidiennes de la qualité de l'air à New York
## Daily entre mai et septembre 1973.
?airquality                # rubrique d'aide du jeu de données

## La colonne 'Temp' contient la température du jour et la
## colonne 'Month', le mois (sous forme d'entier de 5 à 9).
##
## La fonction 'tapply' permet de calculer facilement la
## température moyenne par mois.
tapply(airquality$Temp, airquality$Month, mean)

## Équivalent (sauf pour la présentation des résultats).
by(airquality$Temp, airquality$Month, mean)

## FONCTION 'outer'

## La fonction 'outer' applique une fonction (le produit par
## défaut, d'où le nom de la fonction, dérivé de «produit
## extérieur») à toutes les combinaisons des éléments de ses
## deux premiers arguments.
x <- c(1, 2, 4, 7, 10, 12)
y <- c(2, 3, 6, 7, 9, 11)
outer(x, y)                # produit extérieur
x %o% y                    # équivalent plus court

## Pour effectuer un calcul autre que le produit, on spécifie
## la fonction à appliquer en troisième argument. Si la
## fonction est un des opérateurs arithmétiques de base, il
## faut placer le symbole entre guillemets " ".
outer(x, y, "+")           # «somme extérieure»
outer(x, y, "<=")          # toutes les comparaisons possibles
outer(x, y, function(x, y) x + 2 * y) # fonction quelconque

