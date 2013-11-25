# class detection
is.flops <- function(x) class(x)=="flops"



### sanity checks
check.unit <- function(x)
{
  # Essentially correct unit (up to case)
  unit <- tolower(x@unit)
  
  check <- .flops[[x@unit.names]][["check"]]
  print <- .flops[[x@unit.names]][["print"]]
  
  if (unit %in% check)
  {
    x@unit <- print[which(check==unit)]
    
    return( x )
  }
  
  # Unit does not match unit.names --- assume they meant the given unit.names and fix unit
  other.names <- if (x@unit.names == "short") "long" else "short"
  
  check <- .flops[[other.names]]
  
  if (unit %in% check[["check"]])
  {
    x@unit <- print[which(check[["check"]] == unit)]
    
    return( x )
  }
  
  if (unit %in% check[[1L]][["check"]])
  {
    x@unit <- print[which(check[[1L]][["check"]] == unit)]
    
    return( x )
  }
  
  # failed
  return( FALSE )
}



check.names <- function(x)
{
  names <- tolower(x@unit.names)
  check <- c("short", "long")
  
  if (names %in% check)
  {
    x@unit.names <- names
    
    return( x )
  }
  else
  {
    FALSE
  }
}



check.flops <- function(x)
{
  x <- check.names(x)
  if (is.logical(x))
    stop("cannot construct 'flops' object; bad 'unit.names'", call.=FALSE)
  
  x <- check.unit(x)
  if (is.logical(x))
    stop("cannot construct 'flops' object; bad 'unit'", call.=FALSE)
  
  return( x )
}



### constructor
internal.flops <- function(size=0, unit=.UNIT, unit.names=.NAMES)
{
  unit.names <- match.arg(tolower(unit.names), c("short", "long"))
  
  unit <- match.arg(tolower(unit), c("best", .flops[[unit.names]]$check))
  
  if (unit == "best")
    u <- "flops"
  else
    u <- unit
  
  # construct
  x <- new("flops", size=size, unit=u, unit.names=unit.names)
  
  # sanity check
  x <- check.flops(x)
  
  x <- swap.unit(x=x, unit="best")
  
  return( x )
}

flops <- internal.flops

