# okcpuid [![Build Status](https://travis-ci.org/shinra-dev/okcpuid.png)](https://travis-ci.org/shinra-dev/okcpuid) [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)

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
library(devtools)
install_github("wrathematics/RNACI")
install_github("wrathematics/okcpuid")
```



## License

    Copyright (c) 2013-2015, Drew Schmidt
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
    
    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.


