// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright 2013, Schmidt

#include "cpuid.h"

#include "cpuid/libcpuid/libcpuid.h"

#include <string.h>
#include <stdio.h>

#define SINGLE 0
#define DOUBLE 1

#define PLATFORM_SUPPORTED 0
#define PLATFORM_ERROR 1



// Linux
#ifdef __linux__
    #include <sys/sysinfo.h>
    #include <unistd.h>
    
    static int get_ncores(void)
    {
        return sysconf(_SC_NPROCESSORS_ONLN);
    }
    
    #define PLATFORM PLATFORM_SUPPORTED
    
#else
    #ifdef GET_TOTAL_CPUS_DEFINED
      static int get_ncores(void)
      {
          return get_total_cpus(void);
      }
      #define PLATFORM PLATFORM_SUPPORTED
    #else
      #define PLATFORM PLATFORM_ERROR
    
    #endif
    
#endif



int cpu_hardware_info(double *clock, int *ncpus, int *ncores)
{
    *ncores = get_ncores();
    
    *clock = cpu_clock_measure(200, 0);
    
    // these do nothing atm
    *ncpus = 1;
    
    return PLATFORM;
}



SEXP main_cpuid_info()
{
    SEXP ncpus, ncores;
    SEXP clock, peak;
    SEXP RET, RET_NAMES;
    
    PROTECT(ncpus = allocVector(INTSXP, 1));
    PROTECT(ncores = allocVector(INTSXP, 1));
    
    PROTECT(clock = allocVector(REALSXP, 1));
    PROTECT(peak = allocVector(REALSXP, 1));
    
    PROTECT(RET = allocVector(VECSXP, 4));
    PROTECT(RET_NAMES = allocVector(STRSXP, 4));
    
    int support;
    int ops_per_cycle;
    
    support = cpu_hardware_info(REAL(clock), INTEGER(ncpus), INTEGER(ncores));
    
    #define type DOUBLE
    if (type == SINGLE)
        ops_per_cycle = 4;
    else if (type == DOUBLE)
        ops_per_cycle = 2;
    
    // peak = ncpus * (operand/cycle) * (# cores) * (SSE/core) * (cycles/second)
/*    peak = ((double) ncpus * ops_per_cycle * ncores) * clock;*/
    REAL(peak)[0] = ((double) INTEGER(ncpus)[0] * ops_per_cycle * INTEGER(ncores)[0]) * REAL(clock)[0];
    
    
/*    if (support == PLATFORM_SUPPORTED)*/
/*    {*/
/*        printf("clock=%f, cpus=%d, cores=%d\n", clock, ncpus, ncores);*/
/*        printf("peak=%f\n", peak);*/
/*    }*/
/*    else*/
/*        printf("platform not supported\n");*/
    
    // Return
    SET_VECTOR_ELT(RET, 0, ncpus);
    SET_VECTOR_ELT(RET, 1, ncores);
    SET_VECTOR_ELT(RET, 2, clock);
    SET_VECTOR_ELT(RET, 3, peak);
    
    SET_STRING_ELT(RET_NAMES, 0, mkChar("ncpus"));
    SET_STRING_ELT(RET_NAMES, 1, mkChar("ncores"));
    SET_STRING_ELT(RET_NAMES, 2, mkChar("clock"));
    SET_STRING_ELT(RET_NAMES, 3, mkChar("peak"));
    
    setAttrib(RET, R_NamesSymbol, RET_NAMES);
    
    UNPROTECT(6);
    
    return RET;
}
