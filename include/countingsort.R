countingsort <- function(x, min, max)
{
    min1m <- min - 1               # sert souvent
    counts <- numeric(max - min1m) # initialisation

    for (i in seq_along(x))
    {
        j <- x[i] - min1m
        counts[j] <- counts[j] + 1
    }

    ## suite des nombres de 'min' à 'max' répétés chacun le
    ## bon nombre de fois
    rep(min:max, counts)
}
