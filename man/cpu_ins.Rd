% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cpuid.r
\name{cpu_ins}
\alias{cpu_ins}
\title{CPU Instructions}
\usage{
cpu_ins(ret.logical = FALSE)
}
\arguments{
\item{ret.logical}{Logical; if \code{FALSE}, then the return values will be
the strings "present" or "absent" (accordingly).  If \code{TRUE} then the
elements of the return list will be \code{TRUE} to indicate presence, and
\code{FALSE} otherwise.}
}
\value{
Returns a list containing: 
\tabular{ll}{ 
   mmx \tab MMX instruction set \cr 
   mmx.extended \tab Extended MMX instruction set \cr 
   sse \tab SSE instruction set \cr 
   sse2 \tab SSE2 instruction set \cr 
}
}
\description{
A utility to look up the presence/absence of some CPU instructions.
}
\examples{
\dontrun{
library(okcpuid, quietly=TRUE)
cpu_ins()
}

}
\seealso{
\code{\link{cpu_id}, \link{cpu_clock}}
}

