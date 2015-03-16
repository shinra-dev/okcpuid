#' Print MHz Object
#' 
#' @param x
#' MHz object
#' @param ...
#' Ignored.
#' 
#' @rdname print-mhz
#' @export
print.MHz <- function(x, ...)
{
  cat(paste(paste(x, "MHz", collapse=" "), "\n"))
}

