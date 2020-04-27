/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * filtfilt.cpp
 *
 * Code generation for function 'filtfilt'
 *
 */

/* Include files */
#include <string.h>
#include "rt_nonfinite.h"
#include "pt.h"
#include "filtfilt.h"
#include "pt_emxutil.h"
#include "filter.h"
#include "bsxfun.h"
#include "introsort.h"
#include "solve_from_lu.h"
#include "makeCXSparseMatrix.h"
#include "solve_from_qr.h"

/* Type Definitions */
#include "cs.h"

/* Function Declarations */
static int div_s32(int numerator, int denominator);
static int div_s32_floor(int numerator, int denominator);
static void efiltfilt(const emxArray_real_T *x, emxArray_real_T *y);
static void getCoeffsAndInitialConditions(double b1_data[], int b1_size[1],
  double a1_data[], int a1_size[1], double zi_data[], int zi_size[1], double *L);

/* Function Definitions */
static int div_s32(int numerator, int denominator)
{
  int quotient;
  unsigned int b_numerator;
  unsigned int b_denominator;
  unsigned int tempAbsQuotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    if (numerator < 0) {
      b_numerator = ~static_cast<unsigned int>(numerator) + 1U;
    } else {
      b_numerator = static_cast<unsigned int>(numerator);
    }

    if (denominator < 0) {
      b_denominator = ~static_cast<unsigned int>(denominator) + 1U;
    } else {
      b_denominator = static_cast<unsigned int>(denominator);
    }

    tempAbsQuotient = b_numerator / b_denominator;
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int>(tempAbsQuotient);
    } else {
      quotient = static_cast<int>(tempAbsQuotient);
    }
  }

  return quotient;
}

static int div_s32_floor(int numerator, int denominator)
{
  int quotient;
  unsigned int absNumerator;
  unsigned int absDenominator;
  boolean_T quotientNeedsNegation;
  unsigned int tempAbsQuotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    if (numerator < 0) {
      absNumerator = ~static_cast<unsigned int>(numerator) + 1U;
    } else {
      absNumerator = static_cast<unsigned int>(numerator);
    }

    if (denominator < 0) {
      absDenominator = ~static_cast<unsigned int>(denominator) + 1U;
    } else {
      absDenominator = static_cast<unsigned int>(denominator);
    }

    quotientNeedsNegation = ((numerator < 0) != (denominator < 0));
    tempAbsQuotient = absNumerator / absDenominator;
    if (quotientNeedsNegation) {
      absNumerator %= absDenominator;
      if (absNumerator > 0U) {
        tempAbsQuotient++;
      }

      quotient = -static_cast<int>(tempAbsQuotient);
    } else {
      quotient = static_cast<int>(tempAbsQuotient);
    }
  }

  return quotient;
}

