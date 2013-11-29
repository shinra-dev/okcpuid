#ifndef __CPUID_H__
#define __CPUID_H__


// R crap
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

#define CHARPT(x,i) ((char*)CHAR(STRING_ELT(x,i)))


// defines
#define SINGLE 0
#define DOUBLE 1

int PLATFORM;

#define PLATFORM_SUPPORTED 0
#define PLATFORM_ERROR 1


// Functions
int get_ncores(void);


#endif
