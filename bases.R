###
### LES OBJETS S
###

## LONGUEUR

## La longueur d'un vecteur est égale au nombre d'éléments
## dans le vecteur.
( a <- 1:4 )
length(a)

## La longueur d'une chaîne de caractères est 1...
( a <- "foobar" )
length(a)

## ... à moins que l'objet ne compte plusieurs chaînes de
## caractères.
( a <- c("f", "o", "o", "b", "a", "r") )
length(a)

## La longueur peut être 0, auquel cas on a un objet vide,
## mais qui existe.
( a <- numeric(0) )
length(a)                  # l'objet 'a' existe...
a[1] <- 1                  # on peut donc affecter sa première
                           # valeur
b[1] <- 1                  # opération impossible, l'objet 'b'
                           # n'existe pas

## ATTRIBUTS

## Attribut 'class'. Selon la classe d'un objet, certaines
## fonctions (dites «fonctions génériques») vont se comporter
## différemment.
x <- sample(1:100, 10)     # échantillon aléatoire de 10
                           # nombres entre 1 et 100
class(x)                   # classe de l'objet
plot(x)                    # graphique pour cette classe
class(x) <- "ts"           # 'x' est maintenant une série
                           # chronologique
plot(x)                    # graphique pour les séries
                           # chronologiques

## Attribut 'dim'. Si l'attribut 'dim' compte deux valeurs,
## l'objet est traité comme une matrice. S'il en compte plus
## de deux, l'objet est traité comme un tableau (array).
a <- matrix(1:12, nrow=3, ncol=4) # matrice 3 x 4
dim(a)                     # vecteur de deux éléments
length(dim(a))             # nombre de dimensions de 'a'
class(a)                   # objet considéré comme une matrice
length(a)                  # à l'interne, 'a' est un vecteur

a <- array(1:24, c(2, 3, 4))  # tableau 2 x 3 x 4
dim(a)                     # vecteur de 3 éléments
length(dim(a))             # nombre de dimensions de 'a'
class(a)                   # objet considéré comme un tableau
length(a)                  # à l'interne, 'a' est un vecteur

## Attribut 'dimnames'. Permet d'assigner des étiquettes (ou
## noms) aux dimensions d'une matrice ou d'un tableau.
( a <- matrix(1:12, nrow=3) ) # matrice 3 x 4
dimnames(a)                # pas d'étiquettes par défaut
letters                    # objet prédéfini
LETTERS                    # idem
dimnames(a) <- list(letters[1:3], LETTERS[1:4])
                           # 'dimnames' est une liste de
                           # deux éléments
a                          # joli
dimnames(a)                # noms stockés dans une liste

## Attributs 'names'. Similaire à 'dimnames', mais pour les
## éléments d'un vecteur ou d'une liste.
( a <- 1:4 )               # vecteur de quatre éléments
names(a)                   # pas d'étiquettes par défaut
names(a) <- c("Rouge", "Vert", "Bleu", "Jaune")
                           # attribution d'étiquettes
a                          # joli
names(a)                   # extraction des étiquettes
( a <- c("Rouge"=1, "Vert"=2, "Bleu"=3, "Jaune"=4) )
                           # autre façon de faire
names(a)                   # même résultat

## L'OBJET SPÉCIAL 'NA'
a <- c(65, NA, 72, 88)     # traité comme une valeur
mean(a)                    # tout calcul donne NA...
mean(a, na.rm=TRUE)        # ... à moins d'éliminer les NA
                           # avant de faire le calcul

## L'OBJET SPECIAL 'NULL'
mode(NULL)                 # le mode de 'NULL' est NULL
length(NULL)               # longueur nulle
a <- c(NULL, NULL)         # s'utilise comme un objet normal
a; length(a); mode(a)      # mais résulte toujours en le vide

###
### VECTEURS
###
a <- c(-1, 2, 8, 10)       # création d'un vecteur
names(a) <- letters[1:length(a)] # attribution d'étiquettes
a[1]                       # extraction par position
a["c"]                     # extraction par étiquette
a[-2]                      # élimination d'un élément

## Les fonctions 'numeric', 'logical' et 'character'
## consistuent la manière «officielle» d'initialiser des
## contenants vides.
( a <- numeric(10) )       # vecteur initialisé avec des 0
( a <- logical(10) )       # vecteur initialisé avec des FALSE
( a <- character(10) )     # vecteur initialisé avec ""

## Si l'on mélange dans un même vecteur des objets de mode
## différents, il y a conversion automatique vers le mode pour
## lequel il y a le moins de perte d'information.
c(5, TRUE, FALSE)          # conversion au mode 'numeric'
c(5, "z")                  # conversion au mode 'character'
c(TRUE, "z")               # conversion au mode 'character'
c(5, TRUE, "z")            # conversion au mode 'character'

###
### MATRICES ET TABLEAUX
###

## Deux façons de créer des matrices: à l'aide de la fonction
## 'matrix', ou en ajoutant un attribut 'dim' à un vecteur.
( a <- matrix(1:12, nrow=3, ncol=4) ) # avec 'matrix'
class(a); length(a); dim(a)# vecteur à deux dimensions

a <- 1:12                  # vecteur simple
dim(a) <- c(3, 4)          # ajout d'un attribut 'dim'
class(a); length(a); dim(a)# même résultat!

a[1, 3]                    # l'élément en position (1, 3)...
a[7]                       # ... est le 7e élément du vecteur
a[1,]                      # première ligne
a[,2]                      # deuxième colonne

matrix(1:12, nrow=3, byrow=TRUE) # remplir par ligne

