cpu_id <- function()
{
  ret <- .Call("Rcpuid_cpuid", PACKAGE="cpuid")
  
  return( ret )
}



cpu_ins <- function()
{
  ret <- .Call("Rcpuid_available_instructions", PACKAGE="cpuid")
  
  return( ret )
}



cpu_clock <- function()
{
  ret <- .Call("Rcpuid_cpuid_info", PACKAGE="cpuid")
  
  class(ret$clock.os) <- "MHz"
  class(ret$clock.tested) <- "MHz"
  
  ret$peak <- flops(size=ret$peak, unit="mflops")
  
  return( ret )
}

