###
### OPÉRATEURS
###

## Seuls les opérateurs %%, %/% et logiques sont illustrés
## ici. Premièrement, l'opérateur modulo retourne le reste
## d'une division.
5 %% 1:5
10 %% 1:15

## Le modulo est pratique dans les boucles, par exemple pour
## afficher un résultat à toutes les n itérations seulement.
for (i in 1:50)
{
    ## Affiche la valeur du compteur toutes les 5 itérations.
    if (0 == i %% 5)
        print(i)
}

## La division entière retourne la partie entière de la
## division d'un nombre par un autre.
5 %/% 1:5
10 %/% 1:15

## Dans les opérations logiques impliquant les opérateurs &, |
## et !, le nombre zéro est traité comme FALSE et tous les
## autres nombres comme TRUE.
0:5 & 5:0
0:5 | 5:0
!0:5

## L'exemple de boucle ci-dessus peut donc être légèrement
## modifié.
for (i in 1:50)
{
    ## Affiche la valeur du compteur toutes les 5 itérations.
    if (!i %% 5)
        print (i)
}

## Dans les calculs numériques, TRUE vaut 1 et FALSE vaut 0.
a <- c("Impair", "Pair")
x <- c(2, 3, 6, 8, 9, 11, 12)
x %% 2
(!x %% 2) + 1
a[(!x %% 2) + 1]

###
### APPELS DE FONCTIONS
###

## Les invocations de la fonction 'matrix' ci-dessous sont
## toutes équivalentes. On remarquera, entre autres, comment
## les arguments sont spécifiés (par nom ou par position).
matrix(1:12, 3, 4)
matrix(1:12, ncol=4, nrow=3)
matrix(nrow=3, ncol=4, data=1:12)
matrix(nrow=3, ncol=4, byrow=FALSE, 1:12)
matrix(nrow=3, ncol=4, 1:12, FALSE)

###
### QUELQUES FONCTIONS UTILES
###

## MANIPULATION DE VECTEURS
a <- c(50, 30, 10, 20, 60, 30, 20, 40)  # vecteur non ordonné

## Séquences de nombres.
seq(from=1, to=10)       # équivalent à 1:10
seq(-10, 10, length=50)  # incrément déterminé automatiquement
seq(-2, by=0.5, along=a) # même longueur que 'a'

## Répétition de nombres ou de vecteurs complets.
rep(1, 10)               # utilisation de base
rep(a, 2)                # répéter un vecteur
rep(a, times=2, each=4)  # possible de combiner les arguments
rep(a, times=1:8)        # nombre de répétitions différent
                         # pour chaque élément de 'a'

## Classement en ordre croissant ou décroissant.
sort(a)                  # classement en ordre croissant
sort(a, decr=TRUE)       # classement en ordre décroissant
sort(c("abc", "B", "Aunt", "Jemima")) # chaînes de caractères
sort(c(TRUE, FALSE))     # FALSE vient avant TRUE

## La fonction 'order' retourne la position, dans le vecteur
## donné en argument, du premier élément dans l'ordre
## croissant, puis du deuxième, etc. Autrement dit, on obtient
## l'ordre dans lequel il faut extraire les données du vecteur
## pour les obtenir en ordre croissant.
order(a)                  # regarder dans le blanc des yeux
a[order(a)]               # équivalent à 'sort(a)'

## Rang des éléments d'un vecteur dans l'ordre croissant.
rank(a)                   # rang des élément de 'a'

## Renverser l'ordre d'un vecteur.
rev(a)

## --- R ---
head(a, 3)                 # trois premiers éléments de 'a'
tail(a, 3)                 # trois derniers éléments de 'a'
## ---------

## Équivalents S-Plus
a[1:3]                     # trois premiers éléments de 'a'
a[(length(a)-2):length(a)] # trois derniers éléments de 'a'
rev(rev(a)[1:3])           # avec petits vecteurs seulement

## Seulement les éléments différents d'un vecteur.
unique(a)

## RECHERCHE D'ÉLÉMENTS DANS UN VECTEUR
which(a >= 30)             # positions des éléments >= 30
which.min(a)               # position du minimum
which.max(a)               # position du maximum
match(20, a)               # position du premier 20 dans 'a'
match(c(20, 30), a)        # aussi pour plusieurs valeurs
60 %in% a                  # 60 appartient à 'a'
70 %in% a                  # 70 n'appartient pas à 'a'

## ARRONDI
( a <- c(-21.2, -pi, -1.5, -0.2, 0, 0.2, 1.7823, 315) )
round(a)                   # arrondi à l'entier
round(a, 2)                # arrondi à la seconde décimale
round(a, -1)               # arrondi aux dizaines
ceiling(a)                 # plus petit entier supérieur
floor(a)                   # plus grand entier inférieur
trunc(a)                   # troncature des décimales

## SOMMAIRES ET STATISTIQUES DESCRIPTIVES
sum(a)                     # somme des éléments de 'a'
prod(a)                    # produit des éléments de 'a'
diff(a)                    # a[2] - a[1], a[3] - a[2], etc.
mean(a)                    # moyenne des éléments de 'a'
mean(a, trim=0.125)        # moyenne tronquée
var(a)                     # variance (sans biais)
(length(a) - 1)/length(a) * var(a) # variance biaisée
sd(a)                      # écart type
max(a)                     # maximum
min(a)                     # minimum
range(a)                   # c(min(a), max(a))
diff(range(a))             # étendue de 'a'
median(a)                  # médiane (50e quantile) empirique
quantile(a)                # quantiles empiriques
quantile(a, 1:10/10)       # on peut spécifier les quantiles
summary(a)                 # plusieurs des résultats ci-dessus

