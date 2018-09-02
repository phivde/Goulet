bubblesort <- function(x)
{
    ind <- 2:length(x)     # suite sert souvent

    not_sorted <- TRUE     # entrer dans la boucle
    while (not_sorted)
    {
        not_sorted <- FALSE
        for (i in ind)
        {
            j <- i - 1
            if (x[i] < x[j])
            {
                x[c(i, j)] <- x[c(j, i)]
                not_sorted <- TRUE
                next
            }
        }
    }
    x
}
