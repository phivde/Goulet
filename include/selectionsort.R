selectionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        ## recherche de la position de la plus petite valeur
        ## parmi x[i], ..., x[xlen]
        i.min <- i
        for (j in i:xlen)
        {
            if (x[j] < x[i.min])
                i.min <- j
        }

        ## échange de x[i] et x[i.min]
        x[c(i, i.min)] <- x[c(i.min, i)]
    }
    x
}
