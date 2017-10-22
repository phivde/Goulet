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
### MATRICE ET TABLEAU
###

## Une matrice est un vecteur avec un attribut 'dim' de
## longueur 2 et une classe implicite "matrix". La manière
## naturelle de créer une matrice est avec la fonction
## 'matrix'.
(x <- matrix(1:12, nrow = 3, ncol = 4))
length(x)                  # longueur du vecteur sous-jacent
attributes(x)              # objet muni d'un attribut 'dim'
dim(x)                     # deux dimensions

## Les matrices sont remplies par colonne par défaut. L'option
## 'byrow' permet de les remplir par ligne, si nécessaire.
matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)

## Il n'est pas nécessaire de préciser les deux dimensions de
## la matrice s'il est possible d'en déduire une à partir de
## l'autre et de la longueur du vecteur de données. Les
## expressions ci-dessous sont toutes équivalentes.
matrix(1:12, nrow = 3, ncol = 4)
matrix(1:12, nrow = 3)
matrix(1:12, ncol = 4)

## À l'inverse, s'il n'y a pas assez de données pour remplir
## les dimensions précisées, les données seront recyclées,
## comme d'habitude.
matrix(1, nrow = 3, ncol = 4)
matrix(1:3, nrow = 3, ncol = 4)
matrix(1:4, nrow = 3, ncol = 4, byrow = TRUE)

## Dans l'indiçage des matrices et tableaux, l'indice de
## chaque dimension obéit aux règles usuelles d'indiçage des
## vecteurs.
x[1, 2]                    # élément en position (1, 2)
x[1, -2]                   # 1ère rangée sans 2e colonne
x[c(1, 3), ]               # 1ère et 3e rangées
x[-1, ]                    # supprimer 1ère rangée
x[, -2]                    # supprimer 2e colonne
x[x[, 1] > 2, ]            # lignes avec 1er élément > 2

## Indicer la matrice ou le vecteur sous-jacent est
## équivalent. Utiliser l'approche la plus simple selon le
## contexte.
x[1, 3]                    # l'élément en position (1, 3)...
x[7]                       # ... est le 7e élément du vecteur

## Détail additionnel sur l'indiçage des matrices et tableaux:
## il est aussi possible de les indicer avec une matrice.
## Chaque ligne de la matrice d'indiçage fournit alors la
## position d'un élément à sélectionner.
##
## Consulter au besoin la rubrique d'aide de la fonction '['
## (ou de 'Extract').
x[rbind(c(1, 1), c(2, 2))] # éléments x[1, 1] et x[2, 2]
x[cbind(1:3, 1:3)]         # éléments x[i, i] («diagonale»)
diag(x)                    # idem et plus explicite

## Quelques fonctions pour travailler avec les dimensions des
## matrices.
nrow(x)                    # nombre de lignes
dim(x)[1]                  # idem
ncol(x)                    # nombre de colonnes
dim(x)[2]                  # idem

## La fonction 'rbind' ("row bind") permet d'«empiler» des
## matrices comptant le même nombre de colonnes.
##
## De manière similaire, la fonction 'cbind' ("column bind")
## permet de concaténer des matrices comptant le même nombre de
## lignes.
##
## Utilisées avec un seul argument, 'rbind' et 'cbind' créent
## des vecteurs ligne et colonne, respectivement. Ceux-ci sont
## rarement nécessaires.
x <- matrix(1:12, 3, 4)    # 'x' est une matrice 3 x 4
y <- matrix(1:8, 2, 4)     # 'y' est une matrice 2 x 4
z <- matrix(1:6, 3, 2)     # 'z' est une matrice 3 x 2
rbind(x, 99)               # ajout d'une ligne à 'x'
rbind(x, y)                # fusion verticale de 'x' et 'y'
cbind(x, 99)               # ajout d'une colonne à 'x'
cbind(x, z)                # concaténation de 'x' et 'z'
rbind(x, z)                # dimensions incompatibles
cbind(x, y)                # dimensions incompatibles
rbind(1:3)                 # vecteur ligne
cbind(1:3)                 # vecteur colonne

