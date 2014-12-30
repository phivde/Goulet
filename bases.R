## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### COMMANDES R
###

## Les expressions entrées à la ligne de commande sont
## immédiatement évaluées et le résultat est affiché à
## l'écran, comme avec une grosse calculatrice.
1                          # une constante
(2 + 3 * 5)/7              # priorité des opérations
3^5                        # puissance
exp(3)                     # fonction exponentielle
sin(pi/2) + cos(pi/2)      # fonctions trigonométriques
gamma(5)                   # fonction gamma

## Lorsqu'une expression est syntaxiquement incomplète,
## l'invite de commande change de '> ' à '+ '.
2 -                        # expression incomplète
5 *                        # toujours incomplète
3                          # complétée

## Taper le nom d'un objet affiche son contenu. Pour une
## fonction, c'est son code source qui est affiché.
pi                         # constante numérique intégrée
letters                    # chaîne de caractères intégrée
LETTERS                    # version en majuscules
matrix                     # fonction

## Ne pas utiliser '=' pour l'affectation. Les opérateurs
## d'affectation standard en R sont '<-' et '->'.
x <- 5                     # affecter 5 à l'objet 'x'
5 -> x                     # idem, mais peu usité
x                          # voir le contenu
(x <- 5)                   # affecter et afficher
y <- x                     # affecter la valeur de 'x' à 'y'
x <- y <- 5                # idem, en une seule expression
y                          # 5
x <- 0                     # changer la valeur de 'x'...
y                          # ... ne change pas celle de 'y'

## Pour regrouper plusieurs expressions en une seule commande,
## il faut soit les séparer par un point-virgule ';', soit les
## regrouper à l'intérieur d'accolades { } et les séparer par
## des retours à la ligne.
x <- 5; y <- 2; x + y      # compact; éviter dans les scripts
x <- 5;                    # éviter les ';' superflus
{                          # début d'un groupe
    x <- 5                 # première expression du groupe
    y <- 2                 # seconde expression du groupe
    x + y                  # résultat du groupe
}                          # fin du groupe et résultat
{x <- 5; y <- 2; x + y}    # valide, mais redondant

###
### NOMS D'OBJETS
###

## Quelques exemples de noms valides et invalides.
foo <- 5                   # valide
foo.123 <- 5               # valide
foo_123 <- 5               # valide
123foo <- 5                # invalide; commence par un chiffre
.foo <- 5                  # valide
.123foo <- 5               # invalide; point suivi d'un chiffre

## Liste des objets dans l'espace de travail. Les objets dont
## le nom commence par un point sont considérés cachés.
ls()                       # l'objet '.foo' n'est pas affiché
ls(all.names = TRUE)       # objets cachés aussi affichés

## R est sensible à la casse
foo <- 1
Foo
FOO

###
### LES OBJETS R
###

## MODES ET TYPES DE DONNÉES

## Le mode d'un objet détermine ce qu'il peut contenir. Les
## vecteurs simples ("atomic") contiennent des données d'un
## seul type.
mode(c(1, 4.1, pi))        # nombres réels
mode(c(2, 1 + 5i))         # nombres complexes
mode(c(TRUE, FALSE, TRUE)) # valeurs booléennes
mode("foobar")             # chaînes de caractères

## Si l'on mélange dans un même vecteur des objets de mode
## différents, il y a conversion automatique vers le mode pour
## lequel il y a le moins de perte d'information, c'est-à-dire
## vers le mode qui permet le mieux de retrouver la valeur
## originale des éléments.
c(5, TRUE, FALSE)          # conversion en mode 'numeric'
c(5, "z")                  # conversion en mode 'character'
c(TRUE, "z")               # conversion en mode 'character'
c(5, TRUE, "z")            # conversion en mode 'character'

## La plupart des autres types d'objets sont récursifs. Voici
## quelques autres modes.
mode(seq)                  # une fonction
mode(list(5, "foo", TRUE)) # une liste
mode(expression(x <- 5))   # une expression non évaluée

## LONGUEUR

