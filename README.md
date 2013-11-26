cpuid
=====

cpuid is an R package that gives some basic cpu information (clock speed, number of cores, etc.).  
The primary purpose of the package is to compute a reasonable estimate of the (theoretical) peak
performance in the number of (double precision) floating point operations per second (FLOPS).

Install from the shell via 
R CMD INSTALL cpuid_0.1-0.tar.gz


To use, start R and execute:

library(cpuid)
cpuid()
