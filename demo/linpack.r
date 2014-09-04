library(memuse, quietly=TRUE)
library(Rcpuid, quietly=TRUE)
library(compiler, quietly=TRUE)


msg <- "\\!/ Please read me \\!/\n
Running this without very efficient BLAS (e.g., MKL, OpenBLAS, ...)
is a waste of time and will not give you a good sense of the 
performance of your machine.\n
If you don't know which BLAS you're using, they're not efficient!\n
"

warning(msg)



benchmark.linpack <- function()
{
  R.peak <- cpu_clock()$peak
  
  N.bottom <- 1000L
  N.top <- as.integer(howmany(Sys.meminfo()$totalram/1.5))[1L]
  
  if (N.bottom > N.top)
    stop("You don't have enough ram to do this on your potato of a compute")
  
  R.max <- 0
  N.max <- 0
  N <- N.bottom
  
  while(N < N.top)
  {
    A <- matrix(rnorm(N*N), N, N)
    B <- matrix(rnorm(N*N), N, 1L)
    test <- Rcpuid:::linpack(A=A, B=B)
    rm(A)
    rm(B)
    invisible(gc())
    
    if (test > R.max)
    {
      R.max <- test
      N.max <- N
    }
    
    N <- N*2L
  }
  
  N <- N/2L
  
  if (N < N.top)
  {
    N <- N.top
    A <- matrix(rnorm(N*N), N, N)
    B <- matrix(rnorm(N*N), N, 1L)
    test <- Rcpuid:::linpack(A=A, B=B)
    
    if (test > R.max)
    {
      R.max <- test
      N.max <- N
    }
  }
  
  
  R.max <- Rcpuid:::flops(R.max, "GFLOPS")
  
  ret <- list(R.max=R.max, N.max=N.max, R.peak=R.peak)
  return(ret)
}

benchmark.linpack <- cmpfun(benchmark.linpack)


benchmark.linpack()


