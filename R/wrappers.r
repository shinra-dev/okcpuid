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
  
  class(ret$clock) <- "MHz"
  ret$peak <- flops(size=ret$peak, unit="mflops")
  
  return( ret )
}

