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

