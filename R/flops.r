setClass("FLOPS",
          representation(
                         size="numeric",
                         unit="character",
                         unit.names="character"
          ),
          prototype(
                         size=0,
                         unit="FLOPS",
                         unit.names="short"
          )
)


### print methods
setMethod("print", signature(x="FLOPS"),
  function(x, ..., unit=x@unit, unit.names=x@unit.names, digits=3)
  {
    if (unit.names != x@unit.names)
      x <- swap.names(x=x)
    if (unit != x@unit)
      x <- swap.unit(x=x, unit=unit)
    
    unit <- tolower(x@unit)
    
    if (unit == "flops")
      digits <- 0
    
    if (x@size > 1e22)
      format <- "e"
    else
      format <- "f"
    
    cat(sprintf(paste("%.", digits, format, " ", x@unit, "\n", sep=""), x@size))
  }
)



### show methods
setMethod("show", signature(object="FLOPS"),
  function(object) 
    print(object, unit=object@unit, unit.names=object@unit.names, digits=3)
)




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
      unit <- .units[i]
      break
    }
  }
  
  size <- size/(f^(i-1))
  
  x@size <- size
  x@unit <- .flops[[x@unit.names]][["print"]][i]
  
  return( x )
}



setMethod("swap.unit", signature(x="FLOPS"),
  function(x, unit)
  {
    unit <- tolower(unit)
    
    if (unit == tolower(x@unit))
      return(x)
    
    if (unit == "best")
    {
      x <- best_unit(x)
    }
    else if (unit == tolower(x@unit))
    {
      return( check.mu(x) )
    }
    else 
    {
      flag <- FALSE
      
      for (names in c("short", "long"))
      {
        if ( unit %in% .units[[names]][[prefix]][["check"]] )
        {
          flag <- TRUE
          unit.names <- names
          unit.prefix <- prefix
          break
        }
        
        if (flag)
          break
      }
      
      if (flag){
        x <- convert_to_bytes(x)
        
        x@unit.names <- unit.names
        x@unit.prefix <- unit.prefix
        
        if (unit.prefix == "IEC")
          f <- 1024
        else
          f <- 1e3
        
        units <- .units[[x@unit.names]][[x@unit.prefix]][["check"]]
        i <- which(units == unit)
        
        x@size <- x@size/(f^(i-1))
        
        new.unit <- .units[[unit.names]][[unit.prefix]][["print"]][i]
        
        x@unit <- new.unit
      }
      else
        stop("invalid argument 'unit'. See help('memuse')")
    }
    
    return( x )
  }
)


x <- new("FLOPS", size=100, unit="MFLOPS")

swap.unit(x, "KFLOPS")


