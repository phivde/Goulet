insertionsort <- function(x)
{
    xlen <- length(x)      # sert souvent
    for (i in seq_len(xlen))
    {
        for (j in seq_len(i - 1))
        {
            if (x[j] > x[i])
                ## Positionnement de x[i] entre les j - 1
                ## premières valeurs triées et la j-ième
                ## valeur triée x[j], puis ajout des valeurs
                ## restantes du vecteur, sauf x[i].
                ##
                ## Dans cette boucle, i >= 2 et j >= 1. Ici,
                ## 'seq' est donc «sécuritaire», mais dans
                ## d'autres cas il faut utiliser 'seq_len'
                ## pour ne pas se retrouver avec des suites
                ## comme c(1, 0) ou c(xlen + 1, xlen).
                x <- c(x[seq_len(j - 1)],
                       x[i],
                       x[seq(j, i - 1)],
                       x[i + seq_len(xlen - i)])
        }
    }
    x
}
