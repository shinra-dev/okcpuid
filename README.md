# okcpuid [![Build Status](https://travis-ci.org/shinra-dev/okcpuid.png)](https://travis-ci.org/shinra-dev/okcpuid) [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)

okcpuid is an R package that gives some basic cpu information (clock speed, number of cores, etc.).  
The primary purpose of the package is to compute a reasonable estimate of the (theoretical) peak
performance in the number of (double precision) floating point operations per second (FLOPS).


## Installation

To install from R using Hadley Wickham's 
[devtools](https://github.com/hadley/devtools) package:

```r
library(devtools)
install_github("wrathematics/RNACI")
install_github("wrathematics/okcpuid")
```

You can also install from the shell via:

```
R CMD INSTALL okcpuid_0.1-0.tar.gz
```

## CPU Information

With the okcpuid package, you can get information such as vendor 
name, processor codename, and processor brand (outputs are only
and example):

```r
cpu_id()
# $vendor
# [1] "GenuineIntel"
# 
# $codename
# [1] "P-III Celeron"
# 
# $brand
# [1] "Intel(R) Celeron(R) CPU  N2830  @ 2.16GHz"
```

available processor instructions:

```r
cpu_ins()
# $mmx
# [1] "present"
# 
# $mmx.extended
# [1] "absent"
# 
# $sse
# [1] "present"
# 
# $sse2
# [1] "present"
```

and cores, clock, and peak FLOPS:

```r
cpu_clock()
# $ncores
# [1] 2
# 
# $clock.os
# 1826 MHz 
# 
# $clock.tested
# 2166 MHz 
# 
# $peak
# 17.328 GFLOPS
```

For CPU cache information, see the
[memuse](https://github.com/wrathematics/memuse) package.
