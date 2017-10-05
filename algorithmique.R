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
### CHAPITRE 1
###

### EXERCICE 1 - Mise en œuvre de l'algorithme insertionsort

## L'algorithme requiert deux boucles: une pour passer par
## toutes les valeurs du vecteur et une autre pour déterminer
## à quel endroit, parmi les valeurs déjà triées, chaque
## valeur doit se retrouver.
##
## L'expression à l'intérieur de la clause 'if' repositionne
## les éléments du vecteur dans le bon ordre.
##
## Note: la fonction 'seq_len(n)' génère une suite de longueur
## 'n'. C'est généralement équivalent à '1:n', sauf lorsque 'n
## = 0': 'seq(0)' résulte en un vecteur de longueur nulle,
## alors '1:0' résulte en [0 1].
insertionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        for (j in seq_len(i - 1))
        {
            if (x[j] > x[i])
                x <- c(x[seq_len(j - 1)],
                       x[i], x[j],
                       x[j + seq_len(i - j - 1)],
                       x[i + seq_len(xlen - i)])
        }
    }
    x
}

(x <- sample(0:10, 7, replace = TRUE))
insertionsort(x)


