### NOTE
# This must be executed in batch using mpirun/mpiexed.  For example
# mpirun -np 2 Rscript cpuid/demo/linpack.r

library(cpuid, quietly=TRUE)

linpack()