## Un tableau (array) est un vecteur avec plus de deux
## dimensions. Pour le reste, la manipulation des tableaux
## est en tous points identique à celle des matrices. Ne pas
## oublier: les tableaux sont remplis de la première dimension
## à la dernière!
(x <- array(1:60, 3:5))    # tableau 3 x 4 x 5
length(x)                  # longueur du vecteur sous-jacent
dim(x)                     # trois dimensions
x[1, 3, 2]                 # l'élément en position (1, 3, 2)...
x[19]                      # ... est le 19e élément du vecteur

## Le tableau ci-dessus est un prisme rectangulaire 3 unités
## de haut, 4 de large et 5 de profond. Indicer ce prisme avec
## un seul indice équivaut à en extraire des «tranches», alors
## qu'utiliser deux indices équivaut à en tirer des «carottes»
## (au sens géologique du terme). Il est laissé en exercice de
## généraliser à plus de dimensions...
x                          # les cinq matrices
x[, , 1]                   # tranche transversale
x[, 1, ]                   # tranche verticale
x[1, , ]                   # tranche horizontale
x[, 1, 1]                  # carotte de haut en bas
x[1, 1, ]                  # carotte de devant à derrière
x[1, , 1]                  # carotte de gauche à droite
x[1, 1, 1]                 # donnée unique

###
### LISTE
###

## La liste est l'objet le plus général en R. C'est un objet
## récursif qui peut contenir des objets de n'importe quel
## mode (y compris la liste) et de n'importe quelle longueur.
(x <- list(joueur = c("V", "C", "C", "M", "A"),
           score = c(10, 12, 11, 8, 15),
           expert = c(FALSE, TRUE, FALSE, TRUE, TRUE),
           niveau = 2))
is.vector(x)               # liste est un vecteur...
is.recursive(x)            # ... récursif...
length(x)                  # ... de quatre éléments...
mode(x)                    # ... de mode "list"

## Comme tout autre vecteur, une liste peut être concaténée
## avec un autre vecteur avec la fonction 'c'.
y <- list(TRUE, 1:5)       # liste de deux éléments
c(x, y)                    # liste de six éléments

## Pour initialiser une liste d'une longueur donnée, on
## utilise la fonction 'vector'.
vector("list", 5)

## Les crochets simples [ ] permettent d'extraire un ou
## plusieurs éléments d'une liste. Le résultat est toujours
## une liste, même si l'on extraie un seul élément.
x[c(1, 2)]                 # deux premiers éléments
x[1]                       # premier élément: une liste

## Lorsque l'on veut extraire un, et un seul, élément d'une
## liste et obtenir l'objet lui-même (et non une liste
## contenant l'objet), il faut utiliser les crochets doubles
## [[ ]].
x[[1]]                     # comparer avec ci-dessus

## Jolie fonctionnalité: les crochets doubles permettent
## d'indicer récursivement la liste, c'est-à-dire d'extraire
## un objet de la liste, puis un élément de l'objet, et ainsi
## de suite.
x[[1]][2]                  # 2e élément du 1er élément
x[[c(1, 2)]]               # idem, par indiçage récursif

## Les éléments d'une liste étant généralement nommés (c'est
## une bonne habitude à prendre!), il est souvent plus simple
## et, surtout, plus sûr d'extraire les éléments d'une liste
## par leur étiquette avec l'opérateur $.
x$joueur                   # équivalent à x[[1]]
x$joueur[2]                # équivalent à x[[c(1, 2)]]
x[["expert"]]              # aussi valide, mais peu usité
x$level <- 1               # aussi pour l'affectation

