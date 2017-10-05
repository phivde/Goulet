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
### SOLUTIONS EN R D'EXERCICES DE STEPHENS, R. 2013,
### «Essential Algorithms», Wiley.
###

## On trouvera ci-dessous des solutions en R des exercices
## suivants de Stephens (2013):
##
## Chapitre 6: 1, 3, 5, 15.
## Chapitre 7: 1, 2, 4, 5.
## Chapitre 9: 1, 2.

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
## remise selon la valeur de 'replace'.
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
## chaque itération de la première boucle, trouver le minimum
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

## L'algorithme fait graduellement «remonter à la surface» les
## plus petites valeurs du vecteur. Il faut comparer deux
## valeurs adjacentes tant que le vecteur n'est pas trié.
##
## Par nature, l'algorithme requiert deux boucles: une pour
## comparer les valeurs deux à deux, et une autre pour
## continuer le travail tant que le vecteur n'est pas trié.
##
## Une première version de la mise en œuvre colle de près à
## l'algorithme de Stephens (2013).
bubblesort <- function(x)
{
    ind <- 2:length(x)     # suite sert souvent

    not_sorted <- TRUE     # entrer dans la boucle
    while (not_sorted)
    {
        not_sorted <- FALSE
        for (i in ind)
        {
            j <- i - 1
            if (x[i] < x[j])
            {
                x[c(i, j)] <- x[c(j, i)]
                not_sorted <- TRUE
                next
            }
        }
    }
    x
}

## Test
(x <- sample(0:10, 7, replace = TRUE))
bubblesort(x)

## Dans la version ci-dessus, il faut changer la variable
## indicatrice 'not_sorted' plusieurs fois, dont une pour
## s'assurer d'effectuer la boucle 'while' au moins une fois.
##
## La seconde mise œuvre, ci-dessous, est rendue plus facile à
## suivre par l'utilisation d'une boucle 'repeat', qui est
## toujours exécutée au moins une fois. Au passage, nous
## inversons également le rôle de la variable indicatrice pour
## éviter les déroutantes doubles négations.
bubblesort <- function(x)
{
    ind <- 2:length(x)      # sert souvent

    repeat
    {
        sorted <- TRUE
        for (i in ind)
        {
            j <- i - 1
            if (x[i] < x[j])
            {
                x[c(i, j)] <- x[c(j, i)]
                sorted <- FALSE
                next
            }
        }
        if (sorted)
            break
    }
    x
}

## Test
(x <- sample(0:10, 7, replace = TRUE))
bubblesort(x)

### EXERCICE 15 - Mise en œuvre de l'algorithme countingsort

## L'algorithme compte le nombre d'occurrences de chaque
## valeur dans le vecteur pour ensuite les retourner dans le
## bon ordre et le bon nombre de fois.
##
## Notre première mise en œuvre utilise une boucle pour passer
## à travers toutes les valeurs du vecteur. Elle est un peu
## plus générale que l'algorithme de Stephens (2013) dans la
## mesure où elle fonctionne pour des nombres en 'min' et 'max'
## plutôt que uniquement entre 0 et 'max'. (Nous répondons donc
## en même temps à l'exercice 16.)
##
## La clé ici pour éviter certaines boucles de l'algorithme:
## la fonction 'rep' qui permet de répéter les valeurs d'un
## vecteur autant de fois que nécessaire.
##
## NOTE: la fonction 'seq_along' est essentiellement
## équivalente à '1:length(x)', mais plus efficace.
countingsort <- function(x, min, max)
{
    min1m <- min - 1               # sert souvent
    counts <- numeric(max - min1m) # initialisation

    for (i in seq_along(x))
    {
        j <- x[i] - min1m
        counts[j] <- counts[j] + 1
    }

    ## suite des nombres de 'min' à 'max' répétés chacun le
    ## bon nombre de fois
    rep(min:max, counts)
}

## Test
(x <- sample(10:20, 100, replace = TRUE))
countingsort(x, 10, 20)

## La seconde mise en œuvre ci-dessous triche un peu: elle
## utilise la fonction 'table' de R qui retourne justement le
## tableau de fréquence de chaque valeur d'un vecteur.
## Résultat: plus de boucle! Cela dit, c'est un exercice bien
## artificiel puisque 'table' elle-même trie les données...
countingsort <- function(x, min, max)
    rep(min:max, table(x))

## Test
(x <- sample(10:20, 100, replace = TRUE))
countingsort(x, 10, 20)

###
### CHAPITRE 7
###

### EXERCICE 1 - Mise en œuvre de l'algorithme «linear search»

## L'algorithme compare une à une les valeurs du vecteur à
## celle qui est recherchée. Ceci requiert une boucle.
##
## Notre version de la mise en œuvre de l'algorithme retourne
## 'NA' plutôt que -1 lorsque la valeur n'est pas trouvée,
## comme c'est l'usage en R.
linsearch <- function(target, x)
{
    for (i in seq_along(x))
    {
        if (x[i] == target)
            return(i)
        if (x[i] > target)
            return(NA)
    }
    NA                     # valeur non trouvée
}

