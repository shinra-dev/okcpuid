#' Interface to the cpuid library
#' 
#' This package offers several utilities for looking up basic CPU information,
#' such as the number of cores, cpu clock, and an estimated peak number of
#' FLOPS.
#' 
#' \tabular{ll}{ 
#'   Package: \tab Rcpuid \cr 
#'   Type: \tab Package \cr 
#'   License: \tab BSD 2-Clause \cr 
#' }
#' 
#' @useDynLib okcpuid,
#'    okcpuid_cpuid, okcpuid_available_instructions, okcpuid_cpuid_info,
#'    R_solve_nocopy
#' 
#' @name Rcpuid-package
#' @docType package
#' @author Drew Schmidt \email{wrathematics AT gmail.com}
#' @keywords Package
NULL


