if (interactive())
  stop("This benchmark may not be run interactively.")

library(cpuid, quietly=TRUE)

library(pbdMPI, quietly=TRUE)
library(pbdDMAT, quietly=TRUE)
init.grid()

N <- 4500
bldim <- 64


#  comm.set.seed(diff=TRUE)

if (length(bldim) == 1)
  bldim <- rep(bldim, 2)

A <- ddmatrix("rnorm", N, N)
B <- ddmatrix("rnorm", N, 1)

peak <- linpack(A=A, B=B)
comm.print(peak)


finalize()
