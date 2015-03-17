.__Rcpuid_flops <- list(
  names = c("FLOPS", "KFLOPS", "MFLOPS", "GFLOPS", "TFLOPS", "PFLOPS", "EFLOPS", "ZFLOPS", "YFLOPS"),
  ordmag = c(0, 3, 6, 9, 12, 15, 18, 21, 24)
)



flops_units <- function()
{
  .__Rcpuid_flops$names
}



flops_ordmag <- function()
{
  .__Rcpuid_flops$ordmag
}



find_unit <- function(unit)
{
  unit <- match.arg(toupper(unit), .__Rcpuid_flops$names)
  
  unit
}



best_unit <- function(x)
{
  f <- 1e3
  fun <- function(x) log10(abs(x))
  dgts <- 3
  
  size <- x
  class(size) <- NULL
  
  if (size == 0)
    return( flops_units()[1L] )
  
  
  num.digits <-fun(size)
    
  for (i in seq.int(9))
  {
    if (num.digits < dgts*i)
    {
      unit <- flops_units()[i]
      break
    }
  }
  
  size <- size/(f^(i-1))
  
  class(size) <- "flops"
  attr(size, "unit") <- flops_units()[i]
  
  return( size )
}



swap_unit <- function(x, unit)
{
  inunit <- attr(x, "unit")
  index <- which(flops_units() == inunit)
  ordmag <- flops_ordmag()[index]
  
  flops <- as.numeric(x) * 10^ordmag
  
  index <- which(flops_units() == unit)
  ordmag <- flops_ordmag()[index]
  ret <- flops / 10^ordmag
  
  class(ret) <- "flops"
  attr(ret, "unit") <- unit
  
  return( ret )
}



#' Flops Constructor
#' 
#' Function to build a flops object.
#' 
#' This provides a simple way of representing flops, scaled by
#' some SI unit (e.g., mega, giga, ...).
#' 
#' @param size
#' A number of flops, scaled by the input unit unit.
#' @param unit
#' An SI unit of flops (e.g., MFLOPS for MegaFLOPS, GFLOPS for 
#' GigaFLOPS, etc.).
#' 
#' @return 
#' Returns a flops object.
#' 
#' @examples
#' \dontrun{
#' library(okcpuid, quietly=TRUE)
#' flops(2000000) # 2 MFLOPS
#' }
#' 
#' @export flops
flops <- function(size=0, unit)
{
  if (missing(unit))
  {
    size <- best_unit(size)
  }
  else
  {
    unit <- match.arg(tolower(unit), flops_units())
    attr(size, "unit") <- "FLOPS"
    class(size) <- "flops"
    size <- swap_unit(size, unit)
  }
  
  return( size )
}



#' unflop
#' 
#' Convert a flops object into a numeric.
#' 
#' This function differs from a simple \code{as.numeric()} call in
#' that flops objects store the unit flops.  So if you have a flops
#' object \code{x} that prints "10 MFLOPS", \code{as.numeric(x)}
#' would produce 10, while \code{unflop()} would produce 10000000.
#' 
#' @param x
#' A flops object.
#' 
#' @return
#' The number of flops represented by x.
#' 
#' @rdname unflop
#' @export
unflop <- function(x)
{
  if (class(x) != "flops")
    stop("Argument 'x' must be a flops object")
  
  as.numeric(swap_unit(x, "FLOPS"))
}



#' print-flops
#' 
#' @param x
#' A flops object.
#' @param ...
#' Ignored.
#' @param unit
#' The flops display unit to use.
#' @param digits
#' The number of decimal digits to display.
#' 
#' @name print-flops
#' @rdname print-flops
#' @method print flops
#' @export
print.flops <- function(x, ..., unit="best", digits=3)
{
  if (unit == "best")
    x <- best_unit(unflop(x))
  else
  {
    unit <- match.arg(tolower(unit), flops_units())
    x <- swap_unit(x, unit)
  }
  
  size <- as.numeric(x)
  unit <- attr(x, "unit")
  
  if (x > 1e22)
    format <- "e"
  else
    format <- "f"
  
  cat(sprintf(paste("%.", digits, format, " ", unit, "\n", sep=""), size))
}

