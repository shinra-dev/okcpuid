### print methods
setMethod("print", signature(x="flops"),
  function(x, ..., unit="best", digits=3)
  {
#    if (unit != x@unit)
#      x <- swap.unit(x=x, unit=unit)
    
    if (unit == "flops")
      digits <- 0
    
    if (x > 1e22)
      format <- "e"
    else
      format <- "f"
    
    base <- best_unit(x)
    size <- base$size
    name <- base$name
    
    cat(sprintf(paste("%.", digits, format, " ", name, "\n", sep=""), size))
  }
)



setMethod("show", signature(object="flops"),
  function(object) print(object)
)



### MHz
setMethod("print", signature(x="MHz"),
  function(x)
    cat(paste(paste(x, "MHz", collapse=" "), "\n"))
)


setMethod("show", signature(object="MHz"),
  function(object) print(object)
)

