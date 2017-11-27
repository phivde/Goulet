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
### MISE EN CONTEXTE
###

## La portée (domaine où un objet existe et comporte une
## valeur) des arguments d'une fonction et de tout objet
## défini à l'intérieur de celle-ci se limite à la fonction.
##
## Ceci signifie que l'interpréteur R fait bien la distinction
## entre un objet dans l'espace de travail et un objet utilisé
## dans une fonction (fort heureusement!).
square <- function(x) x * x  # fonction de bases.R
x <- 5                       # objet dans l'espace de travail
square(10)                   # dans 'square' x vaut 10
x                            # valeur inchangée
square(x)                    # passer valeur de 'x' à 'square'
square(x = x)                # colle... signification?

###
### ENVIRONNEMENT ET ENVIRONNEMENT D'ÉVALUATION
###

## Un environnement est un objet spécial qui contient un lien
## vers un environnement englobant (ou «parent») et un
## dictionnaire de symboles auxquels sont associés des
## valeurs (bref, des objets avec des valeurs).
##
## La création d'une fonction R (une «fermeture» en termes
## techniques) entraine automatiquement la création d'un
## environnement pour cette fonction:
##
## - l'environnement englobant est l'environnement actif (dans
##   lequel la fonction est créée);
## - le dictionnaire «capture» les objets de l'environnement
##   actif.
##
## Le cas le plus simple est celui des fonctions créées dans
## l'espace de travail .GlobalEnv.
f <- function(x) x + 2     # création d'une fonction
formals(f)                 # arguments formels
body(f)                    # corps de la fonction
environment(f)             # environnement de la fonction

## Lorsqu'une fonction est créée à l'intérieur d'une autre
## fonction, son environnement hérite automatiquement de
## toutes les variables définies dans la première fonction.
##
## L'exemple suivant devrait permettre de clarifier tout cela.
## La fonction 'f', qui a un argument 'x', retourne une
## fonction (anonyme) qui a un argument, 'y'.
f <- function(x)
    function(y) x + y

## L'appel de la fonction 'f' donne une valeur à son argument
## 'x'. À l'intérieur de cet appel, la fonction anonyme est
## créée. La valeur de 'x' est alors «capturée» dans
## l'environnement de la fonction anonyme.
##
## En affectant le résultat (une fonction, ne l'oublions pas)
## de l'appel de 'f' à un objet, celui-ci devient une fonction
## avec un environnement qui contient la fameuse valeur de
## 'x'.
g <- f(2)
ls(envir = environment(g))
get("x", envir = environment(g))
ls.str(envir = environment(g)) # plus simple

## Par conséquent, lorsque nous appelons la fonction 'g',
## l'expression 'x + y' utilise la valeur de 'x' dans
## l'environnement de la fonction et la valeur de 'y' passée
## en argument.
g(10)

## Cette capture d'objets est parfois problématique: si
## plusieurs objets existent au moment où une fonction est
## créée à l'intérieur d'une autre, tous les objets se
## trouvent transférés dans l'environnement de la nouvelle
## fonction.
##
## Dans de tels cas, nous pouvons utiliser la fonction
## 'new.env' pour créer un environnement vide et, par la
## suite, affecter des objets dans l'environnement avec la
## fonction 'assign'.
##
## Reprenons l'exemple ci-dessus en supposant que la valeur de
## 'x' que nous voulons placer dans l'environnement est non
## pas celle passée en argument, mais plutôt toujours 42.
## Parce que 42, on le sait, c'est la réponse à tout.
##
## Voici comment procéder.
f <- function(x)
{
    fun <- function(y) x + y
    environment(fun) <- new.env()
    assign("x", 42, envir = environment(fun))
    fun
}
g <- f(2)
ls.str(envir = environment(g))
g(10)

###
### PORTÉE LEXICALE
###

