.__Rcpuid_flops <- list(
  names = c("FLOPS", "KFLOPS", "MFLOPS", "GFLOPS", "TFLOPS", "PFLOPS", "EFLOPS", "ZFLOPS", "YFLOPS"),
  ordmag = c(0, 3, 6, 9, 12, 15, 18, 21, 24)
)



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
    return( .__Rcpuid_flops$names[1L] )
  
  
  num.digits <-fun(size)
    
  for (i in seq.int(9))
  {
    if (num.digits < dgts*i)
    {
      unit <- .__Rcpuid_flops$names[i]
      break
    }
  }
  
  size <- size/(f^(i-1))
  
  class(size) <- "flops"
  attr(size, "unit") <- .__Rcpuid_flops$names[i]
  
  return( size )
}


#' Flops Constructor
#' 
#' .
#' 
#' .
#' 
#' @param size
#' 
#' @param unit
#' 
#' 
#' @return 
#' Returns a flops object.
#' 
#' @examples
#' \dontrun{
#' library(Rcpuid, quietly=TRUE)
#' flops(2000000) # 2 MFLOPS
#' }
#' 
#' @export flops
flops <- function(size=0, unit="best")
{
  if (unit == "best")
  {
    size <- best_unit(size)
  }
  else
  {
    attr(size, "unit") <- find_unit(unit)
    class(size) <- "flops"
  }
  
  return( size )
}



#' name print-flops
#' @rdname print-flops
#' @export
print.flops <- function(x, ..., unit="best", digits=3)
{
  size <- as.numeric(x)
  unit <- attr(x, "unit")
  
  if (x > 1e22)
    format <- "e"
  else
    format <- "f"
  
  cat(sprintf(paste("%.", digits, format, " ", unit, "\n", sep=""), size))
}

