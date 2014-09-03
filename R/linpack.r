linpack <- function(A, B)
{
  if (nrow(A) != ncol(A))
    stop("Matrix 'A' must be square")
  if (nrow(A) != nrow(B))
    stop("Matrix 'B' must have as nrow(A) rows")
  
  N <- nrow(A)
  
  time <- system.time( X <- solve(A, B) )[3]
#  time <- allreduce(time, op='max')
  
  rsd <- norm(type="F", A%*%X - B)
  
  nops <- 2/3*N*N*N + 2*N*N
  size <- nops / time / 1000000 # in MFLOPS
  peak_lin <- flops(size=size, unit="MFLOPS")
  
  
  cpuinfo <- cpu_clock()
  peak_theo <- cpuinfo$peak
  
  return(list(linpack=peak_lin, theoretical=peak_theo))
}
