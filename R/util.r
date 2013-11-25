flops_error <- function() stop("Badly formed 'flops' object", call.=FALSE)



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



convert_to_flops <- function(x)
{
  size <- x@size
  
  n <- which(tolower(x@unit) == .flops[[x@unit.names]][["check"]])
  
  size <- intpow(size, 10, .flops[["ordmag"]][n])
  
  x@size <- size
  x@unit <- .flops[[x@unit.names]][["print"]][1L]
  
  return( x )
}



best_unit <- function(x)
{
  f <- 1e3
  fun <- function(x) log10(abs(x))
  dgts <- 3
  
  size <- convert_to_flops(x)@size
  
  if (size == 0)
  {
    x@unit.names <- .flops[[x@unit.names]][["print"]][1L]
    return( x )
  }
  
  
  num.digits <-fun(size)
    
  for (i in seq.int(9))
  {
    if (num.digits < dgts*i)
    {
      unit <- .flops[i]
      break
    }
  }
  
  size <- size/(f^(i-1))
  
  x@size <- size
  x@unit <- .flops[[x@unit.names]][["print"]][i]
  
  return( x )
}
