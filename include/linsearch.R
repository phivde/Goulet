linsearch <- function(target, x)
{
    for (i in seq_along(x))
    {
        if (x[i] == target)
            return(i)
        if (x[i] > target)
            return(NA)
    }
    NA                     # valeur non trouvée
}
