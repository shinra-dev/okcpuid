### Accessors
setGeneric(name="size",
  function(x, as.is=TRUE)
    standardGeneric("size"),
  package="cpuid"
)

setGeneric(name="unit",
  function(x)
    standardGeneric("unit"),
  package="cpuid"
)

setGeneric(name="unit.names",
  function(x)
    standardGeneric("unit.names"),
  package="cpuid"
)


### Replacers
setGeneric(name="size<-",
  function(x, value)
    standardGeneric("size<-"),
  package="cpuid"
)

setGeneric(name="unit<-",
  function(x, value)
    standardGeneric("unit<-"),
  package="cpuid"
)

setGeneric(name="unit.names<-",
  function(x, value)
    standardGeneric("unit.names<-"),
  package="cpuid"
)



### Swaps
setGeneric(name="swap.unit",
  function(x, unit, precedence=.PRECEDENCE)
    standardGeneric("swap.unit"),
  package="cpuid"
)

setGeneric(name="swap.names",
  function(x)
    standardGeneric("swap.names"),
  package="cpuid"
)


