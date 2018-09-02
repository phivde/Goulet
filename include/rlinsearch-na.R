rlinsearch <- function(target, x)
{
    if (length(x) == 0)
        return(NA)
    if (x[1] == target)
        return(1)
    if (x[1] > target)
        return(NA)
    1 + rlinsearch(target, x[-1])
}
