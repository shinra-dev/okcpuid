solve_nocopy <- function(problemsize)
{
  N <- problemsize
  
  ### Don't want to divide by 0 if someone submits a tiny problem
  for (power in 0:6)
  {
    if (power == 6)
      stop("Your computer is from the future!")
    
    ordmag <- 10^power
    
    A <- matrix(rnorm(N*N), N, N)
    B <- matrix(rnorm(N*N), N, 1L)
    
    time <- mean(replicate(ordmag, 
      system.time( X <- .Call(R_solve_nocopy, A, B) )[3])
    )
    
    rm(A);rm(B);invisible(gc())
    
    if (time > 1e-8) break
  }
  
  nops <- 2/3*N*N*N + 2*N*N
  flops <- nops / as.numeric(time)
  
  return(flops)
}



#' Linpack Benchmark
#' 
#' The Linpack benchmark is the standard performance benchmark
#' for numerical computing.  Research institutions, governments,
#' and companies with very large computing resources "compete" to
#' build machines that will perform the best on the benchmark. 
#' Results of this competition are released twice a year, in
#' June and in November, at the ISC and SC conferences, respectively.
#' Although it is generally understood that Linpack no longer
#' adequately measures the performance capabilities of a system
#' on real problems, it has remained an important measurement
#' all the same.  One of the most attractive things
#' about the Linpack benchmark is its host of historical data,
#' which dates back all the way to 1993.
#' 
#' If you are even somewhat serious about using this as a test of 
#' the host system's capabilities, I would strongly encourage you
#' to run this exclusively; that is, shut down all other 
#' resource-intensive applications (web browsers, system updates,
#' antivirus, whatever).  If a lot of your ram is used up by
#' other utilities and the benchmarker has to swap them to disk,
#' the performance will degrade by several orders of magnitude.
#' 
#' @param nmin
#' Minimum problem size.
#' @param nmax
#' Maximum problem size.  Value should either be an integer greater
#' than \code{nmin} or it should be the string "choose".  In the 
#' former case, the supplied value will be the largest value
#' considered.  In the latter case, the largest problem size will
#' be 2/3 of max system ram.
#' @param by
#' How to get from nmin to nmax.  Value should either be a numeric
#' value greater than 0, or it should be the string "doubling".  In
#' the former case, \code{seq.int()} is used, while in the latter,
#' values starting with nmin will be doubled until nmax is 
#' reached/surpassed.
#' @param warn
#' Logical; this controls the printing of a warning that I very 
#' seriously want you to read.  Set \code{warnme=FALSE} to disable 
#' after you have read it.
#' @param verbose
#' Logical; determines whether or not intermediate results should
#' be printed.
#' 
#' @return
#' The return is a list (formally an S3 'linpack' object), containing:
#' \tabular{ll}{
#'    R.max \tab The max
#' }
#' 
#' @references \url{http://www.top500.org/project/linpack/}
#' 
#' @name linpack_benchmark
#' @rdname linpack
#' @export
linpack <- function(nmin=1000, nmax="choose", by="doubling", warn=TRUE, verbose=TRUE)
{
  msg <- "
                    /!\\ Please read me /!\\\n
  Running this without very efficient BLAS (e.g., MKL, OpenBLAS, ...)
  is a waste of time and will not give you a good sense of the 
  performance of your machine.  You are encouraged to investigate
  using OpenBLAS, or Revolution R Open.\n
  If you don't know which BLAS you're using, they're not efficient!\n"
  
  assert_type(warn, "logical")
  if (warn) cat(msg)
  assert_type(verbose, "logical")
  
  
  ### Checks
  assert_type(nmin, "int")
  assert_val(nmin > 0)
  N.bottom <- nmin
  
  if (is.character(nmax))
  {
    nmax <- match.arg(tolower(nmax), "choose")
    N.top <- as.integer(howmany(Sys.meminfo()$totalram/1.5))[1L]
    assert_val(N.top > 0, "Unable to determine max system ram")
  }
  else
  {
    assert_type(nmax, "int")
    assert_val(nmax > 0)
    assert_val(nmin <= nmax, "No valid test cases selsected:  nmin > nmax")
    
    N.top <- nmax
  }
  
  if (is.character(by))
  {
    by <- match.arg(tolower(by), "doubling")
    Ns <- a2b_int_doubling(N.bottom, N.top)
  }
  else
  {
    assert_type(by, "numeric")
    assert_val(by > 0)
    Ns <- round(seq.int(from=N.bottom, to=N.top, by=by))
  }
  
  
  ### benchmark
  R.max <- 0
  N.max <- 0
  
  if (verbose) cat("\n   N      R.max\n")
  
  for (N in Ns)
  {
    if (verbose) cat(N)
    
    test <- solve_nocopy(problemsize=N)
    
    if (test > R.max)
    {
      R.max <- test
      N.max <- N
    }
    
    if (verbose)
      cat("   ", R.max, "\n")
    
    N <- N*2L
  }
  
  if (verbose) cat("\n")
  
  R.max <- flops(R.max)
  R.peak <- cpu_clock()$peak
  
  ret <- list(R.max=R.max, N.max=N.max, R.peak=R.peak)
  class(ret) <- "linpack"
  
  return(ret)
}



#' @export
summary.linpack <- function(object, ..., digits=3)
{
  Pct <- unflop(object$R.max) / unflop(object$R.peak) * 100
  
  ret <- list(Pct=Pct)
  
  maxlen <- max(sapply(names(ret), nchar))
  names <- gsub(names(ret), pattern="_", replacement=" ")
  names <- title_case(ret=names)
  spacenames <- simplify2array(lapply(names, function(str) paste0(str, ":", paste0(rep(" ", maxlen-nchar(str)), collapse=""))))
  
  cat(paste(spacenames, sapply(ret, round, digits=digits), sep=" ", collapse="\n"), "\n")
  
  return(invisible(ret))
}



#' Prints linpack objects
#' 
#' @param x
#' A linpack object to print.
#' @param ...
#' Extra arguments (ignored).
#' @param digits
#' Number of digits to print.
#' 
#' @name print-linpack
#' @rdname print-linpack
#' @method print linpack
#' @export
print.linpack <- function(x, ..., digits=3)
{
  maxlen <- max(sapply(names(x), nchar))
  names <- gsub(names(x), pattern="_", replacement=" ")
  names <- title_case(x=names)
  spacenames <- simplify2array(lapply(names, function(str) paste0(str, ":", paste0(rep(" ", maxlen-nchar(str)), collapse=""))))
  
  printfun <- function(x, digits)
  {
    if (class(x) == "flops")
      capture.output(print(x, digits=digits))
    else
      round(x, digits=digits)
  }
  
  cat(paste(spacenames, sapply(x, printfun, digits=digits), sep=" ", collapse="\n"), "\n")
  invisible()
}



#' Subsets linpack outputs.
#' 
#' @param x
#' linpack object.
#' @param i
#' Index.
#' 
#' @rdname subset
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