## Une liste peut contenir n'importe quoi...
x[[5]] <- matrix(1, 2, 2)  # ... une matrice...
x[[6]] <- list(0:5, TRUE)  # ... une autre liste...
x[[7]] <- seq              # ... même le code d'une fonction!
x                          # eh ben!
x[[c(6, 1, 3)]]            # de quel élément s'agit-il?

## Il est possible de supprimer un élément d'une liste en lui
## affectant la valeur 'NULL'.
x[[7]] <- NULL; length(x)  # suppression du 7e élément

## Il est parfois utile de convertir une liste en un simple
## vecteur. Les éléments de la liste sont alors «déroulés», y
## compris la matrice en position 5 dans notre exemple (qui
## n'est rien d'autre qu'un vecteur, on s'en souviendra).
unlist(x)                    # remarquer la conversion
unlist(x, recursive = FALSE) # ne pas appliquer aux sous-listes
unlist(x, use.names = FALSE) # éliminer les étiquettes

###
### FACTEUR
###

## Les facteurs jouent un rôle important en analyse de
## données. surtout pour classer des données en diverses
## catégories. Les données d'un facteur devraient normalement
## afficher un fort taux de redondance.
##
## Reprenons l'exemple du chapitre.
(grandeurs <-
     factor(c("S", "S", "L", "XL", "M", "M", "L", "L")))
levels(grandeurs)          # catégories
as.integer(grandeurs)      # représentation interne

## Dans le présent exemple, nous pourrions souhaiter que R
## reconnaisse le fait que S < M < L < XL. C'est possible avec
## les facteurs *ordonnés*.
factor(c("S", "S", "L", "XL", "M", "M", "L", "L"),
       levels = c("S", "M", "L", "XL"),
       ordered = TRUE)

###
### DATA FRAME
###

## Un data frame est une liste dont les éléments sont tous de
## la même longueur. Il comporte un attribut 'dim', ce qui fait
## qu'il est représenté comme une matrice. Cependant, les
## colonnes peuvent être de modes différents.
##
## Nous créons ici le même data frame que dans l'exemple du
## chapitre, mais avec l'option 'stringsAsFactors = FALSE'
## pour éviter la conversion automatique de la colonne 'Nom'
## en facteur.
data.frame(Nom = c("Pierre", "Jean", "Jacques"),
           Age = c(42, 34, 19),
           Fumeur = c(TRUE, TRUE, FALSE),
           stringsAsFactors = FALSE)

## R est livré avec plusieurs jeux de données, la plupart sous
## forme de data frames.
data()                     # liste complète

## Nous allons illustrer certaines manipulations des data
## frames avec le jeu de données 'USArrests'.
USArrests                  # jeu de données

## Analyse succincte de l'objet.
mode(USArrests)            # un data frame est une liste...
length(USArrests)          # ... de quatre éléments...
class(USArrests)           # ... de classe 'data.frame'
dim(USArrests)             # dimensions implicites
names(USArrests)           # titres des colonnes
row.names(USArrests)       # titres des lignes
USArrests[, 1]             # première colonne
USArrests$Murder           # idem, plus simple
USArrests[1, ]             # première ligne

## La fonction 'subset' permet d'extraire des lignes et des
## colonnes d'un data frame de manière très intuitive.
##
## Par exemple, nous pouvons extraire ainsi le nombre
## d'assauts dans les états comptant un taux de meurtre
## supérieur à 10.
subset(USArrests, Murder > 10, select = Assault)

###
### IMPORTATION ET EXPORTATION DE DONNÉES
###

## Pour illustrer les procédures d'importation et
## d'exportation de données, nous allons d'abord exporter des
## données dans des fichiers pour ensuite les importer.
##
## Les fichiers seront créés dans le répertoire de travail de
## R. La commande
##
##   getwd()
##
## affiche le nom de ce répertoire.
##
## Après chaque création de fichier d'exportation, ci-dessous,
## ouvrir le fichier correspondant dans votre éditeur pour
## voir les résultats.
##
## Débutons par l'exportation d'un vecteur simple créé à
## partir d'un échantillon aléatoire des nombres de 1 à 100.
(x <- sample(1:100, 20))

