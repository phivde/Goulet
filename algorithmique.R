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
### SOLUTIONS D'EXERCICES DE
### STEPHENS, R. 2013, «Essential Algorithms», Wiley.
###

Chapitre 1: 1, 3, 5-7.
Chapitre 6: 1-5, 15, 16, 18.
Chapitre 7: 1, 2, 4, 5.
Chapitre 9: 1, 2.

###
### COURTE INTRODUCTION AUX STRUCTURES DE CONTRÔLE EN R
###

## La syntaxe des principales structures de contrôle en R est
## la suivante.
##
## Exécution conditionnelle:
##
##   if (<condition>)
##       <expression si vrai>
##   else
##       <expression si faux>
##
## Boucle de longueur déterminée:
##
##   for (<variable> in <suite>)
##       <expression>
##
## Boucles de longueur indéterminée:
##
##   while (<condition>)
##       <expression>
##
##   repeat
##       <expression>
##
## Contrôle du flux:
##
##   break                 (sortie de la boucle)
##   next                  (passage à la prochaine itération)
##   return(<expression>)  (sortie de la fonction)

###
### CHAPITRE 6
###

### EXERCICE 1 - Mise en œuvre de l'algorithme insertionsort

## L'algorithme insertionsort déplace successivement les
## valeurs du vecteur vers l'avant dans leur position en ordre
## croissant, comme on le ferait avec des cartes.
##
## L'algorithme requiert deux boucles: une pour passer par
## toutes les valeurs du vecteur et une autre pour déterminer
## à quel endroit, parmi les valeurs déjà triées, chaque
## valeur doit se retrouver.
##
## L'expression à l'intérieur de la clause 'if' repositionne
## les éléments du vecteur dans le bon ordre.
##
## NOTE: la fonction 'seq_len(n)' génère une suite de longueur
## 'n'. C'est généralement équivalent à '1:n', sauf lorsque 'n
## = 0': 'seq_len(0)' résulte en un vecteur de longueur nulle,
## alors '1:0' résulte malencontreusement en [1 0].
insertionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        for (j in seq_len(i - 1))
        {
            if (x[j] > x[i])
                ## positionnement de x[i] entre les (j - 1)
                ## premières valeurs triées et la j-ième
                ## valeur triée, puis ajout des valeurs
                ## restantes du vecteur, sauf x[i]
                x <- c(x[seq_len(j - 1)],
                       x[i], x[j],
                       x[j + seq_len(i - j - 1)],
                       x[i + seq_len(xlen - i)])
        }
    }
    x
}

## Nous allons tester nos fonctions avec des vecteurs
## aléatoires. La fonction
##
##   sample(x, size, replace = FALSE)
##
## tire au hasard 'size' valeurs du vecteur 'x', avec ou sans
## remplacement selon la valeur de 'replace'.
(x <- sample(0:10, 7, replace = TRUE))

## Test de notre fonction 'insertionsort'.
insertionsort(x)

### EXERCICE 3 - Mise en œuvre de l'algorithme selectionsort

## L'algorithme selectionsort déplace graduellement vers
## l'avant la plus petite valeur du vecteur, la deuxième plus
## petite valeur, et ainsi de suite.
##
## Deux boucles sont encore nécessaires: une pour passer à
## travers toutes les positions du vecteur et un autre pour, à
## chaque itératio de la première boucle, trouver le minimum
## dans les valeurs restantes du vecteur.
##
## Dans plusieurs langages de programmation, l'échange de deux
## éléments d'un vecteur nécessite une variable tampon
## (temporaire), comme suit:
##
##   tmp <- x[i]
##   x[i] <- x[j]
##   x[j] <- tmp
##
## Remarquer, ci-dessous, comment l'échange est facile à faire
## en R simplement par indiçage.
selectionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        ## recherche de la position de la plus petite valeur
        ## parmi x[i], ..., x[xlen]
        i.min <- i
        for (j in i:xlen)
        {
            if (x[j] < x[i.min])
                i.min <- j
        }

        ## échange de x[i] et x[i.min]
        x[c(i, i.min)] <- x[c(i.min, i)]
    }
    x
}

## Test
(x <- sample(0:10, 7, replace = TRUE))
selectionsort(x)

## La fonction 'which.min' de R retourne l'indice du minimum
## dans un vecteur. Nous pouvons l'utiliser pour éliminer la
## seconde boucle dans la mise en œuvre ci-dessus.
selectionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        ## position du minimum parmi x[i], ..., x[xlen]
        i.min <- (i - 1) + which.min(x[i:xlen])

        ## échange de x[i] et x[i.min]
        x[c(i, i.min)] <- x[c(i.min, i)]
    }
    x
}

## Test
(x <- sample(0:10, 7, replace = TRUE))
selectionsort(x)

### EXERCICE 5 - Mise en œuvre de l'algorithme bubblesort

