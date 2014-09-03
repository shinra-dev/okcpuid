library(Rcpuid, quietly=TRUE)

N <- 4500

A <- matrix(rnorm(N*N), N, N)
B <- matrix(rnorm(N*N), N, 1L)

peak <- Rcpuid:::linpack(A=A, B=B)
peak

