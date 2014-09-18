\name{CPU Clock}
\alias{cpu_clock}

\title{ CPU Clock }

\description{
  .
}
\usage{
  cpu_clock()
}
\details{
  .
}
\value{
  Returns a list containing:
\tabular{ll}{
  ncores \tab Number of "cores" (physical + logical). \cr
  clock.os \tab The CPU clock as reported by the OS. \cr
  clock.tested \tab The CPU clock determined from a small test. \cr
  peak \tab Theoretical peak floating point operations per second. \cr
}
}
\seealso{
  \code{\link{cpu_id}, \link{cpu_ins}}
}
\examples{
\dontrun{
library(Rcpuid, quietly=TRUE)
cpu_clock()
}
}