## Test
x <- c(4, 5, 7, 9, 9, 11, 11, 12, 16, 19)
linsearch(7, x)
linsearch(10, x)
linsearch(21, x)

### EXERCICE 2 - Mise en œuvre récursive de l'algorithme
###              «linear search»

## En version récursive, l'algorithme de recherche linéaire
## revient à vérifier si la valeur courante du vecteur est la
## valeur recherchée et, sinon, à recommencer le même
## processus à partir de la valeur suivante du vecteur.
##
## Nous proposons deux mises en œuvre. La première a recours à
## une fonction auxiliaire qui garde le compte de la
## progression dans le vecteur.
##
## Remarquez comment la portée lexicale de R fait en sorte que
## nous n'avons pas à passer les variables 'x', 'target' et
## 'xlen' à la fonction auxiliaire.
rlinsearch <- function(target, x)
{
    xlen <- length(x)
    fun <- function(i)
    {
        if (i > xlen)
            return(NA)
        if (x[i] == target)
            return(i)
        if (x[i] > target)
            return(NA)
        fun(i + 1)
    }
    fun(1)
}

## Test
x <- c(4, 5, 7, 9, 9, 11, 11, 12, 16, 19)
rlinsearch(7, x)
rlinsearch(10, x)
rlinsearch(21, x)

## La seconde mise en œuvre est un peu plus simple, mais,
## comme la position de la valeur recherchée dans le vecteur
## est calculée, elle repose sur le fait que tout calcul avec
## 'NA' retourne 'NA'.
rlinsearch <- function(target, x)
{
    if (length(x) == 0)
        return(NA)
    if (x[1] == target)
        return(1)
    if (x[1] > target)
        return(NA)
    1 + rlinsearch(target, x[-1])
}

## Test
x <- c(4, 5, 7, 9, 9, 11, 11, 12, 16, 19)
rlinsearch(7, x)
rlinsearch(10, x)
rlinsearch(21, x)

### EXERCICE 4 - Mise en œuvre de l'algorithme «binary search»

## L'algorithme coupe en deux l'intervalle dans lequel la
## valeur recherchée pourrait se trouver jusqu'à ce qu'il ne
## reste que la valeur recherchée ou un intervalle vide,
## auquel cas la valeur ne se trouve pas dans le vecteur.
##
## Attention à une chose: dans l'algorithme de Stephens
## (2013), il est spécifié que le résultat du calcul
##
##   mid = (min + max)/2
##
## doit être un entier (integer). Dans R, nous pouvons obtenir
## ce résultat avec 'as.integer' ou, plus simplement, en
## calculant la partie entière du résultat avec 'floor'.
binsearch <- function(target, x)
{
    min <- 1
    max <- length(x)

    while(min <= max)
    {
        mid <- floor((min + max)/2)
        if (target < x[mid])
            max <- mid - 1
        else if (target > x[mid])
            min <- mid + 1
        else
            return(mid)
    }
    NA                     # valeur non trouvée
}

## Test
x <- c(4, 5, 7, 9, 9, 11, 11, 12, 16, 19)
binsearch(7, x)
binsearch(10, x)
binsearch(21, x)


### EXERCICE 5 - Mise en œuvre récursive de l'algorithme
###              «binary search»

## La mise en œuvre récursive la plus simple, ici, utilise une
## fonction auxiliaire.
##
## Remarquez comment une fonction récursive ('fun' dans le cas
## présent) doit toujours --- normalement dès le départ ---
## contenir un critère d'arrêt des récursions. Autrement, le
## processus se répète à l'infini.
rbinsearch <- function(target, x)
{
    fun <- function(min, max)
    {
        if (min > max)
            return(NA)
        mid <- floor((min + max)/2)
        if (target < x[mid])
            fun(min, mid - 1)
        else if (target > x[mid])
            fun(mid + 1, max)
        else
            return(mid)
    }
    fun(1, length(x))
}

## Test
x <- c(4, 5, 7, 9, 9, 11, 11, 12, 16, 19)
rbinsearch(7, x)
rbinsearch(10, x)
rbinsearch(21, x)

###
### CHAPITRE 9
###

### EXERCICE 1 - Mise en œuvre récursive de la factorielle

## Nous avons déjà donné cette fonction en exemple dans le
## chapitre 2 du document de référence.
factorial <- function(n)
    if (n == 0) 1 else n * factorial(n - 1)

## Test
factorial(0)
factorial(1)
factorial(5)

### EXERCICE 2 - Mise en œuvre récursive de la suite de
###              Fibonacci

## L'algorithme de base pour calculer un élément de la suite
## de Fibonnacci de manière récursive est très lent parce que
## plusieurs valeurs sont calculées à de multiples reprises.
fibonacci <- function(n)
    if (n <= 1) n else fibonacci(n - 1) + fibonacci(n - 2)

## Test
fibonacci(0)
fibonacci(1)
fibonacci(2)
fibonacci(5)
fibonacci(10)
fibonacci(30)              # déjà lent
fibonacci(35)              # long
fibonacci(40)              # à vos risques et périls