## SOMMAIRES CUMULATIFS ET COMPARAISONS ÉLÉMENTS PAR ÉLÉMENT
( a <- sample(1:20, 6) )
( b <- sample(1:20, 6) )
cumsum(a)                  # somme cumulative de 'a'
cumprod(b)                 # produit cumulatif de 'b'
rev(cumprod(rev(b)))       # produit cumulatif renversé
cummin(a)                  # minimum cumulatif
cummax(b)                  # maximum cumulatif
pmin(a, b)                 # minimum élément par élément
pmax(a, b)                 # maximum élément par élément

## OPÉRATIONS SUR LES MATRICES
( A <- sample(1:10, 16, replace=TRUE) ) # avec remise
dim(A) <- c(4, 4)          # conversion en une matrice 4 x 4
b <- c(10, 5, 3, 1)        # un vecteur quelconque
A                          # la matrice 'A'
t(A)                       # sa transposée
solve(A)                   # son inverse
solve(A, b)                # la solution de Ax = b
A %*% solve(A, b)          # vérification de la réponse
diag(A)                    # extraction de la diagonale de 'A'
diag(b)                    # matrice diagonale formée avec 'b'
diag(4)                    # matrice identité 4 x 4
( A <- cbind(A, b) )       # matrice 4 x 5
nrow(A)                    # nombre de lignes de 'A'
ncol(A)                    # nombre de colonnes de 'A'
rowSums(A)                 # sommes ligne par ligne
colSums(A)                 # sommes colonne par colonne
apply(A, 1, sum)           # équivalent à 'rowSums(A)'
apply(A, 2, sum)           # équivalent à 'colSums(A)'
apply(A, 1, prod)          # produit par ligne avec 'apply'

## PRODUIT EXTÉRIEUR
a <- c(1, 2, 4, 7, 10, 12)
b <- c(2, 3, 6, 7, 9, 11)
outer(a, b)                # produit extérieur
a %o% b                    # équivalent plus court
outer(a, b, "+")           # «somme extérieure»
outer(a, b, "<=")          # toutes les comparaisons possibles
outer(a, b, pmax)          # idem

###
### STRUCTURES DE CONTRÔLE
###

## Pour illustrer les structures de contrôle, on fait un petit
## exemple tout à fait artificiel: un vecteur est rempli des
## nombres de 1 à 100, sauf les multiples de 10. Ces derniers
## sont affichés à l'écran.
##
## À noter qu'il est possible --- et plus efficace --- de
## créer le vecteur sans avoir recours à des boucles.
(1:100)[-((1:10) * 10)]    # sans boucle!
rep(1:9, 10) + rep(0:9*10, each=9) # une autre façon!

## Bon, l'exemple proprement dit...
x <- numeric(0)            # initialisation du contenant 'x'
j <- 0                     # compteur pour la boucle
for (i in 1:100)
{
    if (i %% 10)           # si i n'est pas un multiple de 10
        x[j <- j + 1] <- i # stocker sa valeur dans 'x'
    else                   # sinon
        print(i)           # afficher la valeur à l'écran
}
x                          # vérification

## Même chose que ci-dessus, mais sans le compteur 'j' et les
## valeurs manquantes aux positions 10, 20, ..., 100 sont
## éliminées à la sortie de la boucle.
x <- numeric(0)
for (i in 1:100)
{
    if (i %% 10)
        x[i] <- i
    else
        print(i)
}
x <- x[!is.na(x)]
x

## On peut refaire l'exemple avec une boucle 'while', mais
## cette structure n'est pas naturelle ici puisque l'on sait
## d'avance que nous devrons faire la boucle exactement 100
## fois. Le 'while' est plutôt utilisé lorsque le nombre de
## répétitions est inconnu. De plus, une boucle 'while' n'est
## pas nécessairement exécutée puisque le critère d'arrêt est
## évalué dès l'entrée dans la boucle.
x <- numeric(0)
j <- 0
i <- 1                     # pour entrer dans la boucle
while (i <= 100)
{
    if (i %% 10)
        x[j <- j + 1] <- i
    else
        print(i)
    i <- i + 1             # incrémenter le compteur!
}
x

## La remarque faite au sujet de la boucle 'while' s'applique
## aussi à la boucle 'repeat'. Par contre, le critère d'arrêt
## de la boucle 'repeat' étant évalué à la fin de la boucle,
## la boucle est exécutée au moins une fois. S'il faut faire
## un tour de passe passe pour s'assurer qu'une boucle 'while'
## est exécutée au moins une fois, c'est qu'il faut utiliser
## 'repeat'...
x <- numeric(0)
j <- 0
i <- 1
repeat
{
    if (i %% 10)
        x[j <- j + 1] <- i
    else
        print(i)
    if (100 < (i <- i + 1)) # incrément et critère d'arrêt
        break
}
x
