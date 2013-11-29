// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright 2013, Schmidt, Heckendorf

#include "cpuid.h"

#include "cpuid/libcpuid/libcpuid.h"

#include <string.h>
#include <stdio.h>

#define SINGLE 0
#define DOUBLE 1

#define PLATFORM_SUPPORTED 0
#define PLATFORM_ERROR 1



// Linux
#if defined(__linux__)
    #include <sys/sysinfo.h>
    #include <unistd.h>

    static int get_ncores(void)
    {
        return sysconf(_SC_NPROCESSORS_ONLN);
    }

    #define PLATFORM PLATFORM_SUPPORTED
#elif defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__bsdi__) || defined(__DragonFly__)
    #include <stdlib.h>
    #include <sys/types.h>
    #include <sys/sysctl.h>

    int get_ncores(void){
        int num;
        size_t oldsize;

        sysctlbyname("hw.ncpu",NULL,&oldsize,NULL,0);
        if(sizeof(num)!=oldsize)
            return 0;

        sysctlbyname("hw.ncpu",&num,&oldsize,NULL,0);

        return num;
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



int cpu_hardware_info(double *clock, int *nnodes, int *ncores)
{
    *ncores = get_ncores();

    *clock = cpu_clock_measure(200, 0);

    // these do nothing atm
    *nnodes = 1;

    return PLATFORM;
}



SEXP main_cpuid_info()
{
    SEXP nnodes, ncores;
    SEXP clock, peak;
    SEXP RET, RET_NAMES;

    PROTECT(nnodes = allocVector(INTSXP, 1));
    PROTECT(ncores = allocVector(INTSXP, 1));

    PROTECT(clock = allocVector(REALSXP, 1));
    PROTECT(peak = allocVector(REALSXP, 1));

    PROTECT(RET = allocVector(VECSXP, 4));
    PROTECT(RET_NAMES = allocVector(STRSXP, 4));

    int support;
    int ops_per_cycle;

    support = cpu_hardware_info(REAL(clock), INTEGER(nnodes), INTEGER(ncores));

    #define type DOUBLE
    if (type == SINGLE)
        ops_per_cycle = 4;
    else if (type == DOUBLE)
        ops_per_cycle = 2;

    // peak = nnodes * (operand/cycle) * (# cores) * (SSE/core) * (cycles/second)
/*    peak = ((double) nnodes * ops_per_cycle * ncores) * clock;*/
    REAL(peak)[0] = ((double) INTEGER(nnodes)[0] * ops_per_cycle * INTEGER(ncores)[0]) * REAL(clock)[0];


/*    if (support == PLATFORM_SUPPORTED)*/
/*    {*/
/*        printf("clock=%f, cpus=%d, cores=%d\n", clock, nnodes, ncores);*/
/*        printf("peak=%f\n", peak);*/
/*    }*/
/*    else*/
/*        printf("platform not supported\n");*/

    // Return
    SET_VECTOR_ELT(RET, 0, nnodes);
    SET_VECTOR_ELT(RET, 1, ncores);
    SET_VECTOR_ELT(RET, 2, clock);
    SET_VECTOR_ELT(RET, 3, peak);

    SET_STRING_ELT(RET_NAMES, 0, mkChar("nnodes"));
    SET_STRING_ELT(RET_NAMES, 1, mkChar("ncores"));
    SET_STRING_ELT(RET_NAMES, 2, mkChar("clock"));
    SET_STRING_ELT(RET_NAMES, 3, mkChar("peak"));

    setAttrib(RET, R_NamesSymbol, RET_NAMES);

    UNPROTECT(6);

    return RET;
}
