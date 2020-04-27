/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sortIdx.cpp
 *
 * Code generation for function 'sortIdx'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "sortIdx.h"
#include "pt_emxutil.h"

/* Function Declarations */
static void merge(emxArray_int32_T *idx, emxArray_int32_T *x, int offset, int np,
                  int nq, emxArray_int32_T *iwork, emxArray_int32_T *xwork);
static void merge_block(emxArray_int32_T *idx, emxArray_int32_T *x, int offset,
  int n, int preSortLevel, emxArray_int32_T *iwork, emxArray_int32_T *xwork);

/* Function Definitions */
static void merge(emxArray_int32_T *idx, emxArray_int32_T *x, int offset, int np,
                  int nq, emxArray_int32_T *iwork, emxArray_int32_T *xwork)
{
  int n_tmp;
  int iout;
  int p;
  int i21;
  int q;
  int exitg1;
  if (nq != 0) {
    n_tmp = np + nq;
    for (iout = 0; iout < n_tmp; iout++) {
      i21 = offset + iout;
      iwork->data[iout] = idx->data[i21];
      xwork->data[iout] = x->data[i21];
    }

    p = 0;
    q = np;
    iout = offset - 1;
    do {
      exitg1 = 0;
      iout++;
      if (xwork->data[p] <= xwork->data[q]) {
        idx->data[iout] = iwork->data[p];
        x->data[iout] = xwork->data[p];
        if (p + 1 < np) {
          p++;
        } else {
          exitg1 = 1;
        }
      } else {
        idx->data[iout] = iwork->data[q];
        x->data[iout] = xwork->data[q];
        if (q + 1 < n_tmp) {
          q++;
        } else {
          q = iout - p;
          for (iout = p + 1; iout <= np; iout++) {
            i21 = q + iout;
            idx->data[i21] = iwork->data[iout - 1];
            x->data[i21] = xwork->data[iout - 1];
          }

          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
  }
}

static void merge_block(emxArray_int32_T *idx, emxArray_int32_T *x, int offset,
  int n, int preSortLevel, emxArray_int32_T *iwork, emxArray_int32_T *xwork)
{
  int nPairs;
  int bLen;
  int tailOffset;
  int nTail;
  nPairs = n >> preSortLevel;
  bLen = 1 << preSortLevel;
  while (nPairs > 1) {
    if ((nPairs & 1) != 0) {
      nPairs--;
      tailOffset = bLen * nPairs;
      nTail = n - tailOffset;
      if (nTail > bLen) {
        merge(idx, x, offset + tailOffset, bLen, nTail - bLen, iwork, xwork);
      }
    }

    tailOffset = bLen << 1;
    nPairs >>= 1;
    for (nTail = 0; nTail < nPairs; nTail++) {
      merge(idx, x, offset + nTail * tailOffset, bLen, bLen, iwork, xwork);
    }

    bLen = tailOffset;
  }

  if (n > bLen) {
    merge(idx, x, offset, bLen, n - bLen, iwork, xwork);
  }
}

void sortIdx(emxArray_int32_T *x, emxArray_int32_T *idx)
{
  int i1;
  int i20;
  int n;
  int b_n;
  int x4[4];
  int idx4[4];
  emxArray_int32_T *iwork;
  emxArray_int32_T *xwork;
  int nQuartets;
  int j;
  int i3;
  int i;
  int i2;
  int k;
  signed char perm[4];
  int offset;
  int bLen;
  int bLen2;
  int nPairs;
  int i4;
  int b_iwork[256];
  int b_xwork[256];
  int exitg1;
  i1 = x->size[0];
  i20 = idx->size[0];
  idx->size[0] = i1;
  emxEnsureCapacity_int32_T(idx, i20);
  for (i20 = 0; i20 < i1; i20++) {
    idx->data[i20] = 0;
  }

  if (x->size[0] != 0) {
    n = x->size[0];
    b_n = x->size[0];
    x4[0] = 0;
    idx4[0] = 0;
    x4[1] = 0;
    idx4[1] = 0;
    x4[2] = 0;
    idx4[2] = 0;
    x4[3] = 0;
    idx4[3] = 0;
    emxInit_int32_T(&iwork, 1);
    i20 = iwork->size[0];
    iwork->size[0] = i1;
    emxEnsureCapacity_int32_T(iwork, i20);
    for (i20 = 0; i20 < i1; i20++) {
      iwork->data[i20] = 0;
    }

    emxInit_int32_T(&xwork, 1);
    i1 = x->size[0];
    i20 = xwork->size[0];
    xwork->size[0] = i1;
    emxEnsureCapacity_int32_T(xwork, i20);
    for (i20 = 0; i20 < i1; i20++) {
      xwork->data[i20] = 0;
    }

    nQuartets = x->size[0] >> 2;
    for (j = 0; j < nQuartets; j++) {
      i = j << 2;
      idx4[0] = i + 1;
      idx4[1] = i + 2;
      idx4[2] = i + 3;
      idx4[3] = i + 4;
      x4[0] = x->data[i];
      x4[1] = x->data[i + 1];
      x4[2] = x->data[i + 2];
      x4[3] = x->data[i + 3];
      if (x->data[i] <= x->data[i + 1]) {
        i1 = 1;
        i2 = 2;
      } else {
        i1 = 2;
        i2 = 1;
      }

      if (x->data[i + 2] <= x->data[i + 3]) {
        i3 = 3;
        i4 = 4;
      } else {
        i3 = 4;
        i4 = 3;
      }

      i20 = x4[i1 - 1];
      offset = x4[i3 - 1];
      if (i20 <= offset) {
        i20 = x4[i2 - 1];
        if (i20 <= offset) {
          perm[0] = static_cast<signed char>(i1);
          perm[1] = static_cast<signed char>(i2);
          perm[2] = static_cast<signed char>(i3);
          perm[3] = static_cast<signed char>(i4);
        } else if (i20 <= x4[i4 - 1]) {
          perm[0] = static_cast<signed char>(i1);
          perm[1] = static_cast<signed char>(i3);
          perm[2] = static_cast<signed char>(i2);
          perm[3] = static_cast<signed char>(i4);
        } else {
          perm[0] = static_cast<signed char>(i1);
          perm[1] = static_cast<signed char>(i3);
          perm[2] = static_cast<signed char>(i4);
          perm[3] = static_cast<signed char>(i2);
        }
      } else {
        offset = x4[i4 - 1];
        if (i20 <= offset) {
          if (x4[i2 - 1] <= offset) {
            perm[0] = static_cast<signed char>(i3);
            perm[1] = static_cast<signed char>(i1);
            perm[2] = static_cast<signed char>(i2);
            perm[3] = static_cast<signed char>(i4);
          } else {
            perm[0] = static_cast<signed char>(i3);
            perm[1] = static_cast<signed char>(i1);
            perm[2] = static_cast<signed char>(i4);
            perm[3] = static_cast<signed char>(i2);
          }
        } else {
          perm[0] = static_cast<signed char>(i3);
          perm[1] = static_cast<signed char>(i4);
          perm[2] = static_cast<signed char>(i1);
          perm[3] = static_cast<signed char>(i2);
        }
      }

      i20 = perm[0] - 1;
      idx->data[i] = idx4[i20];
      offset = perm[1] - 1;
      idx->data[i + 1] = idx4[offset];
      i1 = perm[2] - 1;
      idx->data[i + 2] = idx4[i1];
      i2 = perm[3] - 1;
      idx->data[i + 3] = idx4[i2];
      x->data[i] = x4[i20];
      x->data[i + 1] = x4[offset];
      x->data[i + 2] = x4[i1];
      x->data[i + 3] = x4[i2];
    }

    i3 = nQuartets << 2;
    i2 = b_n - i3;
    if (i2 > 0) {
      for (k = 0; k < i2; k++) {
        i1 = i3 + k;
        idx4[k] = i1 + 1;
        x4[k] = x->data[i1];
      }

      perm[1] = 0;
      perm[2] = 0;
      perm[3] = 0;
      if (i2 == 1) {
        perm[0] = 1;
      } else if (i2 == 2) {
        if (x4[0] <= x4[1]) {
          perm[0] = 1;
          perm[1] = 2;
        } else {
          perm[0] = 2;
          perm[1] = 1;
        }
      } else if (x4[0] <= x4[1]) {
        if (x4[1] <= x4[2]) {
          perm[0] = 1;
          perm[1] = 2;
          perm[2] = 3;
        } else if (x4[0] <= x4[2]) {
          perm[0] = 1;
          perm[1] = 3;
          perm[2] = 2;
        } else {
          perm[0] = 3;
          perm[1] = 1;
          perm[2] = 2;
        }
      } else if (x4[0] <= x4[2]) {
        perm[0] = 2;
        perm[1] = 1;
        perm[2] = 3;
      } else if (x4[1] <= x4[2]) {
        perm[0] = 2;
        perm[1] = 3;
        perm[2] = 1;
      } else {
        perm[0] = 3;
        perm[1] = 2;
        perm[2] = 1;
      }

      for (k = 0; k < i2; k++) {
        i20 = i3 + k;
        idx->data[i20] = idx4[perm[k] - 1];
        x->data[i20] = x4[perm[k] - 1];
      }
    }

    i1 = 2;
    if (n > 1) {
      if (n >= 256) {
        nQuartets = n >> 8;
        for (i = 0; i < nQuartets; i++) {
          offset = i << 8;
          for (b_n = 0; b_n < 6; b_n++) {
            bLen = 1 << (b_n + 2);
            bLen2 = bLen << 1;
            nPairs = 256 >> (b_n + 3);
            for (k = 0; k < nPairs; k++) {
              i3 = offset + k * bLen2;
              for (j = 0; j < bLen2; j++) {
                i1 = i3 + j;
                b_iwork[j] = idx->data[i1];
                b_xwork[j] = x->data[i1];
              }

              i4 = 0;
              i2 = bLen;
              i1 = i3 - 1;
              do {
                exitg1 = 0;
                i1++;
                if (b_xwork[i4] <= b_xwork[i2]) {
                  idx->data[i1] = b_iwork[i4];
                  x->data[i1] = b_xwork[i4];
                  if (i4 + 1 < bLen) {
                    i4++;
                  } else {
                    exitg1 = 1;
                  }
                } else {
                  idx->data[i1] = b_iwork[i2];
                  x->data[i1] = b_xwork[i2];
                  if (i2 + 1 < bLen2) {
                    i2++;
                  } else {
                    i1 -= i4;
                    for (j = i4 + 1; j <= bLen; j++) {
                      i20 = i1 + j;
                      idx->data[i20] = b_iwork[j - 1];
                      x->data[i20] = b_xwork[j - 1];
                    }

                    exitg1 = 1;
                  }
                }
              } while (exitg1 == 0);
            }
          }
        }

        i1 = nQuartets << 8;
        i2 = n - i1;
        if (i2 > 0) {
          merge_block(idx, x, i1, i2, 2, iwork, xwork);
        }

        i1 = 8;
      }

      merge_block(idx, x, 0, n, i1, iwork, xwork);
    }

    emxFree_int32_T(&xwork);
    emxFree_int32_T(&iwork);
  }
}

/* End of code generation (sortIdx.cpp) */
