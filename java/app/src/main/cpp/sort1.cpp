/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sort1.cpp
 *
 * Code generation for function 'sort1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "sort1.h"
#include "pt_emxutil.h"
#include "sortIdx.h"

/* Function Definitions */
void sort(emxArray_int32_T *x)
{
  int dim;
  int j;
  emxArray_int32_T *vwork;
  int vlen;
  int vstride;
  int k;
  emxArray_int32_T *b_vwork;
  dim = 0;
  if (x->size[0] != 1) {
    dim = -1;
  }

  if (dim + 2 <= 1) {
    j = x->size[0];
  } else {
    j = 1;
  }

  emxInit_int32_T(&vwork, 1);
  vlen = j - 1;
  vstride = vwork->size[0];
  vwork->size[0] = j;
  emxEnsureCapacity_int32_T(vwork, vstride);
  vstride = 1;
  for (k = 0; k <= dim; k++) {
    vstride *= x->size[0];
  }

  emxInit_int32_T(&b_vwork, 1);
  for (j = 0; j < vstride; j++) {
    for (k = 0; k <= vlen; k++) {
      vwork->data[k] = x->data[j + k * vstride];
    }

    sortIdx(vwork, b_vwork);
    for (k = 0; k <= vlen; k++) {
      x->data[j + k * vstride] = vwork->data[k];
    }
  }

  emxFree_int32_T(&b_vwork);
  emxFree_int32_T(&vwork);
}

/* End of code generation (sort1.cpp) */
