### Accessors
setMethod("size", signature(x="flops"),
  function(x, as.is=TRUE)
  {
    if (as.is)
      return(x@size)
    else
      return(convert_to_bytes(x)@size)
  }
)

setMethod("unit", signature(x="flops"),
  function(x)
    return(x@unit)
)

setMethod("unit.names", signature(x="flops"),
  function(x)
    return(x@unit.names)
)



### Replacers
setReplaceMethod("size", signature(x="flops"),
  function(x, value)
  {
    x@size <- value
    x <- check.flops(x)
    
# x <- swap.unit(x=x, unit=.UNIT)
    
    return( x )
  }
)

setReplaceMethod("unit", signature(x="flops"),
  function(x, value)
  {
    x@unit <- value
    x <- check.flops(x)
    
    return( x )
  }
)

setReplaceMethod("unit.names", signature(x="flops"),
  function(x, value)
  {
    x@unit.names <- value
    x <- check.flops(x)
    
    return( x )
  }
)
