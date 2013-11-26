### NOTE
# This must be executed in batch using mpirun/mpiexed.  For example
# mpirun -np 2 Rscript cpuid/demo/linpack.r

library(cpuid, quietly=TRUE)

N <- 4500
bldim <- c(64, 64)

#linpack()

  # Quick if interactive
    if (interactive())
    stop("This benchmark may not be run interactively.")
  
  # Quit if not executed via mpirun
  require(pbdMPI, quietly=TRUE)
  ### FIXME
  
  # Load dmat
  require(pbdDMAT, quietly=TRUE)
  init.grid()
  
  comm.set.seed(diff=TRUE)
  
  if (length(bldim) == 1)
    bldim <- rep(bldim, 2)
  
  nops <- 2/3*N^3 + 2*N^2
  
  A <- ddmatrix("rnorm", N, N)
  B <- ddmatrix("rnorm", N, 1)
  
  time <- system.time( X <- solve(A, B) )[3]
  time <- allreduce(time, op='max')
  
  rsd <- norm(type="F", A%*%X - B)
  
  size <- nops / time / 1000000 # in MFLOPS
  peak_lin <- flops(size=size, unit="MFLOPS")
  
  
  ### CPU info
  cpuinfo <- cpuid()
  
  peak_theo <- cpuinfo$peak
  
  comm.print(peak_lin)
  comm.print(peak_theo)
  
  
  finalize()


