binsearch <- function(target, x)
{
    min <- 1
    max <- length(x)

    while(min <= max)
    {
        mid <- floor((min + max)/2)
        if (target < x[mid])
            max <- mid - 1
        else if (target > x[mid])
            min <- mid + 1
        else
            return(mid)
    }
    NA                     # valeur non trouvée
}
