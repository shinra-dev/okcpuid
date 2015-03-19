/*
 *  Copyright (c) 2013-2015  Schmidt
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions are met:
 *  
 *  1. Redistributions of source code must retain the above copyright notice, 
 *  this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright 
 *  notice, this list of conditions and the following disclaimer in the 
 *  documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
 *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


#include "cpuid/libcpuid/libcpuid.h"
#include <RNACI.h>


int get_ncores();
int cpuid_get_raw_data(struct cpu_raw_data_t* data);
int cpu_identify(struct cpu_raw_data_t* raw, struct cpu_id_t* data);

#define CHECK_ERROR_RAW \
  if (cpuid_get_raw_data(&raw) < 0)\
    error("Internal libcpuid error; unable to get the raw data.\n");

#define CHECK_ERROR_DATA \
  if (cpu_identify(&raw, &data) < 0) \
    error("Internal libcpuid error; CPU identification failed.\n");


SEXP okcpuid_cpuid_info(SEXP milis, SEXP quad_check)
{
  R_INIT;
  struct cpu_raw_data_t raw;
  struct cpu_id_t data;
  int ops_per_cycle;
  SEXP ncores, clock_os, clock_tested, peak;
  SEXP RET, RET_NAMES;
  
  CHECK_ERROR_RAW;
  CHECK_ERROR_DATA;
  
  newRvec(ncores, 1, "int");
  newRvec(clock_os, 1, "int");
  newRvec(clock_tested, 1, "int");
  newRvec(peak, 1, "dbl");
  
  INT(ncores) = get_ncores();
  
  INT(clock_os) = cpu_clock_by_os();
  
  INT(clock_tested) = cpu_clock_measure(INT(milis), INT(quad_check));
  
  
  // 2 for double, 4 for single
  ops_per_cycle = 2 * (data.flags[CPU_FEATURE_SSE2] ? 2 : 1);
  
  DBL(peak) = (double) (ops_per_cycle * INT(ncores) * INT(clock_tested));
  
  
  RET_NAMES = make_list_names(4, "ncores", "clock.os", "clock.tested", "peak");
  RET = make_list(RET_NAMES, 4, ncores, clock_os, clock_tested, peak);
  
  R_END;
  return RET;
}



SEXP okcpuid_available_instructions()
{
  R_INIT;
  struct cpu_raw_data_t raw;
  struct cpu_id_t data;
  SEXP mmx, mmxext, sse, sse2;
  SEXP ret, ret_names;
  
  CHECK_ERROR_RAW;
  CHECK_ERROR_DATA;
  
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



SEXP okcpuid_cpuid()
{
  R_INIT;
  struct cpu_raw_data_t raw;
  struct cpu_id_t data;
  SEXP vendor, codename, brand;
  SEXP ret, ret_names;
  
  CHECK_ERROR_RAW;
  CHECK_ERROR_DATA;
  
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