## Exportation avec la fonction 'cat' sans commentaires dans
## le fichier, les données les unes à la suite des autres sur
## une seule ligne.
cat(x, file = "vecteur.data")

## Pour placer des commentaires au début du fichier, il suffit
## d'exporter deux objets: la chaine de caractères contenant
## le commentaire et le vecteur. Ici, nous insérons un retour
## à la ligne entre chaque élément.
cat("# commentaire", x, file = "vecteur.data", sep = "\n")

## La fonction 'write' permet de disposer les données
## exportées en colonnes (cinq par défaut), un peu comme une
## matrice. Exportons exactement le même vecteur de données en
## lui donnant l'apparence d'une matrice 5 x 4 (remplie par
## ligne).
write(x, file = "matrice.data", ncolumns = 4)

## Pour insérer des commentaires au début du fichier créé avec
## 'write', le plus consiste à procéder en deux étapes: on
## crée d'abord un fichier ne contenant que le commentaire (et
## le retour à la ligne) avec 'cat', puis on y ajoute les
## données avec 'write' en spécifiant 'append = TRUE' pour
## éviter d'écraser le contenu du fichier.
cat("# commentaire\n", file = "matrice.data")
write(x, file = "matrice.data", ncolumns = 4, append = TRUE)

## Pour illustrer l'exportation avec 'write.table',
## 'write.csv' et 'write.csv2', nous allons exporter le jeu de
## données 'USArrests' utilisé précédemment.
##
## Les titres des lignes sont importants dans ce jeu de
## données puisqu'ils contiennent les noms des États. Par
## défaut, les fonctions exportent tant les titres de lignes
## que les titre de colonnes.
##
## 'write.table' utilise l'espace comme séparateur des champs
## et le point comme séparateur décimal.
write.table(USArrests, "USArrests.txt")

## 'write.csv' utilise la virgule comme séparateur des champs
## et le point comme séparateur décimal.
write.csv(USArrests, "USArrests.csv")

## 'write.csv2' utilise le point-virgule comme séparateur des
## champs et la virgule comme séparateur décimal.
write.csv2(USArrests, "USArrests.csv2")

## Importons maintenant toutes ces données dans notre espace
## de travail.
##
## Les données de 'vecteur.data' (en passant, l'extension dans
## le nom de fichier n'a aucune importance) sont lues et
## importées avec la fonction 'scan'.
##
## Nous devons indiquer à la fonction que la ligne débutant
## par un # est un commentaire.
(x <- scan("vecteur.data", comment.char = "#"))

## La fonction 'scan' permet aussi de lire les données de
## 'matrice.data'. La disposition des données dans le fichier
## n'a aucune importance pour 'scan'. Il faut donc en recréer
## la structure dans R.
##
## Cette fois, nous sautons simplement la ligne du fichier
## pour omettre le commentaire.
(x <- matrix(scan("matrice.data", skip = 1),
             nrow = 5, ncol = 4, byrow = TRUE))

## L'importation des données de 'USArrests.txt',
## 'USArrests.csv' et 'USArrests.csv2' est très simple avec
## les fonctions 'read.table', 'read.csv' et 'read.csv2'.
##
## Prenez toutefois note: l'importation de données n'est pas
## toujours aussi simple. Il faut souvent avoir recours aux
## multiples autres arguments de 'read.table'
read.table("USArrests.txt")
read.csv("USArrests.csv")
read.csv2("USArrests.csv2")

## Nettoyage: la fonction 'unlink' supprime les fichiers
## spécifiés en argument, ici ceux créés précédemment dans le
## répertoire de travail.
unlink(c("vecteur.data", "matrice.data",
         "USArrests.txt", "USArrests.csv", "USArrests.csv2"))
