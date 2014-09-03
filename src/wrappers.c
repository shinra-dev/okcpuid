// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright 2013-2014, Schmidt

#include "cpuid.h"
#include "cpuid/libcpuid/libcpuid.h"
#include <RNACI.h>


int get_ncores();
int cpuid_get_raw_data(struct cpu_raw_data_t* data);
int cpu_identify(struct cpu_raw_data_t* raw, struct cpu_id_t* data);



SEXP Rcpuid_cpuid_info()
{
  R_INIT;
  int ops_per_cycle;
  
  SEXP ncores, clock, peak;
  SEXP RET, RET_NAMES;
  
  newRvec(ncores, 1, "int");
  newRvec(clock, 1, "dbl");
  newRvec(peak, 1, "dbl");
  
  INT(ncores) = get_ncores();
  
  DBL(clock) = cpu_clock_measure(200, 0);
  
  
  // 4 for single, 2 for double
  ops_per_cycle = 2;
  
  DBL(peak) = (double) (ops_per_cycle * INT(ncores)) * DBL(clock);
/*  cpu_clock_by_os()*/
  
  RET_NAMES = make_list_names(3, "ncores", "clock", "peak");
  RET = make_list(RET_NAMES, 3, ncores, clock, peak);
  
  R_END;
  return RET;
}



SEXP Rcpuid_available_instructions()
{
  R_INIT;
  struct cpu_raw_data_t raw;
  struct cpu_id_t data;
  SEXP mmx, mmxext, sse, sse2;
  SEXP ret, ret_names;
  
  if (cpuid_get_raw_data(&raw) < 0)
    error("Sorry, cannot get the CPUID raw data.\n");
  
  if (cpu_identify(&raw, &data) < 0)
    error("Sorrry, CPU identification failed.\n");
  
  
  newRvec(mmx,    1, "str");
  newRvec(mmxext, 1, "str");
  newRvec(sse,    1, "str");
  newRvec(sse2,   1, "str");
  
  SET_STRING_ELT(mmx,     0, mkChar(data.flags[CPU_FEATURE_MMX] ? "present" : "absent"));
  SET_STRING_ELT(mmxext,  0, mkChar(data.flags[CPU_FEATURE_MMXEXT] ? "present" : "absent"));
  SET_STRING_ELT(sse,     0, mkChar(data.flags[CPU_FEATURE_SSE] ? "present" : "absent"));
  SET_STRING_ELT(sse2,    0, mkChar(data.flags[CPU_FEATURE_SSE2] ? "present" : "absent"));
  
  ret_names = make_list_names(4, "mmx", "mmx.extended", "sse", "sse2");
  ret = make_list(ret_names, 4, mmx, mmxext, sse, sse2);
  
  R_END;
  return ret;
}



SEXP Rcpuid_cpuid()
{
  R_INIT;
  struct cpu_raw_data_t raw;
  struct cpu_id_t data;
  SEXP vendor, codename, brand;
  SEXP ret, ret_names;
  
  if (cpuid_get_raw_data(&raw) < 0)
    error("Sorry, cannot get the CPUID raw data.\n");
  
  if (cpu_identify(&raw, &data) < 0)
    error("Sorrry, CPU identification failed.\n");
  
  
  newRvec(vendor,   1, "str");
  newRvec(codename, 1, "str");
  newRvec(brand,    1, "str");
  
  SET_STRING_ELT(vendor, 0, mkChar(data.vendor_str));
  SET_STRING_ELT(codename, 0, mkChar(data.cpu_codename));
  SET_STRING_ELT(brand, 0, mkChar(data.brand_str));
  
  ret_names = make_list_names(3, "vendor", "codename", "brand");
  ret = make_list(ret_names, 3, vendor, codename, brand);
  
  R_END;
  return ret;
}



