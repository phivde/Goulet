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
### DONNÉES ET PROCÉDURES FONDAMENTALES                       `\labelline{bases:fondamentales}`
###

## Nombres. Tous les nombres réels sont stockés en double
## précision dans R, entiers comme fractionnaires.
486                        # nombre réel entier
0.3324                     # nombre réel fractionnaire
2e-3                       # notation scientifique
1 + 2i                     # nombre complexe

## Tout objet en R comporte au minimum un mode et une
## longueur.
mode(486)                  # pas de différence entre entier...
mode(0.3324)               # ... et nombre réel
length(486)                # vecteur de longueur 1
mode(1 + 2i)               # nombre complexe

## Valeurs booléennes. 'TRUE' et 'FALSE' sont des noms
## réservés pour identifier les valeurs booléennes
## correspondantes.
TRUE                       # vrai
FALSE                      # faux
mode(TRUE)                 # mode "logical"
! c(TRUE, FALSE)           # négation logique
TRUE & FALSE               # ET logique
TRUE | FALSE               # OU logique

## [Détails additionnels sur les expressions logiques. Les
## expressions suivantes construisent un «tableau de vérité»
## entre deux énoncés 'p' et 'q' qui peuvent chacun être
## «vrai» ou «faux». Le ET logique est vrai seulement lorsque
## les deux énoncés sont vrais, alors que le OU logique est
## faux seulement lorsque les deux énoncés sont faux.]
p <- c(TRUE, TRUE, FALSE, FALSE)
q <- c(TRUE, FALSE, TRUE, FALSE)
cbind("p" = p, "q" = q, "p ET q" = p & q, "p OU q" = p | q)

## Donnée manquante. 'NA' est un nom réservé pour représenter
## une donnée manquante.
c(65, NA, 72, 88)          # traité comme une valeur
NA + 2                     # tout calcul avec 'NA' donne NA
is.na(c(65, NA))           # test si les données sont NA

## Valeurs infinies et indéterminée. 'Inf', '-Inf' et 'NaN'
## sont des noms réservés.
1/0                        # +infini
-1/0                       # -infini
0/0                        # indétermination
x <- c(65, Inf, NaN, 88)   # s'utilisent comme des valeurs
is.finite(x)               # quels sont les nombres réels?
is.nan(x)                  # lesquels sont indéterminés?

## Valeur "néant". 'NULL' est un nom réservé pour représenter
## le néant, rien.
mode(NULL)                 # le mode de 'NULL' est NULL
length(NULL)               # longueur nulle
c(NULL, NULL)              # du néant ne résulte que le néant

## Chaines de caractères. On crée une chaine de caractères en
## l'entourant de guillemets doubles " ".
"foobar"                   # *une* chaine de 6 caractères
length("foobar")           # longueur de 1
c("foo", "bar")            # *deux* chaines de 3 caractères
length(c("foo", "bar"))    # longueur de 2

## L'opérateur modulo retourne le reste d'une division.
5 %% 2                     # 5/2 = 2 reste 1
5 %% 1:5                   # remarquer la périodicité
10 %% 1:15                 # x %% y = x si x < y

## Un nombre 'x' est pair si 'x mod 2 = 0' et il est impair si
## 'x mod 2 = 1'.
a <- c("Impair", "Pair")
x <- c(2, 3, 6, 8, 9, 11, 12)
x %% 2                     # pair ou impair?
2 - x %% 2                 # observer priorité des opérations
a[2 - x %% 2]              # indiçage à répétition

## La division entière retourne la partie entière de la
## division d'un nombre par un autre.
5 %/% 1:5
10 %/% 1:15

## L'opérateur à utiliser pour vérifier si deux valeurs sont
## égales est '==', et non '='. Utiliser le mauvais opérateur
## est une erreur commune --- et qui peut être difficile à
## détecter --- lorsque l'on programme en R.
5 = 2                      # erreur de syntaxe
5 == 2                     # comparaison
y = 2                      # pas un test...
y                          # ... plutôt une affectation

## Attention, toutefois: '==' vérifie l'égalité bit pour bit
## dans la représentation interne des nombres dans
## l'ordinateur. Ça fonctionne bien pour les entiers ou les
## valeurs booléennes, mais pas pour les nombres réels ou,
## plus insidieux, pour les nombres entiers provenant d'un
## calcul et qui ne sont entiers qu'en apparence.
##
## [Pour en savoir (un peu) plus:
##  http://floating-point-gui.de/formats/fp/]
1.2 + 1.4 + 2.8            # 5.4 en apparence
1.2 + 1.4 + 2.8 == 5.4     # non?!?
0.3/0.1 == 3               # à gauche: faux entier            `\labelline{bases:fondamentales:fin}`

###
### COMMANDES R                                               `\labelline{bases:commandes}`
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

