/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mean.cpp
 *
 * Code generation for function 'mean'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "mean.h"

/* Function Definitions */
double b_mean(const double x[8])
{
  double y;
  int k;
  y = x[0];
  for (k = 0; k < 7; k++) {
    y += x[k + 1];
  }

  y /= 8.0;
  return y;
}

double mean(const emxArray_real_T *x)
{
  double y;
  int vlen;
  int k;
  vlen = x->size[0];
  if (x->size[0] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    for (k = 2; k <= vlen; k++) {
      y += x->data[k - 1];
    }
  }

  y /= static_cast<double>(x->size[0]);
  return y;
}

/* End of code generation (mean.cpp) */
