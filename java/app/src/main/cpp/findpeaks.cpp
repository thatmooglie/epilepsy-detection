/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * findpeaks.cpp
 *
 * Code generation for function 'findpeaks'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "findpeaks.h"
#include "pt_emxutil.h"
#include "sort1.h"
#include "eml_setop.h"

/* Function Declarations */
static void c_findPeaksSeparatedByMoreThanM(const emxArray_real_T *y, const
  emxArray_real_T *x, const emxArray_int32_T *iPk, double Pd, emxArray_int32_T
  *idx);

/* Function Definitions */
static void c_findPeaksSeparatedByMoreThanM(const emxArray_real_T *y, const
  emxArray_real_T *x, const emxArray_int32_T *iPk, double Pd, emxArray_int32_T
  *idx)
{
  emxArray_real_T *locs;
  emxArray_int32_T *b_y;
  int pEnd;
  int j;
  emxArray_int32_T *b_sortIdx;
  int n;
  unsigned int unnamed_idx_0;
  emxArray_int32_T *iwork;
  int k;
  double a;
  int i;
  int i2;
  emxArray_real_T *locs_temp;
  int p;
  int q;
  int qEnd;
  emxArray_boolean_T *idelete;
  int kEnd;
  emxArray_boolean_T *r5;
  double b_locs;
  emxArray_int32_T *r6;
  if (iPk->size[0] == 0) {
    emxInit_int32_T(&b_y, 2);
    b_y->size[0] = 1;
    b_y->size[1] = 0;
    pEnd = idx->size[0];
    idx->size[0] = b_y->size[1];
    emxEnsureCapacity_int32_T(idx, pEnd);
    j = b_y->size[1];
    for (pEnd = 0; pEnd < j; pEnd++) {
      idx->data[pEnd] = b_y->data[pEnd];
    }

    emxFree_int32_T(&b_y);
  } else {
    emxInit_real_T(&locs, 1);
    pEnd = locs->size[0];
    locs->size[0] = iPk->size[0];
    emxEnsureCapacity_real_T(locs, pEnd);
    j = iPk->size[0];
    for (pEnd = 0; pEnd < j; pEnd++) {
      locs->data[pEnd] = x->data[iPk->data[pEnd] - 1];
    }

    emxInit_int32_T(&b_sortIdx, 1);
    n = iPk->size[0] + 1;
    unnamed_idx_0 = static_cast<unsigned int>(iPk->size[0]);
    pEnd = b_sortIdx->size[0];
    b_sortIdx->size[0] = static_cast<int>(unnamed_idx_0);
    emxEnsureCapacity_int32_T(b_sortIdx, pEnd);
    j = static_cast<int>(unnamed_idx_0);
    for (pEnd = 0; pEnd < j; pEnd++) {
      b_sortIdx->data[pEnd] = 0;
    }

    emxInit_int32_T(&iwork, 1);
    pEnd = iwork->size[0];
    iwork->size[0] = static_cast<int>(unnamed_idx_0);
    emxEnsureCapacity_int32_T(iwork, pEnd);
    pEnd = iPk->size[0] - 1;
    for (k = 1; k <= pEnd; k += 2) {
      a = y->data[iPk->data[k - 1] - 1];
      if ((a >= y->data[iPk->data[k] - 1]) || rtIsNaN(a)) {
        b_sortIdx->data[k - 1] = k;
        b_sortIdx->data[k] = k + 1;
      } else {
        b_sortIdx->data[k - 1] = k + 1;
        b_sortIdx->data[k] = k;
      }
    }

    if ((iPk->size[0] & 1) != 0) {
      b_sortIdx->data[iPk->size[0] - 1] = iPk->size[0];
    }

    i = 2;
    while (i < n - 1) {
      i2 = i << 1;
      j = 1;
      for (pEnd = 1 + i; pEnd < n; pEnd = qEnd + i) {
        p = j;
        q = pEnd;
        qEnd = j + i2;
        if (qEnd > n) {
          qEnd = n;
        }

        k = 0;
        kEnd = qEnd - j;
        while (k + 1 <= kEnd) {
          a = y->data[iPk->data[b_sortIdx->data[p - 1] - 1] - 1];
          if ((a >= y->data[iPk->data[b_sortIdx->data[q - 1] - 1] - 1]) ||
              rtIsNaN(a)) {
            iwork->data[k] = b_sortIdx->data[p - 1];
            p++;
            if (p == pEnd) {
              while (q < qEnd) {
                k++;
                iwork->data[k] = b_sortIdx->data[q - 1];
                q++;
              }
            }
          } else {
            iwork->data[k] = b_sortIdx->data[q - 1];
            q++;
            if (q == qEnd) {
              while (p < pEnd) {
                k++;
                iwork->data[k] = b_sortIdx->data[p - 1];
                p++;
              }
            }
          }

          k++;
        }

        for (k = 0; k < kEnd; k++) {
          b_sortIdx->data[(j + k) - 1] = iwork->data[k];
        }

        j = qEnd;
      }

      i = i2;
    }

    emxFree_int32_T(&iwork);
    emxInit_real_T(&locs_temp, 1);
    pEnd = locs_temp->size[0];
    locs_temp->size[0] = b_sortIdx->size[0];
    emxEnsureCapacity_real_T(locs_temp, pEnd);
    j = b_sortIdx->size[0];
    for (pEnd = 0; pEnd < j; pEnd++) {
      locs_temp->data[pEnd] = locs->data[b_sortIdx->data[pEnd] - 1];
    }

    emxInit_boolean_T(&idelete, 1);
    unnamed_idx_0 = static_cast<unsigned int>(b_sortIdx->size[0]);
    pEnd = idelete->size[0];
    idelete->size[0] = static_cast<int>(unnamed_idx_0);
    emxEnsureCapacity_boolean_T(idelete, pEnd);
    j = static_cast<int>(unnamed_idx_0);
    for (pEnd = 0; pEnd < j; pEnd++) {
      idelete->data[pEnd] = false;
    }

    pEnd = b_sortIdx->size[0];
    emxInit_boolean_T(&r5, 1);
    for (i = 0; i < pEnd; i++) {
      if (!idelete->data[i]) {
        a = locs->data[b_sortIdx->data[i] - 1] - Pd;
        b_locs = locs->data[b_sortIdx->data[i] - 1] + Pd;
        i2 = r5->size[0];
        r5->size[0] = locs_temp->size[0];
        emxEnsureCapacity_boolean_T(r5, i2);
        j = locs_temp->size[0];
        for (i2 = 0; i2 < j; i2++) {
          r5->data[i2] = ((locs_temp->data[i2] >= a) && (locs_temp->data[i2] <=
            b_locs));
        }

        i2 = idelete->size[0];
        emxEnsureCapacity_boolean_T(idelete, i2);
        j = idelete->size[0];
        for (i2 = 0; i2 < j; i2++) {
          idelete->data[i2] = (idelete->data[i2] || r5->data[i2]);
        }

        idelete->data[i] = false;
      }
    }

    emxFree_boolean_T(&r5);
    emxFree_real_T(&locs_temp);
    emxFree_real_T(&locs);
    j = idelete->size[0] - 1;
    i2 = 0;
    for (i = 0; i <= j; i++) {
      if (!idelete->data[i]) {
        i2++;
      }
    }

    emxInit_int32_T(&r6, 1);
    pEnd = r6->size[0];
    r6->size[0] = i2;
    emxEnsureCapacity_int32_T(r6, pEnd);
    i2 = 0;
    for (i = 0; i <= j; i++) {
      if (!idelete->data[i]) {
        r6->data[i2] = i + 1;
        i2++;
      }
    }

    emxFree_boolean_T(&idelete);
    pEnd = idx->size[0];
    idx->size[0] = r6->size[0];
    emxEnsureCapacity_int32_T(idx, pEnd);
    j = r6->size[0];
    for (pEnd = 0; pEnd < j; pEnd++) {
      idx->data[pEnd] = b_sortIdx->data[r6->data[pEnd] - 1];
    }

    emxFree_int32_T(&r6);
    emxFree_int32_T(&b_sortIdx);
    sort(idx);
  }
}