## La longueur d'un vecteur est égale au nombre d'éléments
## dans le vecteur.
(x <- 1:4)
length(x)

## Une chaîne de caractères ne compte que pour un seul
## élément.
(x <- "foobar")
length(x)

## Pour obtenir la longueur de la chaîne, il faut utiliser
## nchar().
nchar(x)

## Un objet peut néanmoins contenir plusieurs chaînes de
## caractères.
(x <- c("f", "o", "o", "b", "a", "r"))
length(x)

## La longueur peut être 0, auquel cas on a un objet vide,
## mais qui existe.
(x <- numeric(0))          # création du contenant
length(x)                  # l'objet 'x' existe...
x[1] <- 1                  # possible, 'x' existe
X[1] <- 1                  # impossible, 'X' n'existe pas

## L'OBJET SPECIAL 'NULL'
mode(NULL)                 # le mode de 'NULL' est NULL
length(NULL)               # longueur nulle
x <- c(NULL, NULL)         # s'utilise comme un objet normal
x; length(x); mode(x)      # mais donne toujours le vide

## L'OBJET SPÉCIAL 'NA'
x <- c(65, NA, 72, 88)     # traité comme une valeur
x + 2                      # tout calcul avec 'NA' donne NA
mean(x)                    # voilà qui est pire
mean(x, na.rm = TRUE)      # éliminer les 'NA' avant le calcul
is.na(x)                   # tester si les données sont 'NA'

## VALEURS INFINIES ET INDÉTERMINÉES
1/0                        # +infini
-1/0                       # -infini
0/0                        # indétermination
x <- c(65, Inf, NaN, 88)   # s'utilisent comme des valeurs
is.finite(x)               # quels sont les nombres réels?
is.nan(x)                  # lesquels ne sont «pas un nombre»?

## ATTRIBUTS

## Les objets peuvent être dotés d'un ou plusieurs attributs.
data(cars)                 # jeu de données intégré
attributes(cars)           # liste de tous les attributs
attr(cars, "class")        # extraction d'un seul attribut

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
class(x) <- NULL; x        # suppression de l'attribut 'class'

## Attribut 'dim'. Si l'attribut 'dim' compte deux valeurs,
## l'objet est traité comme une matrice. S'il en compte plus
## de deux, l'objet est traité comme un tableau (array).
x <- 1:24                  # un vecteur
dim(x) <- c(4, 6)          # ajoute un attribut 'dim'
x                          # l'objet est une matrice
dim(x) <- c(4, 2, 3)       # change les dimensions
x                          # l'objet est maintenant un tableau

## Attribut 'dimnames'. Permet d'assigner des étiquettes (ou
## noms) aux dimensions d'une matrice ou d'un tableau.
dimnames(x) <- list(1:4, c("a", "b"), c("A", "B", "C"))
dimnames(x)                # remarquer la conversion
x                          # affichage avec étiquettes
attributes(x)              # tous les attributs de 'x'
attributes(x) <- NULL; x   # supprimer les attributs

## Attributs 'names'. Similaire à 'dimnames', mais pour les
## éléments d'un vecteur ou d'une liste.
names(x) <- letters[1:24]  # attribution d'étiquettes
x                          # identification facilitée

###
### VECTEURS
###

## La fonction de base pour créer des vecteurs est 'c'. Il
## peut s'avérer utile de donner des étiquettes aux éléments
## d'un vecteur.
x <- c(a = -1, b = 2, c = 8, d = 10) # création d'un vecteur
names(x)                             # extraire les étiquettes
names(x) <- letters[1:length(x)]     # changer les étiquettes
x[1]                       # extraction par position
x["c"]                     # extraction par étiquette
x[-2]                      # élimination d'un élément

## La fonction 'vector' sert à initialiser des vecteurs avec
## des valeurs prédéterminées. Elle compte deux arguments: le
## mode du vecteur et sa longueur. Les fonctions 'numeric',
## 'logical', 'complex' et 'character' constituent des
## raccourcis pour des appels à 'vector'.
vector("numeric", 5)       # vecteur initialisé avec des 0
numeric(5)                 # équivalent
numeric                    # en effet, voici la fonction
logical(5)                 # initialisé avec FALSE
complex(5)                 # initialisé avec 0 + 0i
character(5)               # initialisé avec chaînes vides

