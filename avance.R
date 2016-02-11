## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### FONCTION 'apply'
###

## Création d'une matrice et d'un tableau à trois dimensions
## pour les exemples.
m <- matrix(sample(1:100, 20), nrow = 4, ncol = 5)
a <- array(sample(1:100, 60), dim = 3:5)

## Les fonctions 'rowSums', 'colSums', 'rowMeans' et
## 'colMeans' sont des raccourcis pour des utilisations
## fréquentes de 'apply'.
rowSums(m)                 # somme par ligne
apply(m, 1, sum)           # idem, mais moins lisible
colMeans(m)                # somme par colonne
apply(m, 2, mean)          # idem, mais moins lisible

## Puisqu'il n'existe pas de fonctions comme 'rowMax' ou
## 'colProds', il faut utiliser 'apply'.
apply(m, 1, max)           # maximum par ligne
apply(m, 2, prod)          # produit par colonne

## L'argument '...' de 'apply' permet de passer des arguments
## à la fonction FUN.
m[sample(1:20, 5)] <- NA   # ajout de données manquantes
apply(m, 1, var, na.rm = TRUE) # variance par ligne sans NA

## Lorsque 'apply' est utilisée sur un tableau, son résultat
## est de dimensions dim(X)[MARGIN], d'où le truc
## mnémotechnique donné dans le texte du chapitre.
apply(a, c(2, 3), sum)     # le résultat est une matrice
apply(a, 1, prod)          # le résultat est un vecteur

## L'utilisation de 'apply' avec les tableaux peut rapidement
## devenir confondante si l'on ne visualise pas les calculs
## qui sont réalisés. On reprend ici les exemples du chapitre
## en montrant comment l'on calculerait le premier élément de
## chaque utilisation de 'apply'. Au besoin, retourner à
## l'indiçage des tableaux au chapitre 2.
(x <- array(sample(1:10, 80, rep = TRUE), c(3, 3, 4)))
apply(x, 3, det)      # déterminants des quatre matrices 3 x 3
det(x[, , 1])         # équivalent pour le premier déterminant

apply(x, 1, sum)      # sommes des trois tranches horizontales
sum(x[1, , ])         # équivalent pour la première somme

apply(x, c(1, 2), sum) # sommes des neuf carottes horizontales
sum(x[1, 1, ])         # équivalent pour la première somme

apply(x, c(1, 3), sum) # sommes des 12 carottes transversales
sum(x[1, , 1])         # équivalent pour la première somme

apply(x, c(2, 3), sum) # sommes des 12 carottes verticales
sum(x[, 1, 1])         # équivalent pour la première somme

###
### FONCTIONS 'lapply' ET 'sapply'
###

## La fonction 'lapply' applique une fonction à tous les
## éléments d'un vecteur ou d'une liste et retourne une liste,
## peu importe les dimensions des résultats. La fonction
## 'sapply' retourne un vecteur ou une matrice, si possible.
##
## Somme «interne» des éléments d'une liste.
(x <- list(1:10, c(-2, 5, 6), matrix(3, 4, 5)))
sum(x)                     # erreur
lapply(x, sum)             # sommes internes (liste)
sapply(x, sum)             # sommes internes (vecteur)

## Création de la suite 1, 1, 2, 1, 2, 3, 1, 2, 3, 4, ..., 1,
## 2, ..., 9, 10.
lapply(1:10, seq)          # le résultat est une liste
unlist(lapply(1:10, seq))  # le résultat est un vecteur

## Soit une fonction calculant la moyenne pondérée d'un
## vecteur. Cette fonction prend en argument une liste de deux
## éléments: 'donnees' et 'poids'.
fun <- function(x)
    sum(x$donnees * x$poids)/sum(x$poids)

## On peut maintenant calculer la moyenne pondérée de
## plusieurs ensembles de données réunis dans une liste
## itérée.
(x <- list(list(donnees = 1:7,
                poids = (5:11)/56),
           list(donnees = sample(1:100, 12),
                poids = 1:12),
           list(donnees = c(1, 4, 0, 2, 2),
                poids = c(12, 3, 17, 6, 2))))
sapply(x, fun)             # aucune boucle explicite!

###
### EXEMPLES ADDITIONNELS SUR L'UTILISATION DE L'ARGUMENT
### '...' AVEC 'lapply' ET 'sapply'
###

## Aux fins des exemples ci-dessous, on crée d'abord une liste
## formée de nombres aléatoires. Cette expression fait usage
## de l'argument '...' de 'lapply'. Pouvez-vous la décoder?
## Nous y reviendrons plus loin, ce qui compte pour le moment
## c'est simplement de l'exécuter.
x <- lapply(c(8, 12, 10, 9), sample, x = 1:10, replace = TRUE)

