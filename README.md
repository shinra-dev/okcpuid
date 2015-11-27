# okcpuid 

* **Version:** 0.4.0
* **Status:** [![Build Status](https://travis-ci.org/shinra-dev/okcpuid.png)](https://travis-ci.org/shinra-dev/okcpuid) 
* **License:** [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt

okcpuid is an R package that gives some basic cpu information (clock speed, number of cores, etc.).  
It's ok.


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


## The Linpack Benchmark

okcpuid also has a benchmark not unlike the Linpack Benchmarker:

```r
linpack(nmin=2000, nmax=5000, by=1000, warn=FALSE)
#    N      R.max
# 2000    13591178965 
# 3000    14043647701 
# 4000    14043647701 
# 5000    14312278293 
# 
# R.max:  14.312 GFLOPS
# N.max:  5000
# R.peak: 35.104 GFLOPS 
```


## Installation

```r
devtools::install_github("wrathematics/okcpuid")
```



## Authors

memuse is authored and maintained by:
* Drew Schmidt

With additional contributions from:
* Wei-Chen Chen
* Christian Heckendorf

The files in `okcpuid/src/cpuid` are Copyright 2008 Veselin
Georgiev, with some light modifications made by Drew Schmidt 2014.

