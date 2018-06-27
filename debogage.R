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

## Ce fichier fournit le code utile pour refaire les exemples
## du chapitre.

###
### VÉRIFICATION DE LA SYNTAXE
###

## Code de la fonction 'rgamma_ar' avec des bogues, tel que
## présenté à la figure 10.1.
##
## Refaire l'indentation de la fonction avec votre éditeur
## pour programmeur. Cela devrait immédiatement faire
## ressortir qu'il manque une parenthèse dans l'appel à la
## fonction 'Ginv', à l'intérieur de la boucle 'while'.
rgamma_ar <- function(n, shape, rate = 1; scale = 1/rate)
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
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1)
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}


} # effacer

## La parenthèse manquante a été ajoutée dans la définition
## ci-dessous.
##
## Essayez de définir la fonction dans l'espace de travail.
## L'interpréteur R devrait attraper l'erreur de syntaxe à la
## toute première ligne, soit le ';' en lieu et place d'une
## ','.
rgamma_ar <- function(n, shape, rate = 1; scale = 1/rate)
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
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}

## L'erreur de syntaxe est maintenant corrigée.
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
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}

## Nous ne sommes pas sortis du bois: l'appel de la fonction
## ci-dessous retourne une valeur de 0, ce qui n'est pas une
## valeur admissible pour une distribution gamma.
rgamma_ar(5, 0.5, 1)

## Vérification avec d'autres valeurs des arguments. Le bogue
## est aisément reproductible.
rgamma_ar(5, 0.5, 1)
rgamma_ar(5, 0.8, 1)
rgamma_ar(5, 0.5, 2)
rgamma_ar(10, 0.5, 1)
rgamma_ar(1, 0.5, 1)

###
### AFFICHAGE DE RÉSULTATS INTERMÉDIAIRES
###

## Afin de découvrir le bogue de la fonction, nous ajoutons
## une commande 'print' à l'intérieur de la boucle 'while'.
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
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
        {
            print(paste("valeur de y acceptée:", y))
            x[i <- i + 1] <- y
            print(c(i, x))
        }
    }
    x * scale
}

## L'exécution de la commande ci-dessous permet de détecter
## que lorsqu'une première valeur de 'y' est acceptée, elle
## est placée en deuxième position dans le vecteur des
## résultats 'x'. Ah! Ha! Le compteur 'i' est soit incrémenté
## trop tôt, soit initialisé une unité trop haut.
rgamma_ar(5, 0.5, 1)

## Nous corrigeons la fonction ainsi: le compteur 'i' est
## initialisé à 0 plutôt qu'à 1.
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
### ÉVALUATION PAS-À-PAS
###

## La technique d'évaluation pas-à-pas consiste à définir tous
## les arguments de la fonction dans l'espace de travail, puis
## à exécuter le corps de la fonction ligne par ligne.
##
## Évaluons l'équivalent de l'appel 'rgamma_ar(5, 0.5, 1)'
## pas-à-pas avec le bogue 'i <- 1' remis en place.
##
## Explorez les valeurs des objets 'x', 'i' et 'y' après
## l'évaluation de chaque expression, ci-dessous (ou, plus
## précisément, lorsque c'est pertinent).
n <- 5
shape <- 0.5
scale <- 1

## rgamma_ar <- function(n, shape, rate = 1, scale = 1/rate)
## {
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
    i <- 1
    ## while (i < n)
    ## {
        y <- Ginv(runif(1))
        u <- runif(1)
        if (u <= ratio(y))
            x[i <- i + 1] <- y
    ## }
    x * scale
## }

###
### PILE DES APPELS DE FONCTIONS
###

## J'ai inséré un bogue additionnel dans la fonction interne
## 'Ginv' de 'rgamma_ar', ci-dessous. Définir la fonction.
rgamma_ar <- function(n, shape, rate = 1, scale = 1/rate)
{
    if (shape <= 0 | shape >= 1)
        stop("valeur de shape inadmissible")

    ratio <- function(x)
        if (x <= 1) exp(-x) else x^(shape - 1)

    Ginv <- function(x)
    {
        k <- 1 + shape * exp(-1) * variable.inconnue
        if (x <= 1/k)
            (k * x)^(1/shape)
        else
            -log(((1/shape) + exp(-1)) * (1 - x))
    }

    x <- numeric(n)
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1))
        u <- runif(1)
        if (u <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}

## Évaluer l'appel de fonction ci-dessous. Il y aura une
## erreur.
rgamma_ar(5, 0.5, 1)

## Afficher la pile des appels de fonctions. On voit que c'est
## l'appel à 'Ginv' qui cause problème.
traceback()

###
### NAVIGATEUR D'ENVIRONNEMENT
###

## La définition de la fonction 'rgamma_ar' ci-dessous
## contient un appel à la fonction 'browser'.
##
## L'appel à la fonction qui suit provoquera l'entrée dans le
## navigateur d'environnement juste avant l'évaluation de
## l'expression 'x <- numeric(n)'.
##
## L'utilisation du navigateur demande un temps d'adaptation à
## cause de la forme de déphasage que l'on observe entre
## l'affichage de la ligne qui sera évaluée et celle qui vient
## d'être évaluée.
##
## L'interface de RStudio pour utiliser le navigateur est très
## conviviale; consultez la documentation de RStudio pour un
## bon tutoriel.
##
## Également, consultez la rubrique d'aide de 'browser' pour
## connaitre les commandes disponibles à l'invite du
## navigateur.
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
    browser()
    x <- numeric(n)
    i <- 1
    while (i < n)
    {
        y <- Ginv(runif(1))
        if (runif(1) <= ratio(y))
            x[i <- i + 1] <- y
    }
    x * scale
}
rgamma_ar(5, 0.5, 1)

###
### EXEMPLE ADDITIONNEL
###

## Variation sur le thème de la suite de Fibonacci abordée
## dans le fichier 'algorithmique.R' livré avec le document:
## une fonction pour calculer non pas les 'n' premières
## valeurs de la suite de Fibonacci, mais uniquement la
## 'n'ième valeur.
##
## Mais il y a un mais: la fonction 'fibonaci', à l'instar de
## son nom même, est truffée d'erreurs (de syntaxe,
## d'algorithmique, de conception). À vous de trouver les
## bogues. (Afin de préserver cet exemple, copiez le code
## erroné plus bas ou dans un autre fichier avant d'y faire
## les corrections.)
fibonaci <- function(nb)
{
    x <- 0
    x1 _ 0
    x2 <- 1
    while (n > 0))
x <- x1 + x2
x2 <- x1
x1 <- x
n <- n - 1
}
fibonaci(1)                # devrait donner 0
fibonaci(2)                # devrait donner 1
fibonaci(5)                # devrait donner 3
fibonaci(10)               # devrait donner 34
fibonaci(20)               # devrait donner 4181