###
### MATRICES ET TABLEAUX
###

## Une matrice est un vecteur avec un attribut 'dim' de
## longueur 2 une classe implicite "matrix". La manière
## naturelle de créer une matrice est avec la fonction
## 'matrix'.
(x <- matrix(1:12, nrow = 3, ncol = 4)) # créer la matrice
length(x)                  # 'x' est un vecteur...
dim(x)                     # ... avec un attribut 'dim'...
class(x)                   # ... et classe implicite "matrix"

## Une manière moins naturelle mais équivalente --- et parfois
## plus pratique --- de créer une matrice consiste à ajouter
## un attribut 'dim' à un vecteur.
x <- 1:12                  # vecteur simple
dim(x) <- c(3, 4)          # ajout d'un attribut 'dim'
x; class(x)                # 'x' est une matrice!

## Les matrices sont remplies par colonne par défaut. Utiliser
## l'option 'byrow' pour remplir par ligne.
matrix(1:12, nrow = 3, byrow = TRUE)

## Indicer la matrice ou le vecteur sous-jacent est
## équivalent. Utiliser l'approche la plus simple selon le
## contexte.
x[1, 3]                    # l'élément en position (1, 3)...
x[7]                       # ... est le 7e élément du vecteur
x[1, ]                     # première ligne
x[, 2]                     # deuxième colonne
nrow(x)                    # nombre de lignes
dim(x)[1]                  # idem
ncol(x)                    # nombre de colonnes
dim(x)[2]                  # idem

## Fusion de matrices et vecteurs.
x <- matrix(1:12, 3, 4)    # 'x' est une matrice 3 x 4
y <- matrix(1:8, 2, 4)     # 'y' est une matrice 2 x 4
z <- matrix(1:6, 3, 2)     # 'z' est une matrice 3 x 2
rbind(x, 1:4)              # ajout d'une ligne à 'x'
rbind(x, y)                # fusion verticale de 'x' et 'y'
cbind(x, 1:3)              # ajout d'une colonne à 'x'
cbind(x, z)                # concaténation de 'x' et 'z'
rbind(x, z)                # dimensions incompatibles
cbind(x, y)                # dimensions incompatibles

## Les vecteurs ligne et colonne sont rarement nécessaires. On
## peut les créer avec les fonctions 'rbind' et 'cbind',
## respectivement.
rbind(1:3)                 # un vecteur ligne
cbind(1:3)                 # un vecteur colonne

## Un tableau (array) est un vecteur avec un attribut 'dim' de
## longueur supérieure à 2 et une classe implicite "array".
## Quant au reste, la manipulation des tableaux est en tous
## points identique à celle des matrices. Ne pas oublier:
## les tableaux sont remplis de la première dimension à la
## dernière!
x <- array(1:60, 3:5)      # tableau 3 x 4 x 5
length(x)                  # 'x' est un vecteur...
dim(x)                     # ... avec un attribut 'dim'...
class(x)                   # ... une classe implicite "array"
x[1, 3, 2]                 # l'élément en position (1, 3, 2)...
x[19]                      # ... est l'élément 19 du vecteur

## Le tableau ci-dessus est un prisme rectangulaire 3 unités
## de haut, 4 de large et 5 de profond. Indicer ce prisme avec
## un seul indice équivaut à en extraire des «tranches», alors
## qu'utiliser deux indices équivaut à en tirer des «carottes»
## (au sens géologique du terme). Il est laissé en exercice de
## généraliser à plus de dimensions...
x                          # les cinq matrices
x[, , 1]                   # tranches de haut en bas
x[, 1, ]                   # tranches d'avant à l'arrière
x[1, , ]                   # tranches de gauche à droite
x[, 1, 1]                  # carotte de haut en bas
x[1, 1, ]                  # carotte d'avant à l'arrière
x[1, , 1]                  # carotte de gauche à droite

