#include <R.h>
#include <Rinternals.h>

#include <RNACI.h>

void dgesv_(int *n, int *nrhs, double *a, int *lda, int *ipiv, double *b, int *ldb, int *info);


SEXP R_solve_nocopy(SEXP A, SEXP B)
{
  int n = nrows(A);
  int nrhs = 1;
  int info = 0;
  
  PROTECT(A);
  PROTECT(B);
  
  int *ipiv = malloc(n*sizeof(ipiv));
  
  dgesv_(&n, &nrhs, REAL(A), &n, ipiv, REAL(B), &n, &info);
  
  free(ipiv);
  UNPROTECT(2);
  return R_NilValue;
}
