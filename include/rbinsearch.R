rbinsearch <- function(target, x)
{
    fun <- function(min, max)
    {
        if (min > max)
            return(NA)
        mid <- floor((min + max)/2)
        if (target < x[mid])
            fun(min, mid - 1)
        else if (target > x[mid])
            fun(mid + 1, max)
        else
            return(mid)
    }
    fun(1, length(x))
}
