solve_nocopy <- function(A, B)
{
  if (!is.double(A))
    storage.mode(A) <- "double"
  if (!is.double(B))
    storage.mode(B) <- "double"
  
  .Call(R_solve_nocopy, A, B)
}



linpack <- function(A, B, solvefun)
{
  if (nrow(A) != ncol(A))
    stop("Matrix 'A' must be square")
  if (nrow(A) != nrow(B))
    stop("Matrix 'B' must have as nrow(A) rows")
  
  N <- nrow(A)
  
  time <- system.time( X <- solvefun(A=A, B=B) )[3]
  
#  time <- allreduce(time, op='max')
  
  nops <- 2/3*N*N*N + 2*N*N
  flops <- nops / time / 1000
  
  return(flops)
}



#' Linpack Benchmark
#' 
#' TODO
#' 
#' @name linpack_benchmark
#' @rdname linpack
#' @export
linpack_benchmark <- function()
{
  msg <- "
                \\!/ Please read me \\!/\n
  Running this without very efficient BLAS (e.g., MKL, OpenBLAS, ...)
  is a waste of time and will not give you a good sense of the 
  performance of your machine.\n
  If you don't know which BLAS you're using, they're not efficient!\n"
  
  cat(msg)
  
  
  R.peak <- cpu_clock()$peak
  
  N.bottom <- 1000L
  N.top <- as.integer(howmany(Sys.meminfo()$totalram/1.5))[1L]
  N.top <- 2000
  
  if (N.bottom > N.top)
    stop("You don't have enough ram to do this on your potato of a computer")
  
  Ns <- N <- N.bottom
  while (N < N.top)
  {
    N <- 2L*N
    if (N <= N.top)
      Ns <- c(Ns, N)
  }
  
  if (N > N.top)
    Ns <- c(Ns, N.top)
  
  R.max <- 0
  N.max <- 0
  
  cat("\n   N      R.max\n")
  for (N in Ns)
  {
    cat(N)
    A <- matrix(rnorm(N*N), N, N)
    B <- matrix(rnorm(N*N), N, 1L)
    test <- linpack(A=A, B=B, solve_nocopy)
    rm(A)
    rm(B)
    invisible(gc())
    
    cat("   ", R.max, "\n")
    
    if (test > R.max)
    {
      R.max <- test
      N.max <- N
    }
    
    N <- N*2L
  }
  cat("\n")
  
  print(R.max)
  R.max <- best_unit(R.max)
  print(R.max)
  
  ret <- list(R.max=R.max, N.max=N.max, R.peak=R.peak)
  class(ret) <- "linpack"
  
  return(ret)
}



title_case <- function(x) gsub(x, pattern="(^|[[:space:]])([[:alpha:]])", replacement="\\1\\U\\2", perl=TRUE)


#' Prints linpack objects
#' 
#' @param x
#' A linpack object to print.
#' @param ...
#' Extra arguments (ignored).
#' @param digits
#' Number of digits to print.
#' 
#' @rdname print-linpack
#' @export
print.linpack <- function(x, ..., digits=3)
{
  maxlen <- max(sapply(names(x), nchar))
  names <- gsub(names(x), pattern="_", replacement=" ")
  names <- title_case(x=names)
  spacenames <- simplify2array(lapply(names, function(str) paste0(str, ":", paste0(rep(" ", maxlen-nchar(str)), collapse=""))))
  
  cat(paste(spacenames, sapply(x, round, digits=digits), sep=" ", collapse="\n"), "\n")
  invisible()
}



#' Subsets linpack outputs.
#' 
#' @param x
#' linpack object.
#' @param i
#' Index.
#' 
#' rdname subset
#' @export
"[.linpack" <- function(x, i)
{
  class(x) <- NULL
  ret <- x[i]
  if (length(ret) > 0)
    class(ret) <- "linpack"
  else
    return(numeric(0))
  
  return(ret)
}

