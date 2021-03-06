#include "cpuid.h"

#include <stdio.h>
#include "cpuid/libcpuid/libcpuid.h"

SEXP cpuid_test()
{
    SEXP ret;
    PROTECT(ret = allocVector(INTSXP, 1));
    INTEGER(ret)[0] = 0;


    if (!cpuid_present()) {
        Rprintf("Sorry, your CPU doesn't support CPUID!\n");
        return -1;
    }

    struct cpu_raw_data_t raw;
    struct cpu_id_t data;

    if (cpuid_get_raw_data(&raw) < 0) {
        Rprintf("Sorry, cannot get the CPUID raw data.\n");
        Rprintf("Error: %s\n", cpuid_error());
        return -2;
    }

    if (cpu_identify(&raw, &data) < 0) {
        Rprintf("Sorrry, CPU identification failed.\n");
        Rprintf("Error: %s\n", cpuid_error());
        return -3;
    }


    Rprintf("Found: %s CPU\n", data.vendor_str);                            // print out the vendor string (e.g. `GenuineIntel')
    Rprintf("Processor model is `%s'\n", data.cpu_codename);                // print out the CPU code name (e.g. `Pentium 4 (Northwood)')
    Rprintf("The full brand string is `%s'\n", data.brand_str);             // print out the CPU brand string
    Rprintf("The processor has %dK L1 cache and %dK L2 cache\n",
        data.l1_data_cache, data.l2_cache);                            // print out cache size information
    Rprintf("The processor has %d cores and %d logical processors\n",
        data.num_cores, data.num_logical_cpus);



    Rprintf("Supported multimedia instruction sets:\n");
    Rprintf("  MMX         : %s\n", data.flags[CPU_FEATURE_MMX] ? "present" : "absent");
    Rprintf("  MMX-extended: %s\n", data.flags[CPU_FEATURE_MMXEXT] ? "present" : "absent");
    Rprintf("  SSE         : %s\n", data.flags[CPU_FEATURE_SSE] ? "present" : "absent");
    Rprintf("  SSE2        : %s\n", data.flags[CPU_FEATURE_SSE2] ? "present" : "absent");
    Rprintf("  3DNow!      : %s\n", data.flags[CPU_FEATURE_3DNOW] ? "present" : "absent");


    Rprintf("Processor has %d physical cores\n", data.num_cores);
    Rprintf("CPU clock is: %d MHz (according to your OS)\n", cpu_clock_by_os());
    Rprintf("CPU clock is: %d MHz (tested)\n", cpu_clock_measure(200, 0));

    UNPROTECT(1);

    return ret;
}

