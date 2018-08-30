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
### PROGRAMMATION FONCTIONNELLE  `\labelline{fonctions:paradigme}`
###

## Les fonctions sont des objets comme les autres dans R. Cela
## signifie que:
##
## - le contenu d'une fonction (son code source) est toujours
##   accessible;
## - une fonction peut accepter en argument une autre
##   fonction;
## - une fonction peut retourner une fonction comme résultat;
## - l'utilisateur peut définir de nouvelles fonctions.
seq                        # contenu est le code source
mode(seq)                  # mode est "function"
rep(seq(5), 3)             # fonction argument d'une fonction
lapply(1:5, seq)           # idem
mode(ecdf(rpois(100, 1)))  # résultat de ecdf est une fonction
ecdf(rpois(100, 1))(5)     # évaluation en un point
c(seq, rep)                # vecteur de fonctions!  `\labelline{fonctions:paradigme:fin}`

###
### DÉFINITION D'UNE FONCTION  `\labelline{fonctions:definition}`
###

## On définit une nouvelle fonction avec la syntaxe suivante:
##
##   <nom> <- function(<arguments>) <corps>
##
## où
##
## - 'nom' est le nom de la fonction;
## - 'arguments' est la liste des arguments, séparés par des
##    virgules;
## - 'corps' est le corps de la fonction, soit une expression
##   ou un groupe d'expressions réunies par des accolades { }.
##
## Une fonction retourne toujours la valeur de la *dernière*
## expression de celle-ci.
##
## Voici un exemple trivial.
square <- function(x) x * x
square(10)

## Supposons que l'on veut écrire une fonction pour calculer
##
##   f(x, y) = x (1 + xy)^2 + y (1 - y) + (1 + xy)(1 - y).
##
## Deux termes sont répétés dans cette expression. On a donc
##
##   a = 1 + xy
##   b = 1 - y
##
## et f(x, y) = x a^2 + yb + ab.
##
## Une manière élégante de procéder au calcul de f(x, y) qui
## adopte l'approche fonctionnelle fait appel à une fonction
## intermédiaire à l'intérieur de la première fonction. (Il y
## a ici des enjeux de «portée lexicale» sur lesquels nous
## reviendrons en détail au chapitre 4.)
f <- function(x, y)
{
    g <- function(a, b)
        x * a^2 + y * b + a * b
    g(1 + x * y, 1 - y)
}
f(2, 3)

### FONCTION ANONYME

## Comme le nom du concept l'indique, une fonction anonyme est
## une fonction qui n'a pas de nom. C'est parfois utile pour
## des fonctions courtes utilisées dans une autre fonction.
##
## Reprenons l'exemple précédent en généralisant les
## expressions des termes 'a' et 'b'. La fonction 'f'
## pourrait maintenant prendre en arguments 'x', 'y' et des
## fonctions pour calculer 'a' et 'b'.
f <- function(x, y, fa, fb)
{
    g <- function(a, b)
        x * a^2 + y * b + a * b
    g(fa(x, y), fb(x, y))
}

## Plutôt que de définir deux fonctions pour les arguments
## 'fa' et 'fb', on passe directement des fonctions anonymes
## en argument.
f(2, 3,
  function(x, y) 1 + x * y,
  function(x, y) 1 - y)

### VALEUR PAR DÉFAUT D'UN ARGUMENT

## La fonction suivante calcule la distance entre deux points
## dans l'espace euclidien à 'n' dimensions, par défaut par
## rapport à l'origine.
##
## Remarquez comment nous spécifions une valeur par défaut,
## l'origine, pour l'argument 'y'.
##
## (Note: la fonction 'sum'... somme tous les éléments d'un
## vecteur.)
dist <- function(x, y = 0) sum((x - y)^2)

## Quelques calculs de distances.
dist(c(1, 1))                # (1, 1) par rapport à l'origine
dist(c(1, 1, 1), c(3, 1, 2)) # entre (1, 1, 1) et (3, 1, 2)

### ARGUMENT '...'

## Nous illustrons l'utilisation de l'argument '...' de la
## manière suivante pour le moment. Nous utiliserons davantage
## cet argument avec les fonctions d'application.
##
## La fonction 'curve' prend en argument une expression
## mathématique et trace la fonction pour un intervalle donné.
curve(x^2, from = 0, to = 2)

## Nous souhaitons, pour une raison quelconque, que tous nos
## graphiques de ce type (et seulement de ce type) soient
## tracés en orange.
curve(x^2, from = 0, to = 2, col = "orange")

## Plutôt que de redéfinir entièrement la fonction 'curve'
## avec tous ses arguments (et il y en a plusieurs), nous
## pouvons écrire une petite fonction qui, grâce à l'argument
## '...', accepte tous les arguments de 'curve'.
ocurve <- function(...) curve(..., col = "orange")
ocurve(x^2, from = 0, to = 2)           #-*- `\labelline{fonctions:definition:fin}`

###
### STRUCTURES DE CONTRÔLE  `\labelline{fonctions:controle}`
###

### EXÉCUTION CONDITIONNELLE

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

### BOUCLES ITÉRATIVES ET CONTRÔLE DU FLUX

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
sqrt(3047)                              #-*- `\labelline{fonctions:controle:fin}`

###
### BONNES PRATIQUES DE LA PROGRAMMATION INFORMATIQUE  `\labelline{fonctions:pratiques}`
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

### PRÉSENTATION DU CODE

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

### STYLE

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

### COMMENTAIRES

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
}                                       #-*- `\labelline{fonctions:pratiques:fin}`