## On procède exactement de la même façons avec les tableaux,
## sauf que le nombre de dimensions est plus élevé. Attention:
## les tableaux sont remplis de la première à la dernière
## dimension, dans l'ordre.
( a <- array(1:60, 3:5) )  # tableau 3 x 4 x 5
class(a); length(a); dim(a)# vecteur à trois dimensions
a[1, 3, 2]                 # l'élément (1, 3, 2)...
a[19]                      # ... est le 19e élément du vecteur

## Fusion de matrices et vecteurs.
a <- matrix(1:12, 3, 4)    # 'a' est une matrice 3 x 4
b <- matrix(1:8, 2, 4)     # 'b' est une matrice 2 x 4
c <- matrix(1:6, 3, 2)     # 'c' est une matrice 3 x 2
rbind(a, 1:4)              # ajout d'une ligne à 'a'
rbind(a, b)                # fusion verticale de 'a' et 'b'
cbind(a, 1:3)              # ajout d'une colonne à 'a'
cbind(a, c)                # concaténation de 'a' et 'c'
rbind(a, c)                # dimensions incompatibles
cbind(a, b)                # dimensions incompatibles

## Les vecteurs ligne et colonne sont rarement nécessaires. On
## peut les créer avec les fonctions 'rbind' et 'cbind',
## respectivement.
rbind(1:3)                 # un vecteur ligne
cbind(1:3)                 # un vecteur colonne

###
### LISTES
###

## La liste est l'objet le plus général en S puisqu'il peut
## contenir des objets de n'importe quel mode et longueur.
( a <- list(joueur=c("V", "C", "C", "M", "A"),
            score=c(10, 12, 11, 8, 15),
            expert=c(FALSE, TRUE, FALSE, TRUE, TRUE),
            bidon=2) )
mode(a)                    # mode 'list'
length(a)                  # quatre éléments

## Pour extraire un élément d'une liste, il faut utiliser les
## doubles crochets [[ ]]. Les simples crochets [ ]
## fonctionnent aussi, mais retournent une sous liste -- ce
## qui est rarement ce que l'on souhaite.
a[[1]]                     # premier élément de la liste...
mode(a[[1]])               # ... un vecteur
a[1]                       # aussi le premier élément...
mode(a[1])                 # ... mais une sous liste...
length(a[1])               # ... d'un seul élément
a[[2]][1]                  # 1er élément du 2e élément

## Les éléments d'une liste étant généralement nommés (c'est
## une bonne habitude à prendre!), il est généralement plus
## simple et sûr d'extraire les éléments d'une liste par leur
## étiquette.
a$joueur                   # équivalent à a[[1]]
a$score[1]                 # équivalent à a[[2]][1]
a[["expert"]]              # aussi valide, mais peu usité

## Une liste peut contenir n'importe quoi...
a[[5]] <- matrix(1, 2, 2)  # ... une matrice...
a[[6]] <- list(20:25, TRUE)# ... une autre liste...
a[[7]] <- seq              # ... même le code d'une fonction!
a                          # eh ben
a[[6]][[1]][3]             # de quel élément s'agit-il?

## Il est parfois utile de convertir une liste en un simple
## vecteur. Les éléments de la liste sont alors «déroulés», y
## compris la matrice en position 5 (qui n'est rien d'autre
## qu'un vecteur, on s'en souviendra).
a <- a[1:6]                # éliminer la fonction
unlist(a)                  # remarquer la conversion
unlist(a, use.names=FALSE) # éliminer les étiquettes

###
### DATA FRAMES
###

## Un data frame est une liste dont les éléments sont tous
## de même longueur. Il comporte un attribut 'dim', ce qui
## fait qu'il est représenté comme une matrice.
( dframe <- data.frame(Noms=c("Pierre", "Jean", "Jacques"),
                       Age=c(42, 34, 19),
                       Fumeur=c(TRUE, TRUE, FALSE)) )
mode(dframe)               # un data frame est une liste...
dim(dframe)                # ... avec un attribut 'dim'
class(dframe)              # ... et de classe 'data.frame'

## Lorsque l'on doit travailler longtemps avec les
## différentes colonnes d'un data frame, il est pratique de
## pouvoir y accéder directement sans devoir toujours
## indicer. La fonction 'attach' permet de rendre les
## colonnes individuelles visibles.  Une fois terminé,
## 'detach' masque les colonnes.
exists("Noms")
attach(dframe)
exists("Noms")
Noms
detach(dframe)
exists("Noms")

###
### INDIÇAGE
###

## Les opérations suivantes illustrent les différentes
## techniques d'indiçage d'un vecteur. Les mêmes techniques
## existent aussi pour les matrices, tableaux et listes. On
## crée d'abord un vecteur quelconque formé de vingt nombres
## aléatoires entre 1 et 100 avec répétitions possibles.
( x <- sample(1:100, 20, replace=TRUE) )

## On ajoute des étiquettes aux éléments du vecteur à partir
## de la variable interne 'letters'.
names(x) <- letters[1:20]

## On génère ensuite cinq nombres aléatoires entre 1 et 20
## (sans répétitions).
( y <- sample(1:20, 5) )

## Toutes les techniques d'indiçage peuvent aussi servir à
## affecter de nouvelles valeurs à une partie d'un
## vecteur. Ici, les éléments de 'x' correspondant aux
## positions dans le vecteur 'y' sont remplacés par des
## données manquantes.
x[y] <- NA
x

## La fonction 'is.na' permet de tester si une valeur est NA
## ou non.
is.na(x)

## Élimination des données manquantes.
( x <- x[!is.na(x)] )

## Tout le vecteur 'x' sauf les trois premiers éléments.
x[-(1:3)]

## Extraction par chaîne de caractères.
x[c("a", "k", "t")]
