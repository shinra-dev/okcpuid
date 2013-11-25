cpuid <- function()
{
  ret <- .Call("main_cpuid_info", PACKAGE="cpuid")
  
  class(ret$clock) <- "MHz"
  ret$peak <- flops(size=ret$peak, unit="mflops")
  
  return( ret )
}
