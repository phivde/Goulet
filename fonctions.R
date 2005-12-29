### Premier exemple de fonction: la mise en oeuvre de
### l'algorithme du point fixe pour trouver le taux d'intérêt
### tel que a_angle{n} = k pour 'n' et 'k' donnés. Cette mise
### en oeuvre est peu générale puisqu'il faudrait modifier la
### fonction à chaque fois que l'on change la fonction f(x)
### dont on cherche le point fixe.
fp1 <- function(k, n, start=0.05, TOL=1E-10)
{
    i <- start
    repeat
    {
        it <- i
        i <- (1 - (1 + it)^(-n))/k
        if (abs(i - it)/it < TOL)
            break
    }
    i
}

fp1(7.2, 10)               # valeur de départ par défaut
fp1(7.2, 10, 0.06)         # valeur de départ spécifiée
i                          # les variables n'existent pas
start                      # dans l'espace de travail

### Second exemple: généralisation de la fonction 'fp1' où la
### fonction f(x) dont on cherche le point fixe (c'est-à-dire
### la valeur de 'x' tel que f(x) = x) est passée en
### argument. On peut faire ça? Bien sûr, puisqu'une fonction
### est un objet comme un autre en S. On ajoute également à
### la fonction un argument 'echo' qui, lorsque TRUE, fera
### en sorte d'afficher à l'écran les valeurs successives
### de 'x'.
fp2 <- function(FUN, start, echo=FALSE, TOL=1E-10)
{
    x <- start
    repeat
    {
        xt <- x

        if (echo)  # inutile de faire 'if (echo == TRUE)'
            print(xt)

        x <- FUN(xt)

        if (abs(x - xt)/xt < TOL)
            break
    }
    x
}

f <- function(i) (1 - (1+i)^(-10))/7.2 # définition de f(x)
fp2(f, 0.05)               # solution
fp2(f, 0.05, echo=TRUE)    # avec résultats intermédiaires
fp2(function(x) 3^(-x), start=0.5) # avec une fonction anonyme

### Troisième exemple: amélioration mineure à la fonction
### 'fp2'. Puisque la valeur de 'echo' ne change pas pendant
### l'exécution de la fonction, on peut éviter de refaire le
### test à chaque itération de la boucle. Une solution
### élégante consiste à utiliser un outil avancé du langage S:
### les expressions. On se contentera d'une illustration ici,
### sans entrer dans les détails.
fp3 <- function(FUN, start, echo=FALSE, TOL=1E-10)
{
    x <- start

    if (echo)
        expr <- expression(print(xt <- x))
    else
        expr <- expression(xt <- x)

    repeat
    {
        eval(expr)

        x <- FUN(xt)

        if (abs(x - xt)/xt < TOL)
            break
    }
    x
}

fp3(f, 0.05, echo=TRUE)    # avec résultats intermédiaires
fp3(function(x) 3^(-x), start=0.5) # avec une fonction anonyme

### La suite de Fibonacci (et son lien avec le nombre d'or) a
### été remise au goût du jour par le best seller «Code Da
### Vinci». Les valeurs de la suite de Fibonacci sont données
### par la fonction suivante:
###
###      f(0) = 0
###      f(1) = 1
###      f(n) = f(n - 1) + f(n - 2), n >= 2.
###
### Voici deux exemples de fonctions calculant la suite de
### Fibonacci. La première calcule les 'n' premières valeurs
### de la série.
fib1 <- function(n)
{
    res <- c(0, 1)
    for (i in 3:n)
        res[i] <- res[i - 1] + res[i - 2]
    res
}
fib1(10)
fib1(20)

### La fonction 'fib1' a un gros défaut: la taille de l'objet
### 'res' est constamment augmentée pour stocker une nouvelle
### valeur de la série. Cela coûte très cher en S et doit
### absolument être évité lorsque c'est possible (et ce l'est
### la plupart du temps). Quand on sait quelle sera la
### longueur d'un objet (comme c'est le cas ici), il vaut
### mieux créer un contenant vide de la bonne longueur et le
### remplir par la suite.
fib2 <- function(n)
{
    res <- numeric(n)      # contenant créé
    res[2] <- 1            # res[1] vaut déjà 0
    for (i in 3:n)
        res[i] <- res[i - 1] + res[i - 2]
    res
}
fib2(10)
fib2(20)

### A-t-on vraiment gagné quelque chose? Comparons le temps
### requis pour générer une longue suite de Fibonacci avec les
### deux fonctions. (En fait, le gain est beaucoup plus
### important avec R qu'avec S-Plus.)
sys.time(fib1(10000))      # S-Plus seulement
sys.time(fib2(10000))      # S-Plus seulement
system.time(fib1(10000))   # R seulement
system.time(fib2(10000))   # R seulement

### Second exemple basé sur le suite de Fibonacci: une
### fonction pour calculer non pas les 'n' premières valeurs
### de la suite, mais uniquement la 'n'ieme valeur.
###
### Mais il y a un mais: la fonction 'fib3' est truffée
### d'erreurs (de syntaxe, d'algorithmique, de conception). À
### vous de trouver les bogues. (Afin de préserver cet
### exemple, copier le code erroné plus bas ou dans un autre
### fichier avant d'y faire les corrections.)
fib3 <- function(nb)
{
    x <- 0
    x1 _ 0
    x2 <- 1
    while (n > 0))
x <- x1 + x2
x2 <- x1
x1 <- x
n <- n - 1
}
fib3(1)                    # devrait donner 0
fib3(2)                    # devrait donner 1
fib3(5)                    # devrait donner 3
fib3(10)                   # devrait donner 34
fib3(20)                   # devrait donner 4181
