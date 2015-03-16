# a * b^c
intpow <- function(a, b, c)
{
  if (c == 0)
    return(a)
  
  pow <- a
  
  while(1)
  {
    if (c%%2 == 1)
      pow <- pow * b
    
    c <- floor(c/2)
    if (c == 0)
      break
    
    b <- b*b
  }
  
  return( pow )
}



### from a to b by doubling
a2b_int_doubling <- function(a, b)
{
  n <- floor(log2(b/a))
  if (b %% 2 == 0)
    n <- n + 1
  
  vals <- integer(n)
  vals[1] <- a
  N <- a
  
  i <- 2
  while (N < b)
  {
    N <- 2L*N
    if (N <= b)
    {
      vals[i] <- N
      i <- i+1
    }
  }
  
  return(vals)
}



title_case <- function(x) gsub(x, pattern="(^|[[:space:]])([[:alpha:]])", replacement="\\1\\U\\2", perl=TRUE)

