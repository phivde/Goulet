## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### GÉNÉRATEURS DE NOMBRES ALÉATOIRES
###

## La fonction de base pour simuler des nombres uniformes est
## 'runif'.
runif(10)                  # sur (0, 1) par défaut
runif(10, 2, 5)            # sur un autre intervalle
2 + 3 * runif(10)          # équivalent, moins lisible

## R est livré avec plusieurs générateurs de nombres
## aléatoires. On peut en changer avec la fonction 'RNGkind'.
RNGkind("Wichmann-Hill")   # générateur de Excel
runif(10)                  # rien de particulier à voir
RNGkind("default")         # retour au générateur par défaut

## La fonction 'set.seed' est très utile pour spécifier
## l'amorce d'un générateur. Si deux simulations sont
## effectuées avec la même amorce, on obtiendra exactement les
## mêmes nombres aléatoires et, donc, les mêmes résultats.
## Très utile pour répéter une simulation à l'identique.
set.seed(1)                # valeur sans importance
runif(5)                   # 5 nombres aléatoires
runif(5)                   # 5 autres nombres
set.seed(1)                # réinitialisation de l'amorce
runif(5)                   # les mêmes 5 nombres que ci-dessus

###
### FONCTIONS POUR LA SIMULATION DE VARIABLES ALÉATOIRES NON
### UNIFORMES
###

## Plutôt que de devoir utiliser la méthode de l'inverse ou un
## autre algorithme de simulation pour obtenir des nombres
## aléatoires d'une loi de probabilité non uniforme, R fournit
## des fonctions de simulation pour bon nombre de lois. Toutes
## ces fonctions sont vectorielles. Ci-dessous, P == Poisson
## et G == Gamma pour économiser sur la notation.
n <- 10                    # taille des échantillons
rbinom(n, 5, 0.3)          # Binomiale(5, 0,3)
rbinom(n, 1, 0.3)          # Bernoulli(0,3)
rnorm(n)                   # Normale(0, 1)
rnorm(n, 2, 5)             # Normale(2, 25)
rpois(n, c(2, 5))          # P(2), P(5), P(2), ..., P(5)
rgamma(n, 3, 2:11)         # G(3, 2), G(3, 3), ..., G(3, 11)
rgamma(n, 11:2, 2:11)      # G(11, 2), G(10, 3), ..., G(2, 11)

## La fonction 'sample' sert pour simuler d'une distribution
## discrète quelconque. Le premier argument est le support de
## la distribution et le second, la taille de l'échantillon
## désirée. Par défaut, l'échantillonnage se fait avec remise
## et avec des probabilités égales sur tout le support.
sample(1:49, 7)            # numéros pour le 7/49
sample(1:10, 10)           # mélange des nombres de 1 à 10

## On peut échantillonner avec remise.
sample(1:10, 10, replace = TRUE)

## On peut aussi spécifier une distribution de probabilités
## non uniforme.
x <- sample(c(0, 2, 5), 1000, replace = TRUE,
            prob = c(0.2, 0.5, 0.3))
table(x)                   # tableau de fréquences
