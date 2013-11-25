cpuid <- function()
{
    .Call("main_cpuid_info", PACKAGE="cpuid")
}