## Entrer le nom d'un objet affiche son contenu. Pour une
## fonction, c'est son code source qui est affiché.
pi                         # constante numérique intégrée
letters                    # chaîne de caractères intégrée
LETTERS                    # version en majuscules
matrix                     # fonction

## On crée des nouveaux objets en leur affectant une valeur
## avec l'opérateur '<-'. *Ne pas* utiliser '=' pour
## l'affectation.
x <- 5                     # affectation de 5 à l'objet 'x'
5 -> x                     # idem, mais peu utilisé
x                          # voir le contenu
(x <- 5)                   # affectation et affichage
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
    x + y                  # dernière expression du groupe
}                          # fin du groupe et résultat
{x <- 5; y <- 2; x + y}    # valide, mais redondant           `\labelline{bases:commandes:fin}`

###
### OBJETS R                                                  `\labelline{bases:objets}`
###

## NOMS D'OBJETS

## Quelques exemples de noms valides et invalides.
foo <- 5                   # valide
foo.123 <- 5               # valide
foo_123 <- 5               # valide
123foo <- 5                # invalide; commence par un chiffre
.foo <- 5                  # valide
.123foo <- 5               # invalide; point suivi d'un chiffre

## Liste des objets dans l'espace de travail. Les objets dont
## le nom commence par un point sont cachés, comme à la ligne
## de commande Unix.
ls()                       # l'objet '.foo' n'est pas affiché
ls(all.names = TRUE)       # objets cachés aussi affichés

## R est sensible à la casse
foo <- 1
Foo
FOO

## MODES ET TYPES DE DONNÉES

## Le mode d'un objet détermine ce qu'il peut contenir. Les
## vecteurs simples ("atomic") contiennent des données d'un
## seul type.
mode(c(1, 4.1, pi))        # nombres réels
mode(c(2, 1 + 5i))         # nombres complexes
mode(c(TRUE, FALSE, TRUE)) # valeurs booléennes
mode("foobar")             # chaînes de caractères

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

## ATTRIBUTS

## Les objets peuvent être dotés d'un ou plusieurs attributs.
data(cars)                 # jeu de données intégré
attributes(cars)           # liste de tous les attributs
attr(cars, "class")        # extraction d'un seul attribut

## L'attribut 'names' conserve les étiquettes des éléments
## d'un vecteur.
x <- 1:24                  # un vecteur
names(x) <- letters[1:24]  # attribution d'étiquettes
x                          # identification facilitée         `\labelline{bases:objets:fin}`

###
### VECTEURS                                                  `\labelline{bases:vecteurs}`
###

## La fonction de base pour créer des vecteurs est 'c'. Il
## peut s'avérer utile de nommer les éléments d'un vecteur.
x <- c(A = -1, B = 2, C = 8, D = 10) # création d'un vecteur
names(x)                             # extraire les noms
names(x) <- letters[1:length(x)]     # changer les noms
x                                    # nouveau vecteur

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

## Si l'on mélange dans un même vecteur des objets de mode
## différents, il y a conversion forcée vers le mode pour
## lequel il y a le moins de perte d'information, c'est-à-dire
## vers le mode qui permet le mieux de retrouver la valeur
## originale des éléments.
c(5, TRUE, FALSE)          # conversion en mode 'numeric'
c(5, "z")                  # conversion en mode 'character'
c(TRUE, "z")               # conversion en mode 'character'
c(5, TRUE, "z")            # conversion en mode 'character'

### INDIÇAGE

## L'indiçage est une opération importante et beaucoup
## utilisée. Elle sert à extraire des éléments d'un vecteur
## avec la construction 'x[i]', ou à les remplacer avec la
## construction 'x[i] <- y'. Les fonctions sous-jacentes sont
## '[' et '[<-'.
##
## Les expressions suivantes illustrent les cinq méthodes
## d'indiçage.
x                          # le vecteur
x[1]                       # extraction par position
"["(x, 1)                  # idem avec la fonction '['
x[-2]                      # suppression par position
x[x > 5]                   # extraction par critère
x["c"]                     # extraction par nom
x[]                        # tous les éléments
x[numeric(0)]              # différent d'indice vide

## Pour le prochain bloc d'exemples, nous remplaçons deux
## données du vecteur 'x' par NA avec la construction 'x[i] <-
## y'.
x[c(1, 4)] <- NA           # manière usuelle
"[<-"(x, c(1, 4), NA)      # idem, mais très peu usité

## Il arrive souvent de vouloir indicer spécifiquement les
## données manquantes d'un vecteur (pour les éliminer ou pour
## les remplacer par une autre valeur, par exemple).
##
## Pour ce faire, on utilise la fonction 'is.na' et l'indiçage
## par un vecteur booléen.
is.na(x)                   # positions des données manquantes
x[!is.na(x)]               # suppression des données manquantes
x[is.na(x)] <- 0; x        # remplacement des NA par des 0

