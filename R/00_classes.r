### validObject check
valid.flops <- function(object)
{
  if (!class(object) == "flops")
    return( "Not a class 'flops' object" )
  
  object@unit.names <- tolower(object@unit.names)
  if ( !(object@unit.names %in% c("short", "long")) )
    return( "invalid slot 'unit.names'. See help('flops')" )
  
  unit <- tolower(object@unit)
  if ( !(unit %in% .flops[["short"]][["check"]]) &&
       !(unit %in% .flops[["long"]][["check"]]) )
    return( "invalid slot 'unit'. See help('memuse')" )
}



setClass("flops",
          representation(
                         size="numeric",
                         unit="character",
                         unit.names="character"
          ),
          prototype(
                         size=0,
                         unit="FLOPS",
                         unit.names="short"
          ),
          validity=valid.flops
)



### Virtual classes
setClass("MHz", representation="VIRTUAL")
