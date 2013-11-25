### print methods
setMethod("print", signature(x="flops"),
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



setMethod("print", signature(x="MHz"),
  function(x)
    cat(paste(paste(x, "MHz", collapse=" "), "\n"))
)



### show methods
setMethod("show", signature(object="flops"),
  function(object)
  {
    unit <- tolower(object@unit)
    
    if (unit == "flops")
      digits <- 0
    else
      digits <- 3
    
    if (object@size > 1e22)
      format <- "e"
    else
      format <- "f"
    
    cat(sprintf(paste("%.", digits, format, " ", object@unit, "\n", sep=""), object@size))
  }
)



setMethod("show", signature(object="MHz"),
  function(object)
    cat(paste(paste(object, "MHz", collapse=" "), "\n"))
)
