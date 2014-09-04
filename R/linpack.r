solve_nocopy <- function(A, B)
{
  if (!is.double(A))
    storage.mode(A) <- "double"
  if (!is.double(B))
    storage.mode(B) <- "double"
  
  .Call("R_solve_nocopy", A, B)
}



linpack <- function(A, B)
{
  if (nrow(A) != ncol(A))
    stop("Matrix 'A' must be square")
  if (nrow(A) != nrow(B))
    stop("Matrix 'B' must have as nrow(A) rows")
  
  N <- nrow(A)
  
  time <- system.time( X <- solve_nocopy(A, B) )[3]
  
#  time <- allreduce(time, op='max')
  
  nops <- 2/3*N*N*N + 2*N*N
  size <- nops / time / 1000 # in GFLOPS
  peak_lin <- flops(size=size, unit="GFLOPS")@size
  
  
  return(peak_lin)
}
