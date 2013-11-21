cpuid <- function()
{
    .Call("cpuid_test", PACKAGE="cpuid")
}
