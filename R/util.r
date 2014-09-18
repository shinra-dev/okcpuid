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



best_unit <- function(x)
{
  f <- 1e3
  fun <- function(x) log10(abs(x))
  dgts <- 3
  
  size <- x
  class(size) <- NULL
  
  if (size == 0)
    return( .__Rcpuid_flops$names[1L] )
  
  
  num.digits <-fun(size)
    
  for (i in seq.int(9))
  {
    if (num.digits < dgts*i)
    {
      unit <- .__Rcpuid_flops$names[i]
      break
    }
  }
  
  size <- size/(f^(i-1))
  
  ret <- list(size=size, name=.__Rcpuid_flops$names[i])
  
  return( ret )
}

