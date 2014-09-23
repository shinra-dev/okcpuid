\name{solve_nocopy}
\alias{solve_nocopy}

\title{ No-Copy Solve }

\description{
  Like R's \code{solve()}, but without copying the data matrix \code{A}.
  
  WARNING: only use for benchmarking, or if you really know what 
  you're doing.  Calling then and then referencing \code{A} can be 
  dangerous.
}
\usage{
  solve_nocopy(A, B)
}
\arguments{
  \item{A}{The square matrix representing the system of equations.}
  \item{B}{The "right hand side", of the same order as A.}
}
\details{
  This is a non-distributed "solvefun" for \code{linpack()}.
}
\seealso{
  \code{\link{linpack}}}
}