static void efiltfilt(const emxArray_real_T *x, emxArray_real_T *y)
{
  boolean_T p;
  emxArray_real_T *xCol;
  int i6;
  int naxpy;
  double b2_data[7];
  int b2_size[1];
  double a2_data[7];
  int a2_size[1];
  double zi_data[6];
  int zi_size[1];
  double a1;
  unsigned int sz_idx_0;
  emxArray_real_T *yc5;
  unsigned int sz_idx_1;
  emxArray_real_T *ytemp;
  int i7;
  double d1;
  int niccp;
  int lb;
  double xt[18];
  double b_b2_data[7];
  double b_a2_data[7];
  double b_zi_data[6];
  emxArray_real_T *b_xt;
  emxArray_real_T *yc3;
  double c_b2_data[7];
  double c_a2_data[7];
  double unusedU0[18];
  double zo_data[6];
  emxArray_real_T *zo;
  emxArray_real_T *yc2;
  emxArray_real_T *r2;
  emxArray_real_T *zi;
  int k;
  int j;
  double b_yc3[18];
  p = (x->size[0] == 1);
  emxInit_real_T(&xCol, 2);
  if (p) {
    i6 = xCol->size[0] * xCol->size[1];
    xCol->size[0] = 1;
    xCol->size[1] = x->size[0];
    emxEnsureCapacity_real_T(xCol, i6);
    naxpy = x->size[0];
    for (i6 = 0; i6 < naxpy; i6++) {
      xCol->data[xCol->size[0] * i6] = x->data[i6];
    }
  } else {
    i6 = xCol->size[0] * xCol->size[1];
    xCol->size[0] = x->size[0];
    xCol->size[1] = 1;
    emxEnsureCapacity_real_T(xCol, i6);
    naxpy = x->size[0];
    for (i6 = 0; i6 < naxpy; i6++) {
      xCol->data[i6] = x->data[i6];
    }
  }

  getCoeffsAndInitialConditions(b2_data, b2_size, a2_data, a2_size, zi_data,
    zi_size, &a1);
  if (xCol->size[1] == 1) {
    emxInit_real_T(&yc5, 1);
    emxInit_real_T(&ytemp, 1);
    if (xCol->size[0] < 10000) {
      d1 = 2.0 * xCol->data[0];
      a1 = 2.0 * xCol->data[xCol->size[0] - 1];
      lb = xCol->size[0] - 2;
      naxpy = xCol->size[0];
      i6 = ytemp->size[0];
      ytemp->size[0] = naxpy + 36;
      emxEnsureCapacity_real_T(ytemp, i6);
      for (i6 = 0; i6 < 18; i6++) {
        ytemp->data[i6] = d1 - xCol->data[18 - i6];
      }

      for (i6 = 0; i6 < naxpy; i6++) {
        ytemp->data[i6 + 18] = xCol->data[i6];
      }

      for (i6 = 0; i6 < 18; i6++) {
        ytemp->data[(i6 + naxpy) + 18] = a1 - xCol->data[lb - i6];
      }

      naxpy = ytemp->size[0] - 1;
      d1 = ytemp->data[0];
      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      i6 = yc5->size[0];
      yc5->size[0] = naxpy + 1;
      emxEnsureCapacity_real_T(yc5, i6);
      for (i6 = 0; i6 <= naxpy; i6++) {
        yc5->data[i6] = ytemp->data[i6];
      }

      for (i6 = 0; i6 < 6; i6++) {
        b_zi_data[i6] = zi_data[i6] * d1;
      }

      filter(b_b2_data, b_a2_data, yc5, b_zi_data, ytemp);
      i6 = ytemp->size[0] - 1;
      i7 = yc5->size[0];
      naxpy = div_s32_floor(-i6, -1);
      yc5->size[0] = naxpy + 1;
      emxEnsureCapacity_real_T(yc5, i7);
      for (i7 = 0; i7 <= naxpy; i7++) {
        yc5->data[i7] = ytemp->data[i6 - i7];
      }

      i6 = ytemp->size[0];
      ytemp->size[0] = yc5->size[0];
      emxEnsureCapacity_real_T(ytemp, i6);
      naxpy = yc5->size[0];
      for (i6 = 0; i6 < naxpy; i6++) {
        ytemp->data[i6] = yc5->data[i6];
      }

      naxpy = ytemp->size[0] - 1;
      d1 = ytemp->data[0];
      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      i6 = yc5->size[0];
      yc5->size[0] = naxpy + 1;
      emxEnsureCapacity_real_T(yc5, i6);
      for (i6 = 0; i6 <= naxpy; i6++) {
        yc5->data[i6] = ytemp->data[i6];
      }

      for (i6 = 0; i6 < 6; i6++) {
        b_zi_data[i6] = zi_data[i6] * d1;
      }

      filter(b_b2_data, b_a2_data, yc5, b_zi_data, ytemp);
      i6 = ytemp->size[0];
      i7 = xCol->size[0] * xCol->size[1];
      naxpy = div_s32_floor(37 - i6, -1) + 1;
      xCol->size[0] = naxpy;
      xCol->size[1] = 1;
      emxEnsureCapacity_real_T(xCol, i7);
      i6 = ytemp->size[0];
      for (i7 = 0; i7 < naxpy; i7++) {
        xCol->data[i7] = ytemp->data[(i6 - i7) - 19];
      }
    } else {
      a1 = a2_data[0];
      d1 = 2.0 * xCol->data[0];
      for (i6 = 0; i6 < 18; i6++) {
        xt[i6] = -xCol->data[18 - i6] + d1;
      }

      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      for (i6 = 0; i6 < 6; i6++) {
        b_zi_data[i6] = zi_data[i6] * xt[0];
      }

      for (i6 = 0; i6 < 7; i6++) {
        c_b2_data[i6] = b_b2_data[i6];
        c_a2_data[i6] = b_a2_data[i6];
      }

      b_filter(c_b2_data, c_a2_data, xt, b_zi_data, unusedU0, zo_data, b2_size);
      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      if ((!rtIsInf(a2_data[0])) && (!rtIsNaN(a2_data[0])) && (!(a2_data[0] ==
            0.0)) && (a2_data[0] != 1.0)) {
        for (k = 0; k < 7; k++) {
          b_b2_data[k] /= a1;
        }

        for (k = 0; k < 6; k++) {
          b_a2_data[k + 1] /= a1;
        }

        b_a2_data[0] = 1.0;
      }

      i6 = xCol->size[0];
      i7 = ytemp->size[0];
      ytemp->size[0] = i6;
      emxEnsureCapacity_real_T(ytemp, i7);
      i6 = xCol->size[0];
      for (i7 = 0; i7 < 6; i7++) {
        b_zi_data[i7] = 0.0;
      }

      i7 = xCol->size[0];
      if (i7 < 6) {
        niccp = xCol->size[0] - 1;
      } else {
        niccp = 5;
      }

      for (k = 0; k <= niccp; k++) {
        ytemp->data[k] = zo_data[k];
      }

      i7 = niccp + 2;
      for (k = i7; k <= i6; k++) {
        ytemp->data[k - 1] = 0.0;
      }

      for (k = 0; k < i6; k++) {
        niccp = i6 - k;
        if (niccp < 7) {
          naxpy = niccp;
        } else {
          naxpy = 7;
        }

        for (j = 0; j < naxpy; j++) {
          i7 = k + j;
          ytemp->data[i7] += xCol->data[k] * b_b2_data[j];
        }

        naxpy = niccp - 1;
        if (naxpy >= 6) {
          naxpy = 6;
        }

        a1 = -ytemp->data[k];
        for (j = 0; j < naxpy; j++) {
          i7 = (k + j) + 1;
          ytemp->data[i7] += a1 * b_a2_data[1 + j];
        }
      }

      i7 = xCol->size[0];
      if (i7 < 6) {
        i7 = xCol->size[0];
        niccp = 5 - i7;
        for (k = 0; k <= niccp; k++) {
          b_zi_data[k] = zo_data[k + i6];
        }
      }

      i7 = xCol->size[0];
      if (i7 >= 7) {
        lb = xCol->size[0] - 6;
      } else {
        lb = 0;
      }

      i7 = xCol->size[0];
      for (k = lb; k < i7; k++) {
        niccp = i6 - k;
        naxpy = 6 - niccp;
        for (j = 0; j <= naxpy; j++) {
          b_zi_data[j] += xCol->data[k] * b_b2_data[niccp + j];
        }
      }

      i7 = xCol->size[0];
      if (i7 >= 7) {
        lb = xCol->size[0] - 6;
      } else {
        lb = 0;
      }

      i7 = xCol->size[0];
      for (k = lb; k < i7; k++) {
        niccp = i6 - k;
        naxpy = 6 - niccp;
        for (j = 0; j <= naxpy; j++) {
          b_zi_data[j] += -ytemp->data[k] * b_a2_data[niccp + j];
        }
      }

      lb = xCol->size[0] - 2;
      d1 = 2.0 * xCol->data[xCol->size[0] - 1];
      for (i6 = 0; i6 < 18; i6++) {
        xt[i6] = -xCol->data[lb - i6] + d1;
      }

      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      c_filter(b_b2_data, b_a2_data, xt, b_zi_data, b_yc3);
      a1 = b_yc3[17];
      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      for (i6 = 0; i6 < 18; i6++) {
        xt[i6] = b_yc3[17 - i6];
      }

      memcpy(&b_yc3[0], &xt[0], 18U * sizeof(double));
      for (i6 = 0; i6 < 6; i6++) {
        b_zi_data[i6] = zi_data[i6] * a1;
      }

      b_filter(b_b2_data, b_a2_data, b_yc3, b_zi_data, unusedU0, zo_data,
               b2_size);
      for (i6 = 0; i6 < 7; i6++) {
        b_b2_data[i6] = b2_data[i6];
        b_a2_data[i6] = a2_data[i6];
      }

      i6 = ytemp->size[0] - 1;
      i7 = yc5->size[0];
      naxpy = div_s32_floor(-i6, -1);
      yc5->size[0] = naxpy + 1;
      emxEnsureCapacity_real_T(yc5, i7);
      for (i7 = 0; i7 <= naxpy; i7++) {
        yc5->data[i7] = ytemp->data[i6 - i7];
      }

      i6 = ytemp->size[0];
      ytemp->size[0] = yc5->size[0];
      emxEnsureCapacity_real_T(ytemp, i6);
      naxpy = yc5->size[0];
      for (i6 = 0; i6 < naxpy; i6++) {
        ytemp->data[i6] = yc5->data[i6];
      }

      filter(b_b2_data, b_a2_data, ytemp, zo_data, yc5);
      i6 = yc5->size[0];
      i7 = xCol->size[0] * xCol->size[1];
      naxpy = div_s32_floor(1 - i6, -1) + 1;
      xCol->size[0] = naxpy;
      xCol->size[1] = 1;
      emxEnsureCapacity_real_T(xCol, i7);
      i6 = yc5->size[0];
      for (i7 = 0; i7 < naxpy; i7++) {
        xCol->data[i7] = yc5->data[(i6 - i7) - 1];
      }
    }

    emxFree_real_T(&ytemp);
    emxFree_real_T(&yc5);
  } else {
    sz_idx_0 = static_cast<unsigned int>(xCol->size[0]);
    sz_idx_1 = static_cast<unsigned int>(xCol->size[1]);
    i6 = xCol->size[0];
    i7 = xCol->size[1];
    niccp = static_cast<int>(sz_idx_0);
    lb = div_s32(i6 * i7, (int)sz_idx_0);
    i6 = xCol->size[0] * xCol->size[1];
    xCol->size[0] = static_cast<int>(sz_idx_0);
    xCol->size[1] = lb;
    emxEnsureCapacity_real_T(xCol, i6);
    for (i6 = 0; i6 < lb; i6++) {
      for (i7 = 0; i7 < niccp; i7++) {
        xCol->data[i7 + xCol->size[0] * i6] = xCol->data[i7 + niccp * i6];
      }
    }

    emxInit_real_T(&b_xt, 2);
    emxInit_real_T(&yc3, 2);
    emxInit_real_T(&zo, 2);
    emxInit_real_T(&yc2, 2);
    emxInit_real_T(&r2, 2);
    emxInit_real_T(&zi, 2);
    naxpy = xCol->size[1];
    i6 = r2->size[0] * r2->size[1];
    r2->size[0] = 1;
    r2->size[1] = naxpy;
    emxEnsureCapacity_real_T(r2, i6);
    for (i6 = 0; i6 < naxpy; i6++) {
      r2->data[i6] = 2.0 * xCol->data[xCol->size[0] * i6];
    }

    naxpy = xCol->size[1];
    i6 = yc3->size[0] * yc3->size[1];
    yc3->size[0] = 18;
    yc3->size[1] = naxpy;
    emxEnsureCapacity_real_T(yc3, i6);
    for (i6 = 0; i6 < naxpy; i6++) {
      for (i7 = 0; i7 < 18; i7++) {
        yc3->data[i7 + 18 * i6] = xCol->data[(xCol->size[0] * i6 - i7) + 18];
      }
    }

    bsxfun(r2, yc3, b_xt);
    for (i6 = 0; i6 < 7; i6++) {
      b_b2_data[i6] = b2_data[i6];
      b_a2_data[i6] = a2_data[i6];
    }

    naxpy = b_xt->size[1];
    i6 = zi->size[0] * zi->size[1];
    zi->size[0] = 6;
    zi->size[1] = naxpy;
    emxEnsureCapacity_real_T(zi, i6);
    for (i6 = 0; i6 < 6; i6++) {
      for (i7 = 0; i7 < naxpy; i7++) {
        zi->data[i6 + 6 * i7] = zi_data[i6] * b_xt->data[18 * i7];
      }
    }

    d_filter(b_b2_data, b_a2_data, b_xt, zi, yc3, zo);
    for (i6 = 0; i6 < 7; i6++) {
      b_b2_data[i6] = b2_data[i6];
      b_a2_data[i6] = a2_data[i6];
    }

    e_filter(b_b2_data, b_a2_data, xCol, zo, yc2, zi);
    lb = xCol->size[0] - 2;
    naxpy = xCol->size[1];
    niccp = xCol->size[0];
    i6 = r2->size[0] * r2->size[1];
    r2->size[0] = 1;
    r2->size[1] = naxpy;
    emxEnsureCapacity_real_T(r2, i6);
    for (i6 = 0; i6 < naxpy; i6++) {
      r2->data[i6] = 2.0 * xCol->data[(niccp + xCol->size[0] * i6) - 1];
    }

    naxpy = xCol->size[1];
    i6 = yc3->size[0] * yc3->size[1];
    yc3->size[0] = 18;
    yc3->size[1] = naxpy;
    emxEnsureCapacity_real_T(yc3, i6);
    for (i6 = 0; i6 < naxpy; i6++) {
      for (i7 = 0; i7 < 18; i7++) {
        yc3->data[i7 + 18 * i6] = xCol->data[(lb - i7) + xCol->size[0] * i6];
      }
    }

    bsxfun(r2, yc3, b_xt);
    for (i6 = 0; i6 < 7; i6++) {
      b_b2_data[i6] = b2_data[i6];
      b_a2_data[i6] = a2_data[i6];
    }

    f_filter(b_b2_data, b_a2_data, b_xt, zi, yc3);
    for (i6 = 0; i6 < 7; i6++) {
      b_b2_data[i6] = b2_data[i6];
      b_a2_data[i6] = a2_data[i6];
    }

    naxpy = yc3->size[1];
    i6 = b_xt->size[0] * b_xt->size[1];
    b_xt->size[0] = 18;
    b_xt->size[1] = naxpy;
    emxEnsureCapacity_real_T(b_xt, i6);
    for (i6 = 0; i6 < naxpy; i6++) {
      for (i7 = 0; i7 < 18; i7++) {
        b_xt->data[i7 + 18 * i6] = yc3->data[(18 * i6 - i7) + 17];
      }
    }

    naxpy = yc3->size[1];
    i6 = zi->size[0] * zi->size[1];
    zi->size[0] = 6;
    zi->size[1] = naxpy;
    emxEnsureCapacity_real_T(zi, i6);
    for (i6 = 0; i6 < 6; i6++) {
      for (i7 = 0; i7 < naxpy; i7++) {
        zi->data[i6 + 6 * i7] = zi_data[i6] * yc3->data[17 + 18 * i7];
      }
    }

    d_filter(b_b2_data, b_a2_data, b_xt, zi, yc3, zo);
    for (i6 = 0; i6 < 7; i6++) {
      b_b2_data[i6] = b2_data[i6];
      b_a2_data[i6] = a2_data[i6];
    }

    i6 = yc2->size[0] - 1;
    naxpy = yc2->size[1] - 1;
    i7 = xCol->size[0] * xCol->size[1];
    niccp = div_s32_floor(-i6, -1);
    xCol->size[0] = niccp + 1;
    xCol->size[1] = naxpy + 1;
    emxEnsureCapacity_real_T(xCol, i7);
    for (i7 = 0; i7 <= naxpy; i7++) {
      for (lb = 0; lb <= niccp; lb++) {
        xCol->data[lb + xCol->size[0] * i7] = yc2->data[(i6 - lb) + yc2->size[0]
          * i7];
      }
    }

    i6 = yc2->size[0] * yc2->size[1];
    yc2->size[0] = xCol->size[0];
    yc2->size[1] = xCol->size[1];
    emxEnsureCapacity_real_T(yc2, i6);
    naxpy = xCol->size[1];
    for (i6 = 0; i6 < naxpy; i6++) {
      niccp = xCol->size[0];
      for (i7 = 0; i7 < niccp; i7++) {
        yc2->data[i7 + yc2->size[0] * i6] = xCol->data[i7 + xCol->size[0] * i6];
      }
    }

    g_filter(b_b2_data, b_a2_data, yc2, zo, xCol);
    i6 = xCol->size[0] - 1;
    naxpy = xCol->size[1] - 1;
    i7 = yc2->size[0] * yc2->size[1];
    niccp = div_s32_floor(-i6, -1);
    yc2->size[0] = niccp + 1;
    yc2->size[1] = naxpy + 1;
    emxEnsureCapacity_real_T(yc2, i7);
    for (i7 = 0; i7 <= naxpy; i7++) {
      for (lb = 0; lb <= niccp; lb++) {
        yc2->data[lb + yc2->size[0] * i7] = xCol->data[(i6 - lb) + xCol->size[0]
          * i7];
      }
    }

    i6 = xCol->size[0] * xCol->size[1];
    xCol->size[0] = yc2->size[0];
    xCol->size[1] = yc2->size[1];
    emxEnsureCapacity_real_T(xCol, i6);
    naxpy = yc2->size[0] * yc2->size[1];
    for (i6 = 0; i6 < naxpy; i6++) {
      xCol->data[i6] = yc2->data[i6];
    }

    emxFree_real_T(&zi);
    emxFree_real_T(&r2);
    emxFree_real_T(&yc2);
    emxFree_real_T(&zo);
    emxFree_real_T(&yc3);
    emxFree_real_T(&b_xt);
    niccp = static_cast<int>(sz_idx_0);
    lb = static_cast<int>(sz_idx_1);
    i6 = xCol->size[0] * xCol->size[1];
    xCol->size[0] = niccp;
    xCol->size[1] = lb;
    emxEnsureCapacity_real_T(xCol, i6);
    for (i6 = 0; i6 < lb; i6++) {
      for (i7 = 0; i7 < niccp; i7++) {
        xCol->data[i7 + xCol->size[0] * i6] = xCol->data[i7 + niccp * i6];
      }
    }
  }

  p = (x->size[0] == 1);
  if (p) {
    i6 = y->size[0] * y->size[1];
    y->size[0] = xCol->size[1];
    y->size[1] = xCol->size[0];
    emxEnsureCapacity_real_T(y, i6);
    naxpy = xCol->size[0];
    for (i6 = 0; i6 < naxpy; i6++) {
      niccp = xCol->size[1];
      for (i7 = 0; i7 < niccp; i7++) {
        y->data[i7 + y->size[0] * i6] = xCol->data[i6 + xCol->size[0] * i7];
      }
    }
  } else {
    i6 = y->size[0] * y->size[1];
    y->size[0] = xCol->size[0];
    y->size[1] = xCol->size[1];
    emxEnsureCapacity_real_T(y, i6);
    naxpy = xCol->size[0] * xCol->size[1];
    for (i6 = 0; i6 < naxpy; i6++) {
      y->data[i6] = xCol->data[i6];
    }
  }

  emxFree_real_T(&xCol);
}

