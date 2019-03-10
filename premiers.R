### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet
## «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

###
### DONNÉES ET PROCÉDURES FONDAMENTALES  `\labelline{premiers:fondamentales}`
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
##  https://floating-point-gui.de/formats/fp/]
1.2 + 1.4 + 2.8            # 5.4 en apparence
1.2 + 1.4 + 2.8 == 5.4     # non?!?
0.3/0.1 == 3               # à gauche: faux entier `\labelline{premiers:fondamentales:fin}`

###
### COMMANDES R            `\labelline{premiers:commandes}`
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
{x <- 5; y <- 2; x + y}    # valide, mais redondant `\labelline{premiers:commandes:fin}`

###
### OBJETS R               `\labelline{premiers:objets}`
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
x                          # identification facilitée `\labelline{premiers:objets:fin}`

###
### VECTEURS               `\labelline{premiers:vecteurs}`
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
!0:5                       #-*- `\labelline{premiers:vecteurs:fin}`

###
### APPEL D'UNE FONCTION   `\labelline{premiers:appel}`
###

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
matrix(nrow = 3, ncol = 4, 1:12, FALSE) #-*- `\labelline{premiers:appel:fin}`

###
### QUELQUES FONCTIONS INTERNES UTILES  `\labelline{premiers:internes}`
###

## Pour les exemples qui suivent, on se donne un vecteur non
## ordonné.
x <- c(50, 30, 10, 20, 60, 30, 20, 40)

## FONCTIONS MATHÉMATIQUES ET TRIGONOMÉTRIQUES

## R contient des fonctions pour calculer la plupart des
## fonctions mathématiques et trigonométriques usuelles.
exp(c(1, 2, -1))           # exponentielle
log(exp(c(1, 2, -1)))      # logarithme naturel
log10(c(1, 10, 100))       # logarithme en base 10
log(c(1, 5, 25), base = 5) # logarithme en base quelconque
sqrt(x)                    # racine carrée
abs(x - mean(x))           # valeur absolue
gamma(1:5)                 # fonction gamma
factorial(0:4)             # factorielle
?gamma                     # toutes les fonctions apparentées
cos(seq(0, pi, by = pi/4)) # cosinus
sin(seq(0, pi, by = pi/4)) # sinus
tan(seq(0, pi, by = pi/4)) # tangente
?Trig                      # toutes les fonctions apparentées

## SUITES ET RÉPÉTITION

## La fonction 'seq' sert à générer des suites générales. Ses
## principaux arguments sont 'from', 'to' et 'by'.
seq(from = 1, to = 10)       # équivalent à 1:10
seq(10)                      # idem
seq(1, 10, by = 2)           # avec incrément autre que 1
seq(-10, 10, length.out = 5) # incrément automatique

## La fonction 'seq_len' génère une suite de longueur 'n' à
## partir de 1. C'est une version simplifiée et plus rapide de
## 'seq(..., length.out = n)'. De plus, elle est plus robuste
## lorsque l'argument est 0.
seq(10)                    # suite 1, 2, ..., 10
seq(1, length.out = 10)    # idem robuste
seq_len(10)                # équivalent et plus rapide
seq(0)                     # pas ce que l'on penserait!
seq(1, length.out = 0)     # plus prudent
seq_len(0)                 # plus simple

## La fonction 'seq_along' génère une suite de la longueur du
## vecteur en argument à partir de 1. C'est une version
## simplifiée et plus rapide de 'seq(..., along = x)' et de
## 'seq_len(length(x))'.
seq(1, along = x)            # suite de la longueur de x
seq_len(length(x))           # idem, mais deux fonctions
seq_along(x)                 # plus rapide, plus simple

## La fonction 'rep' permet de répéter des vecteurs de
## plusieurs manières différentes.
rep(1, 10)                  # utilisation de base
rep(x, 2)                   # répéter un vecteur
rep(x, each = 4)            # répéter chaque élément
rep(x, times = 2, each = 4) # combinaison des arguments
rep(x, length.out = 20)     # résultat de longueur déterminée
rep(x, times = 1:8)         # nombre de répétitions différent
                            # pour chaque élément de 'x'

## Pour les deux types de répétitions les plus usuels, il y a
## les fonctions 'rep.int' et 'rep_len' qui sont plus rapides
## que 'rep'.
rep.int(x, 2)              # seulement répétition 'times'
rep_len(x, 10)             # seulement répétition 'length.out'

