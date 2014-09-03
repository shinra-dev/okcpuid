library(cpuid, quietly=TRUE)

N <- 4500
bldim <- 64


A <- matrix(rnorm(N*N), N, N)
B <- matrix(rnorm(N*N), N, 1L)

peak <- cpuid:::linpack(A=A, B=B)
peak

