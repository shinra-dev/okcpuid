cpu_id <- function()
{
  ret <- .Call("Rcpuid_cpuid", PACKAGE="Rcpuid")
  
  return( ret )
}



cpu_ins <- function(ret.logical=FALSE)
{
  ret <- .Call("Rcpuid_available_instructions", PACKAGE="Rcpuid")
  
  if (ret.logical)
    ret <- sapply(ret, function(i) if (i=="present") TRUE else FALSE)
  
  return( ret )
}



cpu_clock <- function()
{
  ret <- .Call("Rcpuid_cpuid_info", PACKAGE="Rcpuid")
  
  class(ret$clock.os) <- "MHz"
  class(ret$clock.tested) <- "MHz"
  
  ret$peak <- flops(size=ret$peak*1e6, unit="mflops")
  
  return( ret )
}

