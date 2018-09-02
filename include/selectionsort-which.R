selectionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        ## position du minimum parmi x[i], ..., x[xlen]
        i.min <- (i - 1) + which.min(x[i:xlen])

        ## échange de x[i] et x[i.min]
        x[c(i, i.min)] <- x[c(i.min, i)]
    }
    x
}
