### Exemples d'utilisation des fonctions 'lapply' et 'sapply' de la
### section 6.3.

## Quatre échantillons aléatoires de tailles différentes.
(v <- lapply(5:8, sample, x = 1:100))

## Moyenne de chaque échantillon.
lapply(v, mean)

## Même chose, mais sous forme de vecteur.
sapply(v, mean)

## Une autre liste d'échantillons aléatoires.
(v <- lapply(rep(5, 3), sample, x = 1:100))

## Échantillon triés.
sapply(v, sort)
