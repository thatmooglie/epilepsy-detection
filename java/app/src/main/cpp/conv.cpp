/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * conv.cpp
 *
 * Code generation for function 'conv'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "conv.h"
#include "pt_emxutil.h"

/* Function Definitions */
void b_conv(const emxArray_real_T *A, emxArray_real_T *C)
{
  int nA;
  int i5;
  int loop_ub;
  int k;
  static const signed char iv1[33] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, 31, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, 0 };

  nA = A->size[0] - 1;
  i5 = C->size[0];
  C->size[0] = A->size[0] + 32;
  emxEnsureCapacity_real_T(C, i5);
  loop_ub = A->size[0];
  for (i5 = 0; i5 <= loop_ub + 31; i5++) {
    C->data[i5] = 0.0;
  }

  if (33 > A->size[0]) {
    for (loop_ub = 0; loop_ub <= nA; loop_ub++) {
      for (k = 0; k < 33; k++) {
        i5 = loop_ub + k;
        C->data[i5] += A->data[loop_ub] * static_cast<double>(iv1[k]);
      }
    }
  } else {
    for (loop_ub = 0; loop_ub < 33; loop_ub++) {
      for (k = 0; k <= nA; k++) {
        i5 = loop_ub + k;
        C->data[i5] += static_cast<double>(iv1[loop_ub]) * A->data[k];
      }
    }
  }
}

void c_conv(const emxArray_real_T *A, emxArray_real_T *C)
{
  int nA;
  int nC;
  int i16;
  int k;
  static const double dv1[5] = { -0.125, -0.25, 0.0, 0.25, 0.125 };

  nA = A->size[0] - 1;
  if (A->size[0] == 0) {
    nC = 4;
  } else {
    nC = A->size[0] + 3;
  }

  i16 = C->size[0];
  C->size[0] = nC + 1;
  emxEnsureCapacity_real_T(C, i16);
  for (i16 = 0; i16 <= nC; i16++) {
    C->data[i16] = 0.0;
  }

  if (A->size[0] > 0) {
    if (5 > A->size[0]) {
      for (nC = 0; nC <= nA; nC++) {
        for (k = 0; k < 5; k++) {
          i16 = nC + k;
          C->data[i16] += A->data[nC] * dv1[k];
        }
      }
    } else {
      for (nC = 0; nC < 5; nC++) {
        for (k = 0; k <= nA; k++) {
          i16 = nC + k;
          C->data[i16] += dv1[nC] * A->data[k];
        }
      }
    }
  }
}

void conv(const emxArray_real_T *A, emxArray_real_T *C)
{
  int nA;
  int nC;
  int i4;
  int k;
  static const signed char iv0[13] = { 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 0, 0 };

  nA = A->size[0] - 1;
  if (A->size[0] == 0) {
    nC = 12;
  } else {
    nC = A->size[0] + 11;
  }

  i4 = C->size[0];
  C->size[0] = nC + 1;
  emxEnsureCapacity_real_T(C, i4);
  for (i4 = 0; i4 <= nC; i4++) {
    C->data[i4] = 0.0;
  }

  if (A->size[0] > 0) {
    if (13 > A->size[0]) {
      for (nC = 0; nC <= nA; nC++) {
        for (k = 0; k < 13; k++) {
          i4 = nC + k;
          C->data[i4] += A->data[nC] * static_cast<double>(iv0[k]);
        }
      }
    } else {
      for (nC = 0; nC < 13; nC++) {
        for (k = 0; k <= nA; k++) {
          i4 = nC + k;
          C->data[i4] += static_cast<double>(iv0[nC]) * A->data[k];
        }
      }
    }
  }
}

void d_conv(const emxArray_real_T *A, const double B_data[], const int B_size[2],
            emxArray_real_T *C)
{
  int nA;
  int nB;
  int nApnB;
  int i17;
  int k;
  nA = A->size[0] - 1;
  nB = B_size[1] - 1;
  nApnB = (A->size[0] + B_size[1]) - 2;
  i17 = C->size[0];
  C->size[0] = nApnB + 1;
  emxEnsureCapacity_real_T(C, i17);
  for (i17 = 0; i17 <= nApnB; i17++) {
    C->data[i17] = 0.0;
  }

  if (B_size[1] > A->size[0]) {
    for (nApnB = 0; nApnB <= nA; nApnB++) {
      for (k = 0; k <= nB; k++) {
        i17 = nApnB + k;
        C->data[i17] += A->data[nApnB] * B_data[k];
      }
    }
  } else {
    for (nApnB = 0; nApnB <= nB; nApnB++) {
      for (k = 0; k <= nA; k++) {
        i17 = nApnB + k;
        C->data[i17] += B_data[nApnB] * A->data[k];
      }
    }
  }
}

/* End of code generation (conv.cpp) */