static void getCoeffsAndInitialConditions(double b1_data[], int b1_size[1],
  double a1_data[], int a1_size[1], double zi_data[], int zi_size[1], double *L)
{
  int cptr;
  double vals[16];
  static const double b[7] = { 0.00041654613908379267, -0.0,
    -0.0012496384172513779, -0.0, 0.0012496384172513779, -0.0,
    -0.00041654613908379267 };

  static const double a[7] = { 1.0, -5.6335176180845021, 13.279238200492731,
    -16.764967746430205, 11.95655977194809, -4.56747252965029,
    0.7301653453057223 };

  emxArray_real_T *y_d;
  double outBuff[6];
  emxArray_int32_T *y_colidx;
  emxArray_int32_T *y_rowidx;
  int sortedIndices[16];
  cell_wrap_5 this_tunableEnvironment[2];
  static const signed char b_a[16] = { 1, 1, 1, 1, 1, 1, 2, 3, 4, 5, 6, 2, 3, 4,
    5, 6 };

  static const signed char b_b[16] = { 1, 2, 3, 4, 5, 6, 2, 3, 4, 5, 6, 1, 2, 3,
    4, 5 };

  signed char cidxInt[16];
  signed char ridxInt[16];
  int c;
  int ridx;
  cs_di* cxA;
  cs_dis * S;
  double val;
  cs_din * N;
  int currRowIdx;
  *L = 1.0;
  b1_size[0] = 7;
  a1_size[0] = 7;
  for (cptr = 0; cptr < 7; cptr++) {
    b1_data[cptr] = b[cptr];
    a1_data[cptr] = a[cptr];
  }

  vals[0] = 1.0 + a1_data[1];
  for (cptr = 0; cptr < 5; cptr++) {
    vals[cptr + 1] = a1_data[2 + cptr];
    vals[cptr + 6] = 1.0;
    vals[cptr + 11] = -1.0;
  }

  for (cptr = 0; cptr < 6; cptr++) {
    outBuff[cptr] = b1_data[1 + cptr] - b1_data[0] * a1_data[1 + cptr];
  }

  emxInit_real_T(&y_d, 1);
  emxInit_int32_T(&y_colidx, 1);
  emxInit_int32_T(&y_rowidx, 1);
  for (cptr = 0; cptr < 16; cptr++) {
    sortedIndices[cptr] = cptr + 1;
    this_tunableEnvironment[0].f1[cptr] = b_a[cptr];
    this_tunableEnvironment[1].f1[cptr] = b_b[cptr];
  }

  introsort(sortedIndices, this_tunableEnvironment);
  for (cptr = 0; cptr < 16; cptr++) {
    cidxInt[cptr] = b_a[sortedIndices[cptr] - 1];
    ridxInt[cptr] = b_b[sortedIndices[cptr] - 1];
  }

  cptr = y_d->size[0];
  y_d->size[0] = 16;
  emxEnsureCapacity_real_T(y_d, cptr);
  for (cptr = 0; cptr < 16; cptr++) {
    y_d->data[cptr] = 0.0;
  }

  cptr = y_colidx->size[0];
  y_colidx->size[0] = 7;
  emxEnsureCapacity_int32_T(y_colidx, cptr);
  y_colidx->data[0] = 1;
  cptr = y_rowidx->size[0];
  y_rowidx->size[0] = 16;
  emxEnsureCapacity_int32_T(y_rowidx, cptr);
  for (cptr = 0; cptr < 16; cptr++) {
    y_rowidx->data[cptr] = 0;
  }

  cptr = 0;
  for (c = 0; c < 6; c++) {
    while ((cptr + 1 <= 16) && (cidxInt[cptr] == 1 + c)) {
      y_rowidx->data[cptr] = ridxInt[cptr];
      cptr++;
    }

    y_colidx->data[1 + c] = cptr + 1;
  }

  for (cptr = 0; cptr < 16; cptr++) {
    y_d->data[cptr] = vals[sortedIndices[cptr] - 1];
  }

  cptr = 1;
  for (c = 0; c < 6; c++) {
    ridx = y_colidx->data[c];
    y_colidx->data[c] = cptr;
    while (ridx < y_colidx->data[c + 1]) {
      val = 0.0;
      currRowIdx = y_rowidx->data[ridx - 1];
      while ((ridx < y_colidx->data[c + 1]) && (y_rowidx->data[ridx - 1] ==
              currRowIdx)) {
        val += y_d->data[ridx - 1];
        ridx++;
      }

      if (val != 0.0) {
        y_d->data[cptr - 1] = val;
        y_rowidx->data[cptr - 1] = currRowIdx;
        cptr++;
      }
    }
  }

  y_colidx->data[6] = cptr;
  cxA = makeCXSparseMatrix(y_colidx->data[6] - 1, 6, 6, &y_colidx->data[0],
    &y_rowidx->data[0], &y_d->data[0]);
  S = cs_di_sqr(2, cxA, 0);
  N = cs_di_lu(cxA, S, 1);
  cs_di_spfree(cxA);
  if (N == NULL) {
    cs_di_sfree(S);
    cs_di_nfree(N);
    cxA = makeCXSparseMatrix(y_colidx->data[6] - 1, 6, 6, &y_colidx->data[0],
      &y_rowidx->data[0], &y_d->data[0]);
    S = cs_di_sqr(2, cxA, 1);
    N = cs_di_qr(cxA, S);
    cs_di_spfree(cxA);
    qr_rank_di(N, &val);
    solve_from_qr_di(N, S, (double *)&outBuff[0], 6, 6);
    cs_di_sfree(S);
    cs_di_nfree(N);
  } else {
    solve_from_lu_di(N, S, (double *)&outBuff[0], 6);
    cs_di_sfree(S);
    cs_di_nfree(N);
  }

  emxFree_int32_T(&y_rowidx);
  emxFree_int32_T(&y_colidx);
  emxFree_real_T(&y_d);
  zi_size[0] = 6;
  for (cptr = 0; cptr < 6; cptr++) {
    zi_data[cptr] = outBuff[cptr];
  }
}

void filtfilt(const emxArray_real_T *x, emxArray_real_T *y)
{
  if (x->size[0] == 0) {
    y->size[0] = 0;
    y->size[1] = 0;
  } else {
    efiltfilt(x, y);
  }
}

/* End of code generation (filtfilt.cpp) */
