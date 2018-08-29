## Fichier de script simple contenant des expressions R pour
## faire des calculs et créer des objets. Tout le texte qui
## suit le caractère # est ignoré.
2 + 3

## Probabilité d'une loi de Poisson(10)
x <- 7
10^x * exp(-10) / factorial(x)

## Petite fonction qui fait un calcul trivial
f <- function(x) x^2

## Évaluation de la fonction
f(2)