## Soit maintenant une fonction qui calcule la moyenne
## arithmétique des données d'un vecteur 'x' supérieures à une
## valeur 'y'. On remarquera que cette fonction n'est pas
## vectorielle pour 'y', c'est-à-dire qu'elle n'est valide que
## lorsque 'y' est un vecteur de longueur 1.
fun <- function(x, y) mean(x[x > y])

## Pour effectuer ce calcul sur chaque élément de la liste
## 'x', nous pouvons utiliser 'sapply' plutôt que 'lapply',
## car chaque résultat est de longueur 1. Cependant, il faut
## passer la valeur de 'y' à la fonction 'fun'. C'est là
## qu'entre en jeu l'argument '...' de 'sapply'.
sapply(x, fun, 7)          # moyennes des données > 7

## Les fonctions 'lapply' et 'sapply' passent tout à tour les
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
## est tout à fait équivalent à fun(7, x). Pour effectuer les calculs
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
## Toujours selon les règles d'appariement des arguments, on
## voit que les valeurs 8, 12, 10, 9 seront attribuées à
## l'argument 'size', soit la taille de l'échantillon.
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

###
### FONCTION 'mapply'
###

## Création de quatre échantillons aléatoires de taille 12.
x <- lapply(rep(12, 4), sample, x = 1:100)

## Moyennes tronquées à 0, 10, 20 et 30%, respectivement, de
## ces quatre échantillons aléatoires.
mapply(mean, x, 0:3/10)

###
### FONCTION 'replicate'
###

## La fonction 'replicate' va répéter un certain nombre de
## fois une expression quelconque. Le principal avantage de
## 'replicate' sur 'sapply' est qu'on n'a pas à se soucier des
## arguments à passer à une fonction.
##
## Par exemple, on veut simuler dix échantillons aléatoires
## indépendants de longueur 12. On peut utiliser 'sapply',
## mais la syntaxe n'est ni élégante, ni facile à lire
## (l'argument 'i' ne sert à rien).
sapply(rep(1, 10), function(i) sample(1:100, 12))

## En utilisant 'replicate', on sait tout de suite de quoi il
## s'agit. À noter que les échantillons se trouvent dans les
## colonnes de la matrice résultante.
replicate(10, sample(1:100, 12))

## Vérification que la moyenne arithmétique (bar{X}) est un
## estimateur sans biais de la moyenne de la loi normale. On
## doit calculer la moyenne de plusieurs échantillons
## aléatoires, puis la moyenne de toutes ces moyennes.
##
## On définit d'abord une fonction pour faire une simulation.
## Remarquer que dans la fonction ci-dessous, 'mean' est tour
## à tour le nom d'un argument (qui pourrait aussi bien être
## «toto») et la fonction pour calculer une moyenne.
fun <- function(n, mean, sd)
    mean(rnorm(n, mean = mean, sd = sd))

## Avec 'replicate', on fait un grand nombre de simulations.
x <- replicate(10000, fun(100, 0, 1)) # 10000 simulations
hist(x)                    # distribution de bar{X}
mean(x)                    # moyenne de bar{X}

###
### CLASSES ET FONCTIONS GÉNÉRIQUES
###

## Pour illustrer les classes et fonctions génériques, on
## reprend la fonction de point fixe 'fp3' des exemples du
## chapitre 5 en y faisant deux modifications:
##
##   1. ajout d'un compteur pour le nombre d'itérations;
##   2. la fonction retourne une liste de classe 'fp'
##      contenant diverses informations relatives à la
##      procédure de point fixe.
##
## Ainsi, la fonction 'fp4' retourne un objet qui peut ensuite
## être manipulé par des méthodes de fonctions génériques.
## C'est l'approche de programmation objet favorisée dans le
## langage R.
fp4 <- function(FUN, start, echo = FALSE, TOL = 1E-10)
{
    x <- start             # valeur de départ
    i <- 0                 # compteur des itérations

    if (echo)
        expr <- expression(print(xt <- x))
    else
        expr <- expression(xt <- x)

    repeat
    {
        eval(expr)

        x <- FUN(xt)       # nouvelle valeur
        i <- i + 1         # incrémenter le compteur

        if (abs(x - xt)/xt < TOL)
            break
    }

    structure(list(fixed.point = x, # point fixe
                   nb.iter = i,     # nombre d'itérations
                   fun = FUN,       # fonction f(x)
                   x0 = start,      # valeur de départ
                   TOL = TOL),      # précision relative
              class = "fp")
}

## On crée maintenant des méthodes pour la classe 'fp' pour
## les fonctions génériques les plus courantes, soit 'print',
## 'summary' et 'plot'.
##
## La méthode de 'print' sera utilisée pour afficher seulement
## la valeur du point fixe. C'est en quelque sorte
## l'utilisation la plus simple de la fonction 'fp4'.
##
## La méthode de 'summary' fournira un peu plus d'informations
## sur la procédure de point fixe.
##
## Enfin, la méthode de 'plot' fera un graphique de la
## fonction f(x) et son intersection avec la droite y = x.
print.fp <- function(x)
    print(x$fixed.point)

