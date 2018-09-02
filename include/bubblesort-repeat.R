bubblesort <- function(x)
{
    ind <- 2:length(x)      # sert souvent

    repeat
    {
        sorted <- TRUE
        for (i in ind)
        {
            j <- i - 1
            if (x[i] < x[j])
            {
                x[c(i, j)] <- x[c(j, i)]
                sorted <- FALSE
                next
            }
        }
        if (sorted)
            break
    }
    x
}
