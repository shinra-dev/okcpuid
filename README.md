# Rcpuid

Rcpuid is an R package that gives some basic cpu information (clock speed, number of cores, etc.).  
The primary purpose of the package is to compute a reasonable estimate of the (theoretical) peak
performance in the number of (double precision) floating point operations per second (FLOPS).


## Installation

To install from R using Hadley Wickham's 
[devtools](https://github.com/hadley/devtools) package:

```r
library(devtools)
install_github("wrathematics/RNACI")
install_github("wrathematics/Rcpuid")
```

You can also install from the shell via:

```
R CMD INSTALL Rcpuid_0.1-0.tar.gz
```

## CPU Information

To use, start R and execute:

Vendor name, processor codename, and processor brand:

```r
cpu_id()
```

Available processor instructions:

```r
cpu_ins()
```

Cores, clock, and peak FLOPS:

```r
cpu_clock()
```

For CPU cache information, see the
[memuse](https://github.com/wrathematics/memuse) package.
