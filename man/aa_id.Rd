\name{CPU ID}
\alias{cpu_id}

\title{ CPU ID }

\description{
  .
}
\usage{
  cpu_id()
}
\details{
  .
}
\value{
  Returns a list containing:
\tabular{ll}{
  vendor \tab CPU vendor \cr
  codename \tab Vendor's CPU codename \cr
  brand \tab CPU The CPU brand label \cr
}
}
\seealso{
  \code{\link{cpu_ins}, \link{cpu_clock}}
}
\examples{
\dontrun{
library(Rcpuid, quietly=TRUE)
cpu_id()
}
}