summary.fp <- function(x)
{
    if (class(x) != "fp")
        stop("object is not of class 'fp'")
    cat("Function:\n ")
    print(x$fun)
    cat("\n")
    cat("Fixed point:\n ", x$fixed.point, fill = TRUE)
    cat("\n")
    cat("Number of iterations:\n ", x$nb.iter, fill = TRUE)
    cat("\n")
    cat("Precision:\n ", x$TOL, fill = TRUE)
}

plot.fp <- function(x, ...)
{
    ## Valeur du point fixe
    fp <- x$fixed.point

    ## Il faut déterminer un intervalle pour lequel tracer la
    ## fonction. Celui-ci est déterminé de façon arbitraire
    ## comme un multiple de la distance entre la valeur de
    ## départ et la valeur du point fixe.
    r <- abs(x$x0 - fp)

    ## Fonction à tracer
    FUN <- x$fun

    ## Fonction y = x. 'FUN2' est nécessaire parce que 'curve'
    ## n'admet pas de fonctions anonymes en argument.
    FUN2 <- function(x) x

    ## Graphique de la fonction 'FUN'
    curve(FUN, from = fp - 3 * r, to = fp + 3 * r,
          xlab = "x", ylab = "f(x)", lwd = 2)

    ## Ajout de la droite 'FUN2' au graphique
    curve(FUN2, add = TRUE, lwd = 1)

    ## Ajout d'un point sur le point fixe
    points(fp, FUN(fp), ...)
}

## Exemples d'utilisation
x <- fp4(function(x) 3^(-x), start = 0.5)
x                          # affichage de 'print.fp'
summary(x)                 # plus d'information
plot(x)                    # graphique de base
plot(x, pch = 21,          # graphique plus élaboré...
     bg = "orange",        # ... consulter la rubrique
     cex = 2, lwd = 2)     # ... d'aide de 'par'

###
### OPÉRATEURS EN TANT QUE FONCTIONS
###

## Les opérateurs représentés par des caractères spéciaux sont
## des fonctions comme les autres. On peut donc les appeler
## comme toute autre fonction. (En fait, l'interprète R fait
## cette traduction à l'interne.)
x <- sample(1:100, 12)     # un vecteur
x + 2                      # appel usuel
"+"(x, 2)                  # équivalent
x[c(3, 5)]                 # extraction usuelle
"["(x, c(3, 5))            # équivalent
x[1] <- 0; x               # assignation usuelle
"[<-"(x, 2, 0)             # équivalent (à x[2] <- 0)

## D'une part, cela explique pourquoi il faut placer les
## opérateurs entre guillemets (" ") lorsqu'on les utilise
## dans les fonctions comme 'outer', 'lapply', etc.
outer(x, x, +)             # erreur de syntaxe
outer(x, x, "+")           # correct

## D'autre part, cela permet d'utiliser les opérateurs
## d'extraction "[" et "[[" dans de telles fonctions. Par
## exemple, voici comment extraire le deuxième élément de
## chaque élément d'une liste.
(x <- list(1:4, 8:2, 6:12, -2:2)) # liste quelconque
x[[1]][2]                  # 2e élément du 1er élément
x[[2]][2]                  # 2e élément du 2e élément
x[[3]][2]                  # 2e élément du 3e élément
x[[4]][2]                  # 2e élément du 4e élément
lapply(x, "[", 2)          # même chose en une ligne
sapply(x, "[", 2)          # résultat sous forme de vecteur

###
### COMMENT JOUER DES TOURS AVEC R
###

## Redéfinir un opérateur dans l'espace de travail de
## quelqu'un...
"+" <- function(x, y) x * y # redéfinition de "+"
5 + 2                      # ouch!
ls()                       # traîtrise dévoilée...
rm("+")                    # ... puis éliminée
5 + 2                      # c'est mieux

## Faire croire qu'une fonction fait autre chose que ce
## qu'elle fait en réalité. Si l'attribut "source" d'une
## fonction existe, c'est son contenu qui est affiché lorsque
## l'on examine une fonction.
f <- function(x, y) x + y  # vraie fonction
attr(f, "source") <- "function(x, y) x * y" # ce qui est affiché
f                          # une fonction pour faire le produit?
f(2, 3)                    # non!
str(f)                     # structure de l'objet
attr(f, "source") <- NULL  # attribut "source" effacé
f                          # c'est mieux

## Redéfinir la méthode de 'print' pour une classe d'objet...
## Ici, l'affichage d'un objet de classe "lm" cause la
## fermeture de R!
print.lm <- function(x) q("ask")

x <- rnorm(10)             # échantillon aléatoire
y <- x + 2 + rnorm(10)     # modèle de régression linéaire
lm(y ~ x)                  # répondre "c"!
