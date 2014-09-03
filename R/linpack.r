linpack <- function(A, B)
{
  time <- system.time( X <- solve(A, B) )[3]
#  time <- allreduce(time, op='max')
  
  rsd <- norm(type="F", A%*%X - B)
  
  nops <- 2/3*N*N*N + 2*N*N
  size <- nops / time / 1000000 # in MFLOPS
  peak_lin <- flops(size=size, unit="MFLOPS")
  
  
  cpuinfo <- cpuid()
  peak_theo <- cpuinfo$peak
  
  return(list(linpack=peak_lin, theoretical=peak_theo))
}
