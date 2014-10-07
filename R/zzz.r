.onUnload <- function(libpath)
{
  library.dynam.unload("okcpuid", libpath)

  invisible()
}
