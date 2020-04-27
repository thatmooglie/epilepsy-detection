/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xscal.cpp
 *
 * Code generation for function 'xscal'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "xscal.h"

/* Function Definitions */
void xscal(int n, double a, emxArray_real_T *x)
{
  int i19;
  int k;
  i19 = n + 1;
  for (k = 2; k <= i19; k++) {
    x->data[k - 1] *= a;
  }
}

/* End of code generation (xscal.cpp) */
