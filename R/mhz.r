#' @rdname print
#' @export
print.MHz <- function(x, ...)
{
  cat(paste(paste(x, "MHz", collapse=" "), "\n"))
}

