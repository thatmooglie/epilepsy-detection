/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.cpp
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "power.h"
#include "pt_emxutil.h"

/* Function Definitions */
void power(const emxArray_real_T *a, emxArray_real_T *y)
{
  unsigned int a_idx_0;
  int nx;
  int k;
  a_idx_0 = static_cast<unsigned int>(a->size[0]);
  nx = y->size[0];
  y->size[0] = static_cast<int>(a_idx_0);
  emxEnsureCapacity_real_T(y, nx);
  a_idx_0 = static_cast<unsigned int>(a->size[0]);
  nx = static_cast<int>(a_idx_0);
  for (k = 0; k < nx; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

/* End of code generation (power.cpp) */
