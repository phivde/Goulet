rlinsearch <- function(target, x)
{
    xlen <- length(x)
    fun <- function(i)
    {
        if (i > xlen)
            return(NA)
        if (x[i] == target)
            return(i)
        if (x[i] > target)
            return(NA)
        fun(i + 1)
    }
    fun(1)
}
