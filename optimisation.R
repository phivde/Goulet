### On répète simplement les exemples présentés dans le
### chapitre.

###
### FONCTION 'uniroot'
###

## Solution de l'équation x - 2^(-x) = 0 dans l'intervalle
## [0, 1]
uniroot(function(x) x - 2^(-x), lower=0, upper=1)

###
### FONCTION 'polyroot'
###

## Racines du polynôme x^3 + 4 x^2 - 10. Les réponses sont
## données sous forme de nombre complexe. Utiliser les
## fonctions 'Re' et 'Im' pour extraire les parties réelles et
## imaginaires des nombres, respectivement.
polyroot(c(-10, 0, 4, 1))  # racines
Re(polyroot(c(-10, 0, 4, 1)))  # parties réelles
Im(polyroot(c(-10, 0, 4, 1)))  # parties imaginaires

###
### FONCTION 'optimize'
###

## Maximum local de la densité d'une loi bêta dans
## l'intervalle [0, 1].
f <- function(x) dbeta(x, 3, 2)
optimize(f, lower=0, upper=1, maximum=TRUE)

###
### FONCTION 'ms'
###

## Fonction de minimisation d'une somme. La somme à minimiser
## doit être spécifiée sous forme de formule et les données se
## trouver dans un data frame. Utile pour minimiser une
## fonction de log-vraisemblance.
x <- rgamma(10, shape=5, rate=2)
ms(~-log(dgamma(x, a, l)), data=as.data.frame(x),
   start=list(a=1, l=1))   # S-Plus seulement

###
### FONCTION 'nlmin'
###

## La fonction 'nlmin' cherche le minimum (global) d'une
## fonction non linéaire quelconque. On peut donc trouver des
## estimateurs du maximum de vraisemblance en tentant de
## minimiser moins la fonction de log-vraisemblance. Il faut
## spéficier des valeurs de départ.
f <- function(p) -sum(log(dgamma(x, p[1], p[2])))
nlmin(f, c(1, 1))          # S-Plus seulement

###
### FONCTION 'nlm'
###

## Équivalent dans R de la fonction 'nlmin' de S-Plus.
nlm(f, c(1, 1), x=x)       # R seulement

###
### FONCTION 'optim'
###

## La fonction 'optim' est très puissante, mais requiert aussi
## une bonne dose de prudence pour bien l'utiliser. Dans
## S-Plus, il faut charger la section MASS de la bibliothèque.
library(MASS)              # S-Plus seulement
optim(c(1, 1), f, x=x)     # même exemple que ci-dessus