## EXTRACTION DU DÉBUT ET DE LA FIN D'UN OBJET

## L'idée des fonctions 'head' et 'tail', c'est que l'on se
## positionne en tête ou en queue d'un objet pour effectuer
## des extractions ou des suppressions de composantes.
##
## Avec un argument positif, les fonctions extraient des
## composantes depuis la tête ou la queue de l'objet. Avec un
## argument négatif, elles suppriment des composantes à
## l'«autre bout» de l'objet.
head(x, 3)                 # trois premiers éléments
head(x, -2)                # tous sauf les deux derniers
tail(x, 3)                 # trois derniers éléments
tail(x, -2)                # tous sauf les deux premiers

## Les fonctions sont aussi valides sur les matrices et les
## data frames. Elles extraient ou suppriment alors des lignes
## entières.
m <- matrix(1:30, 5, 6)    # matrice 5 x 6
head(m, 3)                 # trois premières lignes
tail(m, -2)                # sans les deux premières lignes

## ARRONDI
(x <- c(-21.2, -pi, -1.5, -0.2, 0, 0.2, 1.7823, 315))
round(x)                   # arrondi à l'entier
round(x, 2)                # arrondi à la seconde décimale
round(x, -1)               # arrondi aux dizaines
ceiling(x)                 # plus petit entier supérieur
floor(x)                   # plus grand entier inférieur
trunc(x)                   # troncature des décimales

## TESTS LOGIQUES

## Les fonctions 'any' et 'all' prennent en argument un
## vecteur booléen et elles indiquent, respectivement, si au
## moins une ou si toutes les valeurs sont TRUE.
any(c(TRUE, FALSE, FALSE))  # au moins une valeur TRUE
any(c(FALSE, FALSE, FALSE)) # aucune valeur TRUE
all(c(TRUE, TRUE, TRUE))    # toutes les valeurs TRUE
all(c(TRUE, FALSE, TRUE))   # aucune valeur TRUE

## Les fonctions sont des compléments l'une de l'autre: si
## 'any(x)' est TRUE, alors 'all(!x)' est FALSE, et
## vice-versa.
any(c(TRUE, FALSE, FALSE))   # TRUE
all(!c(TRUE, FALSE, FALSE))  # complément: FALSE
any(c(FALSE, FALSE, FALSE))  # FALSE
all(!c(FALSE, FALSE, FALSE)) # complément: TRUE

## Les fonctions sont habituellement utilisées avec une
## expression logique en argument.
x                          # rappel
x > 50                     # valeurs > 50?
x <= 50                    # valeurs <= 50?
any(x > 50)                # y a-t-il des valeurs > 50?
all(x <= 50)               # complément
all(x > 50)                # toutes les valeurs > 50?
any(x <= 50)               # complément

## SOMMAIRES ET STATISTIQUES DESCRIPTIVES
sum(x)                     # somme des éléments
prod(x)                    # produit des éléments
diff(x)                    # x[2] - x[1], x[3] - x[2], etc.
mean(x)                    # moyenne des éléments
mean(x, trim = 0.125)      # moyenne sans minimum et maximum
var(x)                     # variance (sans biais)
sd(x)                      # écart type
max(x)                     # maximum
min(x)                     # minimum
range(x)                   # c(min(x), max(x))
diff(range(x))             # étendue de 'x'
median(x)                  # médiane (50e quantile) empirique
quantile(x)                # quantiles empiriques
quantile(x, 1:10/10)       # on peut spécifier les quantiles
summary(x)                 # plusieurs des résultats ci-dessus

## SOMMAIRES CUMULATIFS ET COMPARAISONS ÉLÉMENT PAR ÉLÉMENT
(x <- sample(1:20, 6))
(y <- sample(1:20, 6))
cumsum(x)                  # somme cumulative de 'x'
cumprod(y)                 # produit cumulatif de 'y'
rev(cumprod(rev(y)))       # produit cumulatif renversé
cummin(x)                  # minimum cumulatif
cummax(y)                  # maximum cumulatif
pmin(x, y)                 # minimum élément par élément
pmax(x, y)                 # maximum élément par élément `\labelline{premiers:internes:fin}`