void findpeaks(const emxArray_real_T *Yin, double varargin_2, emxArray_real_T
               *Ypk, emxArray_real_T *Xpk)
{
  emxArray_uint32_T *y;
  unsigned int Yin_idx_0;
  int kfirst;
  int ny;
  emxArray_real_T *x;
  emxArray_int32_T *idx;
  emxArray_int32_T *iFinite;
  emxArray_int32_T *iInfinite;
  int nPk;
  int nInf;
  char dir;
  double ykfirst;
  boolean_T isinfykfirst;
  int k;
  double yk;
  boolean_T isinfyk;
  emxArray_int32_T *iPk;
  char previousdir;
  emxArray_int32_T *c;
  emxInit_uint32_T(&y, 2);
  Yin_idx_0 = static_cast<unsigned int>(Yin->size[0]);
  kfirst = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = static_cast<int>(Yin_idx_0);
  emxEnsureCapacity_uint32_T(y, kfirst);
  ny = static_cast<int>(Yin_idx_0) - 1;
  for (kfirst = 0; kfirst <= ny; kfirst++) {
    y->data[kfirst] = 1U + kfirst;
  }

  emxInit_real_T(&x, 1);
  kfirst = x->size[0];
  x->size[0] = y->size[1];
  emxEnsureCapacity_real_T(x, kfirst);
  ny = y->size[1];
  for (kfirst = 0; kfirst < ny; kfirst++) {
    x->data[kfirst] = y->data[kfirst];
  }

  emxFree_uint32_T(&y);
  emxInit_int32_T(&idx, 1);
  emxInit_int32_T(&iFinite, 1);
  emxInit_int32_T(&iInfinite, 1);
  Yin_idx_0 = static_cast<unsigned int>(Yin->size[0]);
  kfirst = iFinite->size[0];
  iFinite->size[0] = static_cast<int>(Yin_idx_0);
  emxEnsureCapacity_int32_T(iFinite, kfirst);
  Yin_idx_0 = static_cast<unsigned int>(Yin->size[0]);
  kfirst = iInfinite->size[0];
  iInfinite->size[0] = static_cast<int>(Yin_idx_0);
  emxEnsureCapacity_int32_T(iInfinite, kfirst);
  ny = Yin->size[0];
  nPk = 0;
  nInf = 0;
  dir = 'n';
  kfirst = 0;
  ykfirst = rtInf;
  isinfykfirst = true;
  for (k = 1; k <= ny; k++) {
    yk = Yin->data[k - 1];
    if (rtIsNaN(Yin->data[k - 1])) {
      yk = rtInf;
      isinfyk = true;
    } else if (rtIsInf(Yin->data[k - 1]) && (Yin->data[k - 1] > 0.0)) {
      isinfyk = true;
      nInf++;
      iInfinite->data[nInf - 1] = k;
    } else {
      isinfyk = false;
    }

    if (yk != ykfirst) {
      previousdir = dir;
      if (isinfyk || isinfykfirst) {
        dir = 'n';
      } else if (yk < ykfirst) {
        dir = 'd';
        if (('d' != previousdir) && (previousdir == 'i')) {
          nPk++;
          iFinite->data[nPk - 1] = kfirst;
        }
      } else {
        dir = 'i';
      }

      ykfirst = yk;
      kfirst = k;
      isinfykfirst = isinfyk;
    }
  }

  if (1 > nPk) {
    kfirst = 0;
  } else {
    kfirst = nPk;
  }

  ny = iFinite->size[0];
  iFinite->size[0] = kfirst;
  emxEnsureCapacity_int32_T(iFinite, ny);
  emxInit_int32_T(&iPk, 1);
  ny = iInfinite->size[0];
  if (1 > nInf) {
    iInfinite->size[0] = 0;
  } else {
    iInfinite->size[0] = nInf;
  }

  emxEnsureCapacity_int32_T(iInfinite, ny);
  ny = iPk->size[0];
  iPk->size[0] = iFinite->size[0];
  emxEnsureCapacity_int32_T(iPk, ny);
  nPk = 0;
  for (k = 0; k < kfirst; k++) {
    ny = iFinite->data[k];
    if (Yin->data[ny - 1] > rtMinusInf) {
      if ((Yin->data[ny - 2] > Yin->data[ny]) || rtIsNaN(Yin->data[ny])) {
        ykfirst = Yin->data[ny - 2];
      } else {
        ykfirst = Yin->data[ny];
      }

      if (Yin->data[ny - 1] - ykfirst >= 0.0) {
        nPk++;
        iPk->data[nPk - 1] = iFinite->data[k];
      }
    }
  }

  emxInit_int32_T(&c, 1);
  kfirst = iPk->size[0];
  if (1 > nPk) {
    iPk->size[0] = 0;
  } else {
    iPk->size[0] = nPk;
  }

  emxEnsureCapacity_int32_T(iPk, kfirst);
  do_vectors(iPk, iInfinite, c, idx, iFinite);
  c_findPeaksSeparatedByMoreThanM(Yin, x, c, varargin_2, idx);
  emxFree_int32_T(&iInfinite);
  emxFree_int32_T(&iFinite);
  if (idx->size[0] > Yin->size[0]) {
    kfirst = idx->size[0];
    idx->size[0] = Yin->size[0];
    emxEnsureCapacity_int32_T(idx, kfirst);
  }

  kfirst = iPk->size[0];
  iPk->size[0] = idx->size[0];
  emxEnsureCapacity_int32_T(iPk, kfirst);
  ny = idx->size[0];
  for (kfirst = 0; kfirst < ny; kfirst++) {
    iPk->data[kfirst] = c->data[idx->data[kfirst] - 1];
  }

  emxFree_int32_T(&c);
  emxFree_int32_T(&idx);
  kfirst = Ypk->size[0];
  Ypk->size[0] = iPk->size[0];
  emxEnsureCapacity_real_T(Ypk, kfirst);
  ny = iPk->size[0];
  for (kfirst = 0; kfirst < ny; kfirst++) {
    Ypk->data[kfirst] = Yin->data[iPk->data[kfirst] - 1];
  }

  kfirst = Xpk->size[0];
  Xpk->size[0] = iPk->size[0];
  emxEnsureCapacity_real_T(Xpk, kfirst);
  ny = iPk->size[0];
  for (kfirst = 0; kfirst < ny; kfirst++) {
    Xpk->data[kfirst] = x->data[iPk->data[kfirst] - 1];
  }

  emxFree_real_T(&x);
  emxFree_int32_T(&iPk);
}

/* End of code generation (findpeaks.cpp) */
