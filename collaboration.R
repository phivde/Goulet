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

rgamma2<-function(n,shape,rate=1,scale=1/rate)
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
    {
        x<-c(x,y)<-y
        i<-i+1 }
 }
   x*scale
}

rgamma2<-function(n,shape,rate=1,scale=1/rate)
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
            x<-c(x,y)<-y
            i<-i+1
        }
    }
    x*scale
}


rgamma2 <- function(n, shape, rate = 1, scale = 1/rate)
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
            x <- c(x, y) <- y
            i <- i + 1
        }
    }
    x * scale
}

###
### rgamma2(n, shape, rate = 1, scale = 1/rate)
###
### Simule des observations de la distribution gamma avec
### paramètre de forme entre 0 et 1 par la méthode
### d'acceptation-rejet.
###
### Arguments
###
### n: nombre d'observations à simuler;
### shape: paramètre de forme de la distribution;
###   0 < shape < 1;
### rate: autre façon de spécifier l'échelle de la
###   distribution;
### scale: paramètre d'échelle de la distribution (strictement
###   positif);
###
### Valeur
###
### Vecteur d'observations d'une distribution gamma.
###
### Algorithme (pour 'scale' = 1)
###
### 1. Simuler u, v d'une distribution U(0, 1).
### 2. Calculer y = G^{-1}(u), où
###
###      G^{-1}(x) = ((a + e)/e * x)^(1/a),
###                            0 <= x <= e/(a + e)
###                = - log(((1/a) + (1/e)) * (1 - x),
###                            e/(a + e) < x <= 1.
###
###    (Note: a = 'shape'.)
### 3. Si
###
###      v <= exp(-y),    0 <= y <= 1
###        <= y^(a - 1),  y > 1
###
###    alors poser x = y. Sinon retourner à l'étape 1.
### 4. Retourner x.
###
rgamma2 <- function(n, shape, rate = 1, scale = 1/rate)
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
    ## quelle proportion de valeurs simulées seront acceptées.
    x <- numeric(n)        # contenant pour les valeurs simulées
    i <- 0
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }

    ## Les valeurs dans 'x' proviennent d'une distribution
    ## Gamma(shape, 1). Il faut les retouner sur la bonne
    ## échelle.
    x * scale
}
