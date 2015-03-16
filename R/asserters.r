is.int <- function(x)
{
  epsilon <- 1e-8
  
  return(abs(x - round(x)) < epsilon)
}



assert_type <- function(x, type)
{
  Rstuff <- c("character", "numeric", "int", "integer", "double", "logical", "matrix", "data.frame", "vector")
  type <- match.arg(type, Rstuff)
  
  nm <- deparse(substitute(x))
  
  fun <- eval(parse(text=paste("is.", type, sep="")))
  
  if (!fun(x))
    stop(paste0("argument '", nm, "' must be of type ", type), call.=FALSE)
  
  return(invisible(TRUE))
}



assert_val <- function(expr, msg)
{
  test <- eval(expr)
  
  if (!test)
  {
    exprstring <- deparse(match.call()[[2]])
    if (missing(msg))
      msg <- paste("Need", exprstring)
    
    stop(msg, call.=FALSE)
  }
  
  return(invisible(TRUE))
}

