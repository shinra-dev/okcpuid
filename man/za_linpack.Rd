\name{linpack}
\alias{linpack}

\title{ Linpack }

\description{
  .
}
\usage{
  linpack(A, B, solvefun)
}
\arguments{
  \item{A}{The square matrix representing the system of equations.}
  \item{B}{The "right hand side", of the same order as A.}
}
\details{
  .
}
\seealso{
  \code{\link{solve_nocopy}}
}
\examples{
\dontrun{
library(Rcpuid, quietly=TRUE)
flops(2000000) # 2 MFLOPS
}
}