## Tout appel de fonction dans R crée un environnement
## d'évaluation dans lequel sont définies les variables
## locales de la fonction, y compris les arguments. Cet
## environnement d'évaluation a comme environnement englobant
## celui de la fonction.
##
## Le concept de portée lexicale signifie que lorsqu'un objet
## n'existe pas dans l'environnement d'évaluation, R va le
## rechercher dans les environnements englobants jusqu'à ce
## que soit trouvée une valeur ou jusqu'à ce que
## l'environnement vide soit atteint (auquel cas l'objet
## n'existe pas).
##
## En pratique, cela signifie qu'il n'est pas toujours
## nécessaire de passer des objets en argument. Il suffit de
## compter sur la portée lexicale.
##
## Tel que promis dans le fichier bases.R, revenons en détail
## sur la construction d'une fonction pour calculer
##
##   f(x, y) = x (1 + xy)^2 + y (1 - y) + (1 + xy)(1 - y).
##
## Deux termes sont répétés dans cette expression. On a donc
##
##   a = 1 + xy
##   b = 1 - y
##
## et f(x, y) = x a^2 + y b + a b.
##
## Nous pourrions décomposer le problème en deux fonctions:
## une première pour calculer 'x a^2 + y b + a b' pour des
## valeurs de 'x', 'y', 'a' et 'b' données, et une seconde
## pour calculer 'a = 1 + xy' et 'b = 1 - y' et les fournir à
## la première fonction.
g <- function(x, y, a, b)
    x * a^2 + y * b + a * b
f <- function(x, y)
    g(x, y, 1 + x * y, 1 - y)
f(2, 3)
f(2, 4)

## Cependant, la fonction 'g' ne sert pas à grand chose ici en
## dehors de 'f'. Nous pouvons donc plutôt la définir à
## l'intérieur de cette dernière.
f <- function(x, y)
{
    g <- function(x, y, a, b)
        x * a^2 + y * b + a * b
    g(x, y, 1 + x * y, 1 - y)
}
f(2, 3)
f(2, 4)

## La portée lexicale de R nous permet de simplifier le code:
## inutile de passer les valeurs de 'x' et 'y' à la fonction
## 'g' puisque R les trouvera automatiquement dans
## l'environnement d'évaluation de 'f'.
f <- function(x, y)
{
    g <- function(a, b)
        x * a^2 + y * b + a * b
    g(1 + x * y, 1 - y)
}
f(2, 3)
f(2, 4)

###
### ÉVALUATION PARESSEUSE
###

## L'évaluation paresseuse est une technique par laquelle un
## argument d'une fonction est évalué uniquement au moment où
## sa valeur est requise, et jamais avant.
##
## Il est sans doute raisonnable de supposer que l'objet
## 'does_not_exist' n'existe pas dans votre espace de travail.
## Avec l'évaluation paresseuse, nous pourrions passer cet
## objet inexistant en argument à une fonction sans que cela
## ne cause d'erreur... à condition que l'argument ne soit
## jamais utilisé dans la fonction.
##
## (Nous n'avons pas encore étudié les expressions
## conditionnelles, mais l'exemple ci-dessous devrait malgré
## tout être simple à suivre: la fonction 'f' retourne le
## carré de l'argument 'x' si celui-ci est supérieur à
## 0 et la valeur de l'argument 'y' sinon.)
f <- function(x, y)
    if (x > 0) x * x else y
f(5, does_not_exist)       # argument 'y' jamais utilisé
f(0, does_not_exist)       # argument 'y' utilisé
f(0, 1/0)                  # argument 'y' utilisé

## Voici un autre exemple plus intéressant tiré de Ihaka et
## Gentleman (1996).
##
## Nous savons que tout calcul avec des données manquantes
## retourne 'NA'.
##
## Nous pouvons généraliser la fonction 'sumsq' de la section
## 4.5 pour faire en sorte qu'elle puisse retirer les
## éventuelles données manquantes d'un vecteur en argument
## avant de faire la somme des écarts au carré.
##
## Grâce à l'évaluation paresseuse, les données manquantes
## seront également supprimées *avant* le calcul de la moyenne
## dans le cas où c'est la valeur par défaut de l'argument
## 'about' qui est utilisée.
sumsq <- function(y, about = mean(y), na.rm = FALSE)
{
    if (na.rm)
        y <- y[!is.na(y)]
    sum((y - about)^2)
}
sumsq(c(10, 0, NA, -10), na.rm = TRUE)
