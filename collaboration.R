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
### INTRODUCTION
###

## Afin d'illustrer l'utilité de bien présenter et de
## commenter le code, nous allons prendre une fonction dans un
## état assez pitoyable et l'améliorer graduellement.
##
## La fonction 'rgamma_ar' sert à générer des nombres
## aléatoires de la distribution gamma dont le paramètre de
## forme se trouve dans l'intervalle (0, 1) par la méthode de
## simulation dite d'«acceptation-rejet».
##
## L'algorithme de simulation d'un nombre 'x' issu d'une
## distribution Gamma(a, 1), 0 < a < 1, est le suivant:
##
## 1. Simuler u, v d'une distribution U(0, 1).
## 2. Calculer y = G^{-1}(u), où
##
##      G^{-1}(x) = ((a + e)/e * x)^(1/a),
##                            si 0 <= x <= e/(a + e)
##                = - log(((1/a) + (1/e)) * (1 - x),
##                            si e/(a + e) < x <= 1.
## 3. Si
##
##      v <= exp(-y),    si 0 <= y <= 1
##        <= y^(a - 1),  si y > 1,
##
##    alors retourner x = y. Sinon retourner à l'étape 1.

###
### PRÉSENTATION DU CODE
###

## La première version du code ne respecte pas les règles de
## base d'indentation et d'«aération» du code. Résultat: un
## fouillis difficile à consulter.
rgamma_ar<-function(n,shape,rate=1,scale=1/rate)
{ if(shape<=0|shape>=1)
stop("valeur de shape inadmissible")
  ratio<-function(x)
     if(x<=1) exp(-x)elsex^(shape-1)
Ginv<-function(x) {
  k<-1+shape*exp(-1)
  if(x<=1/k) (k*x)^(1/shape)
  else -log(((1/shape)+exp(-1))*(1-x))   }

  i<-0
  while(i<n) {
    y<-Ginv(runif(1))
    if(runif(1)<=ratio(y))
    {x<-c(x,y)
        i<-i+1
 }
x*scale
}

## Réviser seulement l'indentation permet déjà d'y voir plus
## clair. Tous les bons éditeurs de texte pour programmeurs
## sont capables d'indenter le code pour vous, que ce soit à
## la volée ou de manière asynchrone.
##
## Vous pouvez arriver au résultat ci-dessous avec RStudio en
## sélectionnant le code ci-dessus et en exécutant l'option du
## menu Code|Reindent Lines.
##
## Dans Emacs, l'indentation se fait automatiquement au fur et
## à mesure que l'on entre du code ou, autrement, en appuyant
## sur la touche de tabulation.
rgamma_ar<-function(n,shape,rate=1,scale=1/rate)
{
    if(shape<=0|shape>=1)
        stop("valeur de shape inadmissible")
    ratio<-function(x)
        if(x<=1) exp(-x)elsex^(shape-1)
    Ginv<-function(x)
    {
        k<-1+shape*exp(-1)
        if(x<=1/k)
            (k*x)^(1/shape)
        else
            -log(((1/shape)+exp(-1))*(1-x))
    }

    i<-0
    while(i<n)
    {
        y<-Ginv(runif(1))
        if(runif(1)<=ratio(y))
        {
            x<-c(x,y)
            i<-i+1
        }
        x*scale
    }

## La simple indentation du code nous permet déjà de découvrir
## un bogue dans le code: il manque une accolade fermante } à
## la fin de la fonction.
##
## En examinant le code de plus près, nous réalisons que
## l'expression 'x * scale', qui sert à retourner le résultat
## de la fonction, devrait se trouver à l'extérieur de la
## boucle 'while'. En fait, l'accolade fermante manquante est
## celle qui termine la clause 'if' à l'intérieur de la boucle.
##
## Corrigeons déjà le code.
rgamma_ar<-function(n,shape,rate=1,scale=1/rate)
{
    if(shape<=0|shape>=1)
        stop("valeur de shape inadmissible")
    ratio<-function(x)
        if(x<=1) exp(-x)elsex^(shape-1)
    Ginv<-function(x)
    {
        k<-1+shape*exp(-1)
        if(x<=1/k)
            (k*x)^(1/shape)
        else
            -log(((1/shape)+exp(-1))*(1-x))
    }

    i<-0
    while(i<n)
    {
        y<-Ginv(runif(1))
        if(runif(1)<=ratio(y))
        {
            x<-c(x,y)
            i<-i+1
        }
    }
    x*scale
}

## Les normes usuelles de présentation du code informatique
## exigent également d'aérer le code avec des espaces autour
## des opérateurs et des structures de contrôle, après les
## virgules, etc. Comme pour du texte normal, les espaces
## rendent le code plus facile à lire.
##
## Dans RStudio, vous pouvez parvenir à la présentation
## ci-dessous avec la commande du menu Code|Reformat Code.
rgamma_ar <- function(n, shape, rate = 1, scale = 1/rate)
{
    if (shape <= 0 | shape >= 1)
        stop("valeur de shape inadmissible")

    ratio <- function(x)
        if (x <= 1) exp(-x) else x^(shape - 1)

    Ginv <- function(x)
    {
        k <- 1 + shape * exp(-1)
        if (x <= 1/k)
            (k * x)^(1/shape)
        else
            -log(((1/shape) + exp(-1)) * (1 - x))
    }

    i <- 0
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
        {
            x <- c(x, y)
            i <- i + 1
        }
    }
    x * scale
}

###
### STYLE
###

## Il y a quelque chose à redire sur le style de cette
## fonction? Pourtant, les noms d'objets sont raisonnables, le
## coeur de la fonction n'est pas inutilement placé dans une
## clause 'else' après le test de validité de l'argument
## 'shape', deux calculs plus lourds sont relégués à des
## fonctions internes...
##
## Si vous y regardez de très près, vous constaterez que la
## fonction ci-dessus souffre du Syndrôme de la plaque à
## biscuits(TM).
##
## En effet, les valeurs acceptées dans la simulation sont
## placées à la suite du vecteur 'x' dans l'expression 'x <-
## c(x, y)', le faisant constamment croître.
##
## Pour régler ce problème, il faut définir un contenant et y
## placer les valeurs simulées au fur et à mesure qu'elles
## sont acceptées.
##
## Nous en profitons pour combiner les opérations, assez
## communes, d'affectation et d'incrémentation du compteur.
rgamma_ar <- function(n, shape, rate = 1, scale = 1/rate)
{
    if (shape <= 0 | shape >= 1)
        stop("valeur de shape inadmissible")

    ratio <- function(x)
        if (x <= 1) exp(-x) else x^(shape - 1)

    Ginv <- function(x)
    {
        k <- 1 + shape * exp(-1)
        if (x <= 1/k)
            (k * x)^(1/shape)
        else
            -log(((1/shape) + exp(-1)) * (1 - x))
    }

    x <- numeric(n)
    i <- 0
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}

###
### COMMENTAIRES
###

## Dernier élément manquant dans notre code: les commentaires.
##
## Vous trouverez ci-dessous un modèle de documentation du
## code inspiré de la struture des rubriques d'aide de R.

###
### rgamma_ar(n, shape, rate = 1, scale = 1/rate)
###
##  Simule des observations de la distribution gamma avec
##  paramètre de forme entre 0 et 1 par la méthode
##  d'acceptation-rejet.
##
##  Arguments
##
##  n: nombre d'observations à simuler;
##  shape: paramètre de forme de la distribution;
##    0 < shape < 1;
##  rate: autre façon de spécifier l'échelle de la
##    distribution;
##  scale: paramètre d'échelle de la distribution (strictement
##    positif);
##
##  Valeur
##
##  Vecteur d'observations d'une distribution gamma.
##
rgamma_ar <- function(n, shape, rate = 1, scale = 1/rate)
{
    ## Vérification de la validité de 'shape'
    if (shape <= 0 | shape >= 1)
        stop("valeur de shape inadmissible")

    ## Fonction pour calculer la valeur du ratio f(x)/(c g(x))
    ## utilisé dans le test d'acceptation-rejet.
    ratio <- function(x)
        if (x <= 1) exp(-x) else x^(shape - 1)

    ## Fonction pour générer une valeur y à partir d'un nombre
    ## uniforme u.
    Ginv <- function(x)
    {
        k <- 1 + shape * exp(-1)
        if (x <= 1/k)
            (k * x)^(1/shape)
        else
            -log(((1/shape) + exp(-1)) * (1 - x))
    }

    ## La méthode d'acceptation-rejet commande d'utiliser une
    ## boucle 'while' puisque nous ne savons pas d'avance
    ## combien de valeurs simulées seront acceptées.
    x <- numeric(n)  # contenant pour les valeurs simulées
    i <- 0           # compteur du nombre de valeurs acceptées
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }

    ## Les valeurs dans 'x' proviennent d'une distribution
    ## Gamma(shape, 1). Il faut les retourner sur la bonne
    ## échelle.
    x * scale
}
