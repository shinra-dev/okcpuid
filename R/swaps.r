# Switch out names from short to long or vice versa
setMethod("swap.names", signature(x="flops"),
  function(x)
  {
    if (x@unit.names == "short")
      new.names <- "long"
    else if (x@unit.names == "long")
      new.names <- "short"
    else
      flops_error()
    
    new.unit <- which(.flops[[x@unit.names]][["print"]] == x@unit)
    
    x@unit <- .flops[[new.names]][["print"]][new.unit]
    
    x@unit.names <- new.names
    
    return( x )
  }
)



setMethod("swap.unit", signature(x="flops"),
  function(x, unit)
  {
    unit <- tolower(unit)
    
    if (unit == tolower(x@unit))
      return(x)
    
    if (unit == "best")
      x <- best_unit(x)
    else if (unit == tolower(x@unit))
      return( check.flops(x) )
    else 
    {
      flag <- FALSE
      
      for (names in c("short", "long"))
      {
        if ( unit %in% .flops[[names]][["check"]] )
        {
          flag <- TRUE
          unit.names <- names
          
          break
        }
        
        if (flag)
          break
      }
      
      if (flag){
        x <- convert_to_flops(x)
        
        x@unit.names <- unit.names
        
        f <- 1e3
        
        units <- .flops[[x@unit.names]][["check"]]
        i <- which(units == unit)
        
        x@size <- x@size/(f^(i-1))
        
        new.unit <- .flops[[unit.names]][["print"]][i]
        
        x@unit <- new.unit
      }
      else
        stop("invalid argument 'unit'. See help('memuse')")
    }
    
    return( x )
  }
)

