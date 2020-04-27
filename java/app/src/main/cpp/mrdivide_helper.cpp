/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mrdivide_helper.cpp
 *
 * Code generation for function 'mrdivide_helper'
 *
 */

/* Include files */
#include <cmath>
#include "rt_nonfinite.h"
#include "pt.h"
#include "mrdivide_helper.h"
#include "pt_emxutil.h"
#include "xscal.h"
#include "xnrm2.h"

/* Function Declarations */
static double rt_hypotd_snf(double u0, double u1);

/* Function Definitions */
static double rt_hypotd_snf(double u0, double u1)
{
  double y;
  double a;
  double b;
  a = std::abs(u0);
  b = std::abs(u1);
  if (a < b) {
    a /= b;
    y = b * std::sqrt(a * a + 1.0);
  } else if (a > b) {
    b /= a;
    y = a * std::sqrt(b * b + 1.0);
  } else if (rtIsNaN(b)) {
    y = b;
  } else {
    y = a * 1.4142135623730951;
  }

  return y;
}

void mrdivide_helper(const emxArray_real_T *A, const emxArray_real_T *B,
                     emxArray_real_T *Y)
{
  emxArray_real_T *b_Y;
  emxArray_real_T *b_A;
  emxArray_real_T *b_B;
  unsigned int unnamed_idx_0;
  int i;
  double xnorm;
  int knt;
  int m;
  int mn;
  double atmp;
  int j;
  double tau_data_idx_0;
  double beta1;
  int rankR;
  int nb;
  int k;
  emxInit_real_T(&b_Y, 2);
  emxInit_real_T(&b_A, 1);
  emxInit_real_T(&b_B, 2);
  if ((A->size[0] == 0) || (A->size[1] == 0) || (B->size[1] == 0)) {
    unnamed_idx_0 = static_cast<unsigned int>(A->size[0]);
    i = Y->size[0];
    Y->size[0] = static_cast<int>(unnamed_idx_0);
    emxEnsureCapacity_real_T(Y, i);
    knt = static_cast<int>(unnamed_idx_0);
    for (i = 0; i < knt; i++) {
      Y->data[i] = 0.0;
    }
  } else if (1 == B->size[1]) {
    xnorm = B->data[0];
    knt = A->size[0];
    i = Y->size[0];
    Y->size[0] = knt;
    emxEnsureCapacity_real_T(Y, i);
    for (i = 0; i < knt; i++) {
      Y->data[i] = A->data[i] / xnorm;
    }
  } else {
    i = b_A->size[0];
    b_A->size[0] = B->size[1];
    emxEnsureCapacity_real_T(b_A, i);
    knt = B->size[1];
    for (i = 0; i < knt; i++) {
      b_A->data[i] = B->data[i];
    }

    i = b_B->size[0] * b_B->size[1];
    b_B->size[0] = A->size[1];
    b_B->size[1] = A->size[0];
    emxEnsureCapacity_real_T(b_B, i);
    knt = A->size[0];
    for (i = 0; i < knt; i++) {
      mn = A->size[1];
      for (j = 0; j < mn; j++) {
        b_B->data[j + b_B->size[0] * i] = A->data[i + A->size[0] * j];
      }
    }

    m = b_A->size[0] - 1;
    atmp = b_A->data[0];
    tau_data_idx_0 = 0.0;
    xnorm = xnrm2(m, b_A);
    if (xnorm != 0.0) {
      beta1 = rt_hypotd_snf(b_A->data[0], xnorm);
      if (b_A->data[0] >= 0.0) {
        beta1 = -beta1;
      }

      if (std::abs(beta1) < 1.0020841800044864E-292) {
        knt = -1;
        do {
          knt++;
          xscal(m, 9.9792015476736E+291, b_A);
          beta1 *= 9.9792015476736E+291;
          atmp *= 9.9792015476736E+291;
        } while (!(std::abs(beta1) >= 1.0020841800044864E-292));

        beta1 = rt_hypotd_snf(atmp, xnrm2(m, b_A));
        if (atmp >= 0.0) {
          beta1 = -beta1;
        }

        tau_data_idx_0 = (beta1 - atmp) / beta1;
        xscal(m, 1.0 / (atmp - beta1), b_A);
        for (k = 0; k <= knt; k++) {
          beta1 *= 1.0020841800044864E-292;
        }

        atmp = beta1;
      } else {
        tau_data_idx_0 = (beta1 - b_A->data[0]) / beta1;
        xnorm = 1.0 / (b_A->data[0] - beta1);
        xscal(m, xnorm, b_A);
        atmp = beta1;
      }
    }

    b_A->data[0] = atmp;
    rankR = 0;
    if (b_A->size[0] >= 1) {
      knt = b_A->size[0];
      xnorm = 2.2204460492503131E-15 * static_cast<double>(knt);
      if (1.4901161193847656E-8 < xnorm) {
        xnorm = 1.4901161193847656E-8;
      }

      xnorm *= std::abs(b_A->data[0]);
      if (!(std::abs(b_A->data[0]) <= xnorm)) {
        rankR = 1;
      }
    }

    nb = b_B->size[1];
    knt = b_B->size[1];
    i = b_Y->size[0] * b_Y->size[1];
    b_Y->size[0] = 1;
    b_Y->size[1] = knt;
    emxEnsureCapacity_real_T(b_Y, i);
    for (i = 0; i < knt; i++) {
      b_Y->data[i] = 0.0;
    }

    m = b_A->size[0];
    knt = b_B->size[1];
    if (b_A->size[0] < 1) {
      mn = -1;
    } else {
      mn = 0;
    }

    for (j = 0; j <= mn; j++) {
      if (tau_data_idx_0 != 0.0) {
        for (k = 0; k < knt; k++) {
          xnorm = b_B->data[b_B->size[0] * k];
          for (i = 2; i <= m; i++) {
            xnorm += b_A->data[i - 1] * b_B->data[(i + b_B->size[0] * k) - 1];
          }

          xnorm *= tau_data_idx_0;
          if (xnorm != 0.0) {
            b_B->data[b_B->size[0] * k] -= xnorm;
            for (i = 2; i <= m; i++) {
              b_B->data[(i + b_B->size[0] * k) - 1] -= b_A->data[i - 1] * xnorm;
            }
          }
        }
      }
    }

    for (k = 0; k < nb; k++) {
      for (i = 0; i < rankR; i++) {
        b_Y->data[k] = b_B->data[b_B->size[0] * k];
      }

      for (j = rankR; j >= 1; j--) {
        b_Y->data[k] /= b_A->data[0];
      }
    }

    i = Y->size[0];
    Y->size[0] = b_Y->size[1];
    emxEnsureCapacity_real_T(Y, i);
    knt = b_Y->size[1];
    for (i = 0; i < knt; i++) {
      Y->data[i] = b_Y->data[i];
    }
  }

  emxFree_real_T(&b_B);
  emxFree_real_T(&b_A);
  emxFree_real_T(&b_Y);
}

/* End of code generation (mrdivide_helper.cpp) */