###
### LISTES
###

## La liste est l'objet le plus général en R. C'est un objet
## récursif qui peut contenir des objets de n'importe quel
## mode et longueur.
(x <- list(joueur = c("V", "C", "C", "M", "A"),
           score = c(10, 12, 11, 8, 15),
           expert = c(FALSE, TRUE, FALSE, TRUE, TRUE),
           niveau = 2))
is.vector(x)               # vecteur...
length(x)                  # ... de quatre éléments...
mode(x)                    # ... de mode "list"
is.recursive(x)            # objet récursif

## Comme tout autre vecteur, une liste peut être concaténée
## avec un autre vecteur avec la fonction 'c'.
y <- list(TRUE, 1:5)       # liste de deux éléments
c(x, y)                    # liste de six éléments

## Pour initialiser une liste d'une longueur déterminée, mais
## dont chaque élément est vide, uitliser la fonction
## 'vector'.
vector("list", 5)          # liste de NULL

## Pour extraire un élément d'une liste, il faut utiliser les
## doubles crochets [[ ]]. Les simples crochets [ ]
## fonctionnent aussi, mais retournent une sous liste -- ce
## qui est rarement ce que l'on souhaite.
x[[1]]                     # premier élément de la liste...
mode(x[[1]])               # ... un vecteur
x[1]                       # aussi le premier élément...
mode(x[1])                 # ... mais une sous liste...
length(x[1])               # ... d'un seul élément
x[[2]][1]                  # 1er élément du 2e élément
x[[c(2, 1)]]               # idem, par indiçage récursif

## Les éléments d'une liste étant généralement nommés (c'est
## une bonne habitude à prendre!), il est souvent plus simple
## et sûr d'extraire les éléments d'une liste par leur
## étiquette.
x$joueur                   # équivalent à a[[1]]
x$score[1]                 # équivalent à a[[c(2, 1)]]
x[["expert"]]              # aussi valide, mais peu usité
x$level <- 1               # aussi pour l'affectation

## Une liste peut contenir n'importe quoi...
x[[5]] <- matrix(1, 2, 2)  # ... une matrice...
x[[6]] <- list(20:25, TRUE)# ... une autre liste...
x[[7]] <- seq              # ... même le code d'une fonction!
x                          # eh ben!
x[[c(6, 1, 3)]]            # de quel élément s'agit-il?

## Pour supprimer un élément d'une liste, lui assigner la
## valeur 'NULL'.
x[[7]] <- NULL; length(x)  # suppression du 7e élément

## Il est parfois utile de convertir une liste en un simple
## vecteur. Les éléments de la liste sont alors «déroulés», y
## compris la matrice en position 5 (qui n'est rien d'autre
## qu'un vecteur, on s'en souviendra).
unlist(x)                    # remarquer la conversion
unlist(x, recursive = FALSE) # ne pas appliquer aux sous-listes
unlist(x, use.names = FALSE) # éliminer les étiquettes

###
### DATA FRAMES
###

## Un data frame est une liste dont les éléments sont tous de
## même longueur. Il comporte un attribut 'dim', ce qui fait
## qu'il est représenté comme une matrice. Cependant, les
## colonnes peuvent être de modes différents.
(DF <- data.frame(Noms = c("Pierre", "Jean", "Jacques"),
                  Age = c(42, 34, 19),
                  Fumeur = c(TRUE, TRUE, FALSE)))
mode(DF)                   # un data frame est une liste...
class(DF)                  # ... de classe 'data.frame'
dim(DF)                    # dimensions implicites
names(DF)                  # titres des colonnes
row.names(DF)              # titres des lignes (implicites)
DF[1, ]                    # première ligne
DF[, 1]                    # première colonne
DF$Name                    # idem, mais plus simple

## Lorsque l'on doit travailler longtemps avec les différentes
## colonnes d'un data frame, il est pratique de pouvoir y
## accéder directement sans devoir toujours indicer. La
## fonction 'attach' permet de rendre les colonnes
## individuelles visibles dans l'espace de travail. Une fois
## le travail terminé, 'detach' masque les colonnes.
exists("Noms")             # variable n'existe pas
attach(DF)                 # rendre les colonnes visibles
exists("Noms")             # variable existe
Noms                       # colonne accessible
detach(DF)                 # masquer les colonnes
exists("Noms")             # variable n'existe plus

