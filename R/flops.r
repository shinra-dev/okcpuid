.__Rcpuid_flops <- list(
  names = c("FLOPS", "KFLOPS", "MFLOPS", "GFLOPS", "TFLOPS", "PFLOPS", "EFLOPS", "ZFLOPS", "YFLOPS"),
  ordmag = c(0, 3, 6, 9, 12, 15, 18, 21, 24)
)



flops <- function(size=0, unit="best")
{
#  size <- best.unit
  class(size) <- "flops"
  
  return( size )
}

