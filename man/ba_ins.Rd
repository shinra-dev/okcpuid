\name{CPU Instructions}
\alias{cpu_ins}

\title{ CPU Instructions }

\description{
  .
}
\usage{
  cpu_ins(ret.logical=FALSE)
}
\arguments{
  \item{ret.logical}{Logical; if \code{FALSE}, then the return values
  will be the strings "present" or "absent" (accordingly).  If 
  \code{TRUE} then the elements of the return list will be \code{TRUE} 
  to indicate presence, and \code{FALSE} otherwise.}
}
\details{
  .
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
\seealso{
  \code{\link{cpu_id}, \link{cpu_clock}}
}
\examples{
\dontrun{
library(Rcpuid, quietly=TRUE)
cpu_ins()
}
}