###
### INDIÇAGE
###

## Les opérations suivantes illustrent les différentes
## techniques d'indiçage d'un vecteur pour l'extraction et
## l'affectation, c'est-à-dire que l'on utilise à la fois la
## fonction '[' et la fonction '[<-'. Les mêmes techniques
## existent aussi pour les matrices, tableaux et listes.
##
## On crée d'abord un vecteur quelconque formé de vingt
## nombres aléatoires entre 1 et 100 avec répétitions
## possibles.
(x <- sample(1:100, 20, replace = TRUE))

## On ajoute des étiquettes aux éléments du vecteur à partir
## de la variable interne 'letters'.
names(x) <- letters[1:20]

## On génère ensuite cinq nombres aléatoires entre 1 et 20
## (sans répétitions).
(y <- sample(1:20, 5))

## On remplace maintenant les éléments de 'x' correspondant
## aux positions dans le vecteur 'y' par des données
## manquantes.
x[y] <- NA
x

## Les cinq méthodes d'indiçage de base.
x[1:10]                    # avec des entiers positifs
"["(x, 1:10)               # idem, avec la fonction '['
x[-(1:3)]                  # avec des entiers négatifs
x[x < 10]                  # avec un vecteur booléen
x[c("a", "k", "t")]        # par étiquettes
x[]                        # aucun indice...
x[numeric(0)]              # ... différent d'indice vide

## Il arrive souvent de vouloir indicer spécifiquement les
## données manquantes d'un vecteur (pour les éliminer ou les
## remplacer par une autre valeur, par exemple). Pour ce
## faire, on utilise la fonction 'is.na' et l'indiçage par un
## vecteur booléen. (Note: l'opérateur '!' ci-dessous est la
## négation logique.)
is.na(x)                   # positions des données manquantes
x[!is.na(x)]               # suppression des données manquantes
x[is.na(x)] <- 0; x        # remplace les NA par des 0
"[<-"(x, is.na(x), 0)      # idem, mais très peu usité

## On laisse tomber les étiquettes de l'objet.
names(x) <- NULL

## Quelques cas spéciaux d'indiçage.
length(x)                  # un rappel
x[1:25]                    # allonge le vecteur avec des NA
x[25] <- 10; x             # remplit les trous avec des NA
x[0]                       # n'extraie rien
x[0] <- 1; x               # n'affecte rien
x[c(0, 1, 2)]              # le 0 est ignoré
x[c(1, NA, 5)]             # indices NA retourne NA
x[2.6]                     # fractions tronquées vers 0

## On laisse tomber les 5 derniers éléments et on convertit le
## vecteur en une matrice 4 x 5.
x <- x[1:20]               # ou x[-(21:25)]
dim(x) <- c(4, 5); x       # ajouter un attribut 'dim'

## Dans l'indiçage des matrices et tableaux, l'indice de
## chaque dimension obéit aux mêmes règles que ci-dessus. On
## peut aussi indicer une matrice (ou un tableau) avec une
## matrice. Si les exemples ci-dessous ne permettent pas d'en
## comprendre le fonctionnement, consulter la rubrique d'aide
## de la fonction '[' (ou de 'Extract').
x[1, 2]                    # élément en position (1, 2)
x[1, -2]                   # 1ère rangée sans 2e colonne
x[c(1, 3), ]               # 1ère et 3e rangées
x[-1, ]                    # supprimer 1ère rangée
x[, -2]                    # supprimer 2e colonne
x[x[, 1] > 10, ]           # lignes avec 1er élément > 10
x[rbind(c(1, 1), c(2, 2))] # éléments x[1, 1] et x[2, 2]
x[cbind(1:4, 1:4)]         # éléments x[i, i] (diagonale)
diag(x)                    # idem et plus explicite
