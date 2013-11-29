// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright 2013, Schmidt, Heckendorf

#include "cpuid.h"

#include "cpuid/libcpuid/libcpuid.h"

#include <string.h>
#include <stdio.h>


#if defined(__linux__)
    #include <sys/sysinfo.h>
    #include <unistd.h>

    int get_ncores(void)
    {
        return sysconf(_SC_NPROCESSORS_ONLN);
    }

    PLATFORM = PLATFORM_SUPPORTED;
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

    PLATFORM = PLATFORM_SUPPORTED;
#else
    #ifdef GET_TOTAL_CPUS_DEFINED
      int get_ncores(void)
      {
          return get_total_cpus(void);
      }
      PLATFORM = PLATFORM_SUPPORTED;
    #else
      PLATFORM = PLATFORM_ERROR;

    #endif

#endif

