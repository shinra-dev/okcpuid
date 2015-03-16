#' CPU ID
#' 
#' A utility to look up some basic information about the CPU.
#' 
#' @return 
#' Returns a list containing: 
#' \tabular{ll}{ 
#'     vendor \tab CPU vendor \cr
#'     codename \tab Vendor's CPU codename \cr 
#'     brand \tab CPU The CPU brand label \cr 
#' }
#' 
#' @seealso \code{\link{cpu_ins}, \link{cpu_clock}}
#' 
#' @examples
#' \dontrun{
#' library(Rcpuid, quietly=TRUE)
#' cpu_id()
#' }
#' 
#' @export
cpu_id <- function()
{
  ret <- .Call(okcpuid_cpuid)
  
  return( ret )
}



#' CPU Instructions
#' 
#' A utility to look up the presence/absence of some CPU instructions.
#' 
#' @param ret.logical 
#' Logical; if \code{FALSE}, then the return values will be
#' the strings "present" or "absent" (accordingly).  If \code{TRUE} then the
#' elements of the return list will be \code{TRUE} to indicate presence, and
#' \code{FALSE} otherwise.
#' 
#' @return 
#' Returns a list containing: 
#' \tabular{ll}{ 
#'    mmx \tab MMX instruction set \cr 
#'    mmx.extended \tab Extended MMX instruction set \cr 
#'    sse \tab SSE instruction set \cr 
#'    sse2 \tab SSE2 instruction set \cr 
#' }
#' 
#' @seealso \code{\link{cpu_id}, \link{cpu_clock}}
#' 
#' @examples
#' \dontrun{
#' library(Rcpuid, quietly=TRUE)
#' cpu_ins()
#' }
#' 
#' @export
cpu_ins <- function(ret.logical=FALSE)
{
  ret <- .Call(okcpuid_available_instructions)
  
  if (ret.logical)
    ret <- sapply(ret, function(i) if (i=="present") TRUE else FALSE)
  
  return( ret )
}



#' CPU Clock
#' 
#' A utility to look up some basic performance information about
#' the CPU.
#' 
#' @return 
#' Returns a list containing: 
#' \tabular{ll}{ 
#'    ncores \tab Number of "cores" (physical + logical). \cr 
#'    clock.os \tab The CPU clock as reported by the OS. \cr 
#'    clock.tested \tab The CPU clock determined from a small test. \cr 
#'    peak \tab Theoretical peak floating point operations per second. \cr 
#' }
#' 
#' @seealso \code{\link{cpu_id}, \link{cpu_ins}}
#' 
#' @examples
#' \dontrun{
#' library(Rcpuid, quietly=TRUE)
#' cpu_clock()
#' }
#' 
#' @export
cpu_clock <- function()
{
  ret <- .Call(okcpuid_cpuid_info)
  
  class(ret$clock.os) <- "MHz"
  class(ret$clock.tested) <- "MHz"
  
  ret$peak <- best_unit(ret$peak * 1e6)
  
  return( ret )
}

