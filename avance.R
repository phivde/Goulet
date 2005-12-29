###
### FONCTION 'apply'
###

## Création d'une matrice et d'un tableau à trois dimensions
## pour les exemples.
m <- matrix(sample(1:100, 20), nrow=4, ncol=5)
a <- array(sample(1:100, 60), dim=3:5)

## Les fonctions 'rowSums', 'colSums', 'rowMeans' et
## 'colMeans' sont des raccourcis pour des utilisations
## fréquentes de 'apply'.
rowSums(m)
apply(m, 1, sum)
colMeans(m)
apply(m, 2, mean)

## Puisqu'il n'existe pas de fonctions comme 'rowMax' ou
## 'colProds', il faut utiliser 'apply'.
apply(m, 1, max)           # maximum par ligne
apply(m, 2, prod)          # produit par colonne

## L'argument '...' de 'apply' permet de passer des arguments
## à la fonction FUN.
m[sample(1:20, 5)] <- NA   # ajout de données manquantes
apply(m, 1, var, na.rm=TRUE) # variance par ligne sans NA

## Lorsque 'apply' est utilisée sur un tableau, son résultat
## est de dimensions dim(X)[MARGIN].
apply(a, c(2, 3), sum)     # le résultat est une matrice
apply(a, 1, prod)          # le résultat est un vecteur

###
### FONCTIONS 'lapply' ET 'sapply'
###

## La fonction 'lapply' applique une fonction à tous les
## éléments d'une liste et retourne une liste, peu importe les
## dimensions des résultats. La fonction 'sapply' retourne un
## vecteur ou une matrice, si possible.
##
## Somme «interne» des éléments d'une liste.
( liste <- list(1:10,
                c(-2, 5, 6),
                matrix(3, 4, 5)) )
sum(liste)                 # erreur
lapply(liste, sum)         # sommes internes (liste)
sapply(liste, sum)         # sommes internes (vecteur)

## Création de la suite 1, 1, 2, 1, 2, 3, 1, 2, 3, 4, ..., 1,
## 2, ..., 9, 10.
lapply(1:10, seq)          # le résultat est une liste
unlist(lapply(1:10, seq))  # le résultat est un vecteur

## Soit une fonction calculant la moyenne pondérée d'un
## vecteur. Cette fonction prend en argument une liste de deux
## éléments: 'donnees' et 'poids'.
fun <- function(liste)
    sum(liste$donnees * liste$poids)/sum(liste$poids)

## On peut maintenant calculer la moyenne pondérée de
## plusieurs ensembles de données réunis dans une liste
## itérée.
( a <- list(list(donnees=1:7,
                 poids=(5:11)/56),
            list(donnees=sample(1:100, 12),
                 poids=1:12),
            list(donnees=c(1, 4, 0, 2, 2),
                 poids=c(12, 3, 17, 6, 2))) )
sapply(a, fun)

###
### FONCTION 'mapply'
###

## Création de quatre échantillons aléatoires de taille 12.
a <- lapply(rep(12, 4), sample, x=1:100)

## Moyennes tronquées à 0, 10, 20 et 30%, respectivement, de
## ces quatre échantillons aléatoires.
mapply(mean, a, 0:3/10)

###
### FONCTION 'replicate'
###

## La fonction 'replicate' va répéter un certain nombre de
## fois une expression quelconque. Le principal avantage de
## 'replicate' par rapport à 'sapply' est qu'on n'a pas à se
## soucier des arguments à passer à une fonction.
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
fun <- function(n, mean, sd)
    mean(rnorm(n, mean=mean, sd=sd))

## Avec 'replicate', on fait un grand nombre de simulations.
res <- replicate(10000, fun(100, 0, 1)) # 10000 simulations
hist(res)                  # distribution de bar{X}
mean(res)                  # moyenne de bar{X}

###
### CLASSES ET FONCTIONS GÉNÉRIQUES
###

## Afin d'illustrer l'utilisation des classes et des fonctions
## génériques, nous allons créer une classe 'toto' et une
## méthode de la fonction générique 'print' pour cette classe.
##
## Si la fonction 'print' est appelée avec un objet de mode
## 'numeric' et de classe 'toto', c'est le résultat de la
## fonction 'diag' qui est retourné. (Ne pas chercher un sens
## caché à tout ça, il n'y en a pas.)
##
## Définition de la nouvelle méthode.
print.toto <- function(x)
{
    if (mode(x) == "numeric")
    {
        cat("\n  Resultat de 'diag':\n")
        print(diag(x))
    }
    else
        print.default(x)
}

## Vérification que la méthode est disponible.
methods(print)

## Essai de la nouvelle méthode sur un scalaire.
x <- 4
class(x)                   # classe par défaut
x                          # méthode par défault
class(x) <- "toto"         # objet de classe 'toto'
x                          # méthode pour cette classe

## Essai de la nouvelle méthode sur un vecteur.
x <- 1:5
class(x)                   # classe par défaut
x                          # méthode par défault
class(x) <- "toto"         # objet de classe 'toto'
x                          # méthode pour cette classe

## Essai de la nouvelle méthode sur une matrice. Les matrices
## ont une classe "matrix" implicite.
x <- matrix(1:9, 3, 3)
class(x)                   # classe implicite
x                          # méthode par défaut
class(x) <- "toto"         # objet de classe 'toto'
x                          # méthode pour cette classe

## La nouvelle méthode ne fait rien de spécial pour les objets
## d'un mode autre que 'numeric'.
x <- letters
mode(x)
class(x) <- "toto"
x
