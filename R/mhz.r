#' Print MHz Object
#' 
#' @param x
#' MHz object
#' @param ...
#' Ignored.
#' 
#' @name print-MHz
#' @rdname print-MHz
#' @method print MHz
#' @export
print.MHz <- function(x, ...)
{
  cat(paste(paste(x, "MHz", collapse=" "), "\n"))
}