## Laissons tomber les noms de l'objet.
names(x) <- NULL           # suppression de l'attribut 'names'

## Quelques cas spéciaux d'indiçage.
length(x)                  # rappel de la longueur
x[1:8]                     # vecteur allongé avec des NA
x[0]                       # extraction de rien
x[0] <- 1; x               # affectation de rien
x[c(0, 1, 2)]              # indice 0 ignoré
x[c(1, NA, 5)]             # indice NA retourne NA
x[2.6]                     # fractions tronquées vers 0

## ARITHMÉTIQUE VECTORIELLE

## L'unité de base de l'arithmétique en R est le vecteur. Cela
## rend très simple et intuitif de faire des opérations
## mathématiques courantes.
##
## Là où plusieurs langages de programmation exigent des
## boucles, R fait le calcul directement.
##
## En effet, les règles de l'arithmétique en R sont
## globalement les mêmes qu'en algèbre vectorielle et
## matricielle.
5 * c(2, 3, 8, 10)         # multiplication par une constante
c(2, 6, 8) + c(1, 4, 9)    # addition de deux vecteurs
c(0, 3, -1, 4)^2           # élévation à une puissance

## Dans les règles de l'arithmétique vectorielle, les
## longueurs des vecteurs doivent toujours concorder.
##
## R permet plus de flexibilité en recyclant les vecteurs les
## plus courts dans une opération.
##
## Il n'y a donc à peu près jamais d'erreurs de longueur en R!
## C'est une arme à deux tranchants: le recyclage des vecteurs
## facilite le codage, mais peut aussi résulter en des
## réponses complètement erronées sans que le système ne
## détecte d'erreur.
8 + 1:10                   # 8 est recyclé 10 fois
c(2, 5) * 1:10             # c(2, 5) est recyclé 5 fois
c(-2, 3, -1, 4)^(1:4)      # quatre puissances différentes

## Dans les opérations arithmétiques (ou, plus généralement,
## les opérations conçues pour travailler avec des nombres),
## les valeurs booléennes TRUE et FALSE sont automatiquement
## converties en 1 et 0, respectivement. Conséquence: il est
## possible de faire des calculs avec des valeurs booléennes!
c(5, 3) + c(TRUE, FALSE)   # équivalent à c(5, 3) + c(1, 0)
5 + (3 < 4)                # (3 < 4) vaut TRUE
5 + 3 < 4                  # priorité des opérations!

## Dans les opérations logiques, ce sont les nombres qui sont
## convertis en valeurs booléennes. Dans ce cas, zéro est
## traité comme FALSE et tous les autres nombres comme TRUE.
0:5 & 5:0
0:5 | 5:0
!0:5                       #-*-                               `\labelline{bases:vecteurs}`

###
### FONCTIONS                                                 `\labelline{bases:fonctions}`
###

### PROGRAMMATION FONCTIONNELLE

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
c(seq, rep)                # vecteur de fonctions!

### DÉFINITION D'UNE FONCTION

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

### Fonction anonyme

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

### Valeur par défaut d'un argument

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

### Argument '...'

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
ocurve(x^2, from = 0, to = 2)

### APPEL D'UNE FONCTION

## L'interpréteur R reconnait un appel de fonction au fait que
## le nom de l'objet est suivi de parenthèses ( ).
##
## Une fonction peut n'avoir aucun argument ou plusieurs. Il
## n'y a pas de limite pratique au nombre d'arguments.
##
## Les arguments d'une fonction peuvent être spécifiés selon
## l'ordre établi dans la définition de la fonction.
##
## Cependant, il est beaucoup plus prudent et *fortement
## recommandé* de spécifier les arguments par leur nom avec
## une construction de la forme 'nom = valeur', surtout après
## les deux ou trois premiers arguments.
##
## L'ordre des arguments est important; il est donc nécessaire
## de les nommer s'ils ne sont pas appelés dans l'ordre.
##
## Certains arguments ont une valeur par défaut qui sera
## utilisée si l'argument n'est pas spécifié dans l'appel de
## la fonction.
##
## Examinons la définition de la fonction 'matrix', qui sert à
## créer une matrice à partir d'un vecteur de valeurs.
args(matrix)

## La fonction compte cinq arguments et chacun a une valeur
## par défaut (ce n'est pas toujours le cas).
##
## Quel sera le résultat de l'appel ci-dessous?
matrix()

## Les invocations de la fonction 'matrix' ci-dessous sont
## toutes équivalentes.
##
## Portez attention si les arguments sont spécifiés par nom ou
## par position.
matrix(1:12, 3, 4)
matrix(1:12, ncol = 4, nrow = 3)
matrix(nrow = 3, ncol = 4, data = 1:12)
matrix(nrow = 3, ncol = 4, byrow = FALSE, 1:12)
matrix(nrow = 3, ncol = 4, 1:12, FALSE) #-*-                  `\labelline{bases:fonctions:fin}`
