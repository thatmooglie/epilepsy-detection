/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * filter.cpp
 *
 * Code generation for function 'filter'
 *
 */

/* Include files */
#include <string.h>
#include "rt_nonfinite.h"
#include "pt.h"
#include "filter.h"
#include "pt_emxutil.h"

/* Function Definitions */
void b_filter(double b_data[], double a_data[], const double x[18], const double
              zi_data[], double y[18], double zf_data[], int zf_size[1])
{
  double a1;
  int k;
  int naxpy;
  int j;
  int y_tmp;
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  zf_size[0] = 6;
  for (k = 0; k < 6; k++) {
    zf_data[k] = 0.0;
    y[k] = zi_data[k];
  }

  memset(&y[6], 0, 12U * sizeof(double));
  for (k = 0; k < 18; k++) {
    if (18 - k < 7) {
      naxpy = 17 - k;
    } else {
      naxpy = 6;
    }

    for (j = 0; j <= naxpy; j++) {
      y_tmp = k + j;
      y[y_tmp] += x[k] * b_data[j];
    }

    if (17 - k < 6) {
      naxpy = 16 - k;
    } else {
      naxpy = 5;
    }

    a1 = -y[k];
    for (j = 0; j <= naxpy; j++) {
      y_tmp = (k + j) + 1;
      y[y_tmp] += a1 * a_data[j + 1];
    }
  }

  for (k = 0; k < 6; k++) {
    for (j = 0; j <= k; j++) {
      zf_data[j] += x[k + 12] * b_data[(j - k) + 6];
    }
  }

  for (k = 0; k < 6; k++) {
    for (j = 0; j <= k; j++) {
      zf_data[j] += -y[k + 12] * a_data[(j - k) + 6];
    }
  }
}

void c_filter(double b_data[], double a_data[], const double x[18], const double
              zi_data[], double y[18])
{
  double a1;
  int k;
  int naxpy;
  int j;
  int y_tmp;
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  for (k = 0; k < 6; k++) {
    y[k] = zi_data[k];
  }

  memset(&y[6], 0, 12U * sizeof(double));
  for (k = 0; k < 18; k++) {
    if (18 - k < 7) {
      naxpy = 17 - k;
    } else {
      naxpy = 6;
    }

    for (j = 0; j <= naxpy; j++) {
      y_tmp = k + j;
      y[y_tmp] += x[k] * b_data[j];
    }

    if (17 - k < 6) {
      naxpy = 16 - k;
    } else {
      naxpy = 5;
    }

    a1 = -y[k];
    for (j = 0; j <= naxpy; j++) {
      y_tmp = (k + j) + 1;
      y[y_tmp] += a1 * a_data[j + 1];
    }
  }
}

void d_filter(double b_data[], double a_data[], const emxArray_real_T *x, const
              emxArray_real_T *zi, emxArray_real_T *y, emxArray_real_T *zf)
{
  double a1;
  int k;
  int i9;
  unsigned int sx_idx_1;
  int nc_tmp;
  unsigned int size_zf_idx_1;
  int c;
  int b_c;
  double tmp_data[6];
  int tmp_size[1];
  double dv0[18];
  int naxpy;
  int j;
  int c_c;
  double zi_data[6];
  double b_b_data[7];
  double b_a_data[7];
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  i9 = y->size[0] * y->size[1];
  y->size[0] = 18;
  y->size[1] = x->size[1];
  emxEnsureCapacity_real_T(y, i9);
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  nc_tmp = static_cast<int>(sx_idx_1) - 1;
  size_zf_idx_1 = static_cast<unsigned int>(x->size[1]);
  i9 = zf->size[0] * zf->size[1];
  zf->size[0] = 6;
  zf->size[1] = static_cast<int>(size_zf_idx_1);
  emxEnsureCapacity_real_T(zf, i9);
  k = 6 * static_cast<int>(size_zf_idx_1);
  for (i9 = 0; i9 < k; i9++) {
    zf->data[i9] = 0.0;
  }

  if (static_cast<int>(sx_idx_1) >= 2) {

#pragma omp parallel for \
 num_threads(omp_get_max_threads()) \
 private(tmp_data,tmp_size,dv0,c_c,zi_data,b_b_data,b_a_data)

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (c_c = 0; c_c < 6; c_c++) {
        zi_data[c_c] = zi->data[c_c + 6 * b_c];
      }

      for (c_c = 0; c_c < 7; c_c++) {
        b_b_data[c_c] = b_data[c_c];
        b_a_data[c_c] = a_data[c_c];
      }

      b_filter(b_b_data, b_a_data, *(double (*)[18])&x->data[18 * b_c], zi_data,
               dv0, tmp_data, tmp_size);
      for (c_c = 0; c_c < 18; c_c++) {
        y->data[c_c + 18 * b_c] = dv0[c_c];
      }

      for (c_c = 0; c_c < 6; c_c++) {
        zf->data[c_c + 6 * b_c] = tmp_data[c_c];
      }
    }
  } else {
    for (c = 0; c <= nc_tmp; c++) {
      for (k = 0; k < 6; k++) {
        y->data[k] = zi->data[k];
      }

      for (k = 0; k < 12; k++) {
        y->data[k + 6] = 0.0;
      }
    }

    for (c = 0; c <= nc_tmp; c++) {
      for (k = 0; k < 18; k++) {
        if (18 - k < 7) {
          naxpy = 17 - k;
        } else {
          naxpy = 6;
        }

        for (j = 0; j <= naxpy; j++) {
          i9 = k + j;
          y->data[i9] += x->data[k] * b_data[j];
        }

        if (17 - k < 6) {
          naxpy = 16 - k;
        } else {
          naxpy = 5;
        }

        a1 = -y->data[k];
        for (j = 0; j <= naxpy; j++) {
          i9 = (k + j) + 1;
          y->data[i9] += a1 * a_data[j + 1];
        }
      }

      for (k = 0; k < 6; k++) {
        for (j = 0; j <= k; j++) {
          zf->data[j] += x->data[k + 12] * b_data[(j - k) + 6];
        }
      }

      for (k = 0; k < 6; k++) {
        for (j = 0; j <= k; j++) {
          zf->data[j] += -y->data[k + 12] * a_data[(j - k) + 6];
        }
      }
    }
  }
}

void e_filter(double b_data[], double a_data[], const emxArray_real_T *x, const
              emxArray_real_T *zi, emxArray_real_T *y, emxArray_real_T *zf)
{
  double a1;
  int k;
  unsigned int sx_idx_0;
  unsigned int sx_idx_1;
  int i10;
  int nx;
  int nc_tmp;
  int niccp;
  int c;
  emxArray_real_T *r3;
  int b_c;
  double tmp_data[6];
  int b_niccp;
  int naxpy;
  int lb;
  int j;
  int i11;
  double as;
  double b_b_data[7];
  double b_a_data[7];
  int b_k;
  int i12;
  int b_naxpy;
  int b_j;
  int b_lb;
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  sx_idx_0 = static_cast<unsigned int>(x->size[0]);
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  i10 = y->size[0] * y->size[1];
  y->size[0] = static_cast<int>(sx_idx_0);
  y->size[1] = static_cast<int>(sx_idx_1);
  emxEnsureCapacity_real_T(y, i10);
  nx = x->size[0];
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  nc_tmp = static_cast<int>(sx_idx_1) - 1;
  sx_idx_0 = static_cast<unsigned int>(x->size[1]);
  i10 = zf->size[0] * zf->size[1];
  zf->size[0] = 6;
  zf->size[1] = static_cast<int>(sx_idx_0);
  emxEnsureCapacity_real_T(zf, i10);
  niccp = 6 * static_cast<int>(sx_idx_0);
  for (i10 = 0; i10 < niccp; i10++) {
    zf->data[i10] = 0.0;
  }

  if (static_cast<int>(sx_idx_1) >= 2) {

#pragma omp parallel \
 num_threads(omp_get_max_threads()) \
 private(r3,tmp_data,b_niccp,i11,as,b_b_data,b_a_data,b_k,i12,b_naxpy,b_j,b_lb)

    {
      emxInit_real_T(&r3, 1);

#pragma omp for nowait

      for (c = 0; c <= nc_tmp; c++) {
        for (i11 = 0; i11 < 7; i11++) {
          b_b_data[i11] = b_data[i11];
          b_a_data[i11] = a_data[i11];
        }

        as = a_data[0];
        if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] ==
              0.0)) && (a_data[0] != 1.0)) {
          for (b_k = 0; b_k < 7; b_k++) {
            b_b_data[b_k] /= as;
          }

          for (b_k = 0; b_k < 6; b_k++) {
            b_a_data[b_k + 1] /= as;
          }

          b_a_data[0] = 1.0;
        }

        i11 = x->size[0];
        i12 = r3->size[0];
        r3->size[0] = i11;
        emxEnsureCapacity_real_T(r3, i12);
        i11 = x->size[0];
        for (i12 = 0; i12 < 6; i12++) {
          tmp_data[i12] = 0.0;
        }

        i12 = x->size[0];
        if (i12 < 6) {
          b_niccp = x->size[0] - 1;
        } else {
          b_niccp = 5;
        }

        for (b_k = 0; b_k <= b_niccp; b_k++) {
          r3->data[b_k] = zi->data[b_k + 6 * c];
        }

        for (b_k = b_niccp + 2; b_k <= i11; b_k++) {
          r3->data[b_k - 1] = 0.0;
        }

        for (b_k = 0; b_k < i11; b_k++) {
          b_niccp = i11 - b_k;
          if (b_niccp < 7) {
            b_naxpy = b_niccp;
          } else {
            b_naxpy = 7;
          }

          for (b_j = 0; b_j < b_naxpy; b_j++) {
            i12 = b_k + b_j;
            r3->data[i12] += x->data[b_k + x->size[0] * c] * b_b_data[b_j];
          }

          b_naxpy = b_niccp - 1;
          if (b_naxpy >= 6) {
            b_naxpy = 6;
          }

          as = -r3->data[b_k];
          for (b_j = 0; b_j < b_naxpy; b_j++) {
            i12 = (b_k + b_j) + 1;
            r3->data[i12] += as * b_a_data[b_j + 1];
          }
        }

        i12 = x->size[0];
        if (i12 < 6) {
          i12 = x->size[0];
          b_niccp = 5 - i12;
          for (b_k = 0; b_k <= b_niccp; b_k++) {
            tmp_data[b_k] = zi->data[(b_k + i11) + 6 * c];
          }
        }

        i12 = x->size[0];
        if (i12 >= 7) {
          b_lb = x->size[0] - 6;
        } else {
          b_lb = 0;
        }

        i12 = x->size[0];
        for (b_k = b_lb; b_k < i12; b_k++) {
          b_niccp = i11 - b_k;
          b_naxpy = 6 - b_niccp;
          for (b_j = 0; b_j <= b_naxpy; b_j++) {
            tmp_data[b_j] += x->data[b_k + x->size[0] * c] * b_b_data[b_niccp +
              b_j];
          }
        }

        i12 = x->size[0];
        if (i12 >= 7) {
          b_lb = x->size[0] - 6;
        } else {
          b_lb = 0;
        }

        i12 = x->size[0];
        for (b_k = b_lb; b_k < i12; b_k++) {
          b_niccp = i11 - b_k;
          b_naxpy = 6 - b_niccp;
          for (b_j = 0; b_j <= b_naxpy; b_j++) {
            tmp_data[b_j] += -r3->data[b_k] * b_a_data[b_niccp + b_j];
          }
        }

        b_niccp = r3->size[0];
        for (i11 = 0; i11 < b_niccp; i11++) {
          y->data[i11 + y->size[0] * c] = r3->data[i11];
        }

        for (i11 = 0; i11 < 6; i11++) {
          zf->data[i11 + 6 * c] = tmp_data[i11];
        }
      }

      emxFree_real_T(&r3);
    }
  } else {
    niccp = x->size[0];
    if (niccp >= 6) {
      niccp = 6;
    }

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (k = 0; k < niccp; k++) {
        y->data[k] = zi->data[k];
      }

      i10 = niccp + 1;
      for (k = i10; k <= nx; k++) {
        y->data[k - 1] = 0.0;
      }
    }

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (k = 0; k < nx; k++) {
        niccp = nx - k;
        if (niccp < 7) {
          naxpy = niccp;
        } else {
          naxpy = 7;
        }

        for (j = 0; j < naxpy; j++) {
          i10 = k + j;
          y->data[i10] += x->data[k] * b_data[j];
        }

        naxpy = niccp - 1;
        if (naxpy >= 6) {
          naxpy = 6;
        }

        a1 = -y->data[k];
        for (j = 0; j < naxpy; j++) {
          i10 = (k + j) + 1;
          y->data[i10] += a1 * a_data[j + 1];
        }
      }

      if (nx < 6) {
        niccp = 5 - nx;
        for (k = 0; k <= niccp; k++) {
          zf->data[k] = zi->data[k + nx];
        }
      }

      if (nx >= 7) {
        lb = nx - 6;
      } else {
        lb = 0;
      }

      i10 = nx - 1;
      for (k = lb; k <= i10; k++) {
        niccp = nx - k;
        naxpy = 6 - niccp;
        for (j = 0; j <= naxpy; j++) {
          zf->data[j] += x->data[k] * b_data[niccp + j];
        }
      }

      if (nx >= 7) {
        lb = nx - 6;
      } else {
        lb = 0;
      }

      i10 = nx - 1;
      for (k = lb; k <= i10; k++) {
        niccp = nx - k;
        naxpy = 6 - niccp;
        for (j = 0; j <= naxpy; j++) {
          zf->data[j] += -y->data[k] * a_data[niccp + j];
        }
      }
    }
  }
}

void f_filter(double b_data[], double a_data[], const emxArray_real_T *x, const
              emxArray_real_T *zi, emxArray_real_T *y)
{
  double a1;
  int k;
  int i13;
  unsigned int sx_idx_1;
  int nc_tmp;
  int c;
  int b_c;
  int c_c;
  int naxpy;
  int j;
  double zi_data[6];
  double b_b_data[7];
  double b_a_data[7];
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  i13 = y->size[0] * y->size[1];
  y->size[0] = 18;
  y->size[1] = x->size[1];
  emxEnsureCapacity_real_T(y, i13);
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  nc_tmp = static_cast<int>(sx_idx_1) - 1;
  if (static_cast<int>(sx_idx_1) >= 2) {

#pragma omp parallel for \
 num_threads(omp_get_max_threads()) \
 private(c_c,zi_data,b_b_data,b_a_data)

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (c_c = 0; c_c < 6; c_c++) {
        zi_data[c_c] = zi->data[c_c + 6 * b_c];
      }

      for (c_c = 0; c_c < 7; c_c++) {
        b_b_data[c_c] = b_data[c_c];
        b_a_data[c_c] = a_data[c_c];
      }

      c_filter(b_b_data, b_a_data, *(double (*)[18])&x->data[18 * b_c], zi_data,
               *(double (*)[18])&y->data[18 * b_c]);
    }
  } else {
    for (c = 0; c <= nc_tmp; c++) {
      for (k = 0; k < 6; k++) {
        y->data[k] = zi->data[k];
      }

      for (k = 0; k < 12; k++) {
        y->data[k + 6] = 0.0;
      }
    }

    for (c = 0; c <= nc_tmp; c++) {
      for (k = 0; k < 18; k++) {
        if (18 - k < 7) {
          naxpy = 17 - k;
        } else {
          naxpy = 6;
        }

        for (j = 0; j <= naxpy; j++) {
          i13 = k + j;
          y->data[i13] += x->data[k] * b_data[j];
        }

        if (17 - k < 6) {
          naxpy = 16 - k;
        } else {
          naxpy = 5;
        }

        a1 = -y->data[k];
        for (j = 0; j <= naxpy; j++) {
          i13 = (k + j) + 1;
          y->data[i13] += a1 * a_data[j + 1];
        }
      }
    }
  }
}

void filter(double b_data[], double a_data[], const emxArray_real_T *x, const
            double zi_data[], emxArray_real_T *y)
{
  double a1;
  int k;
  unsigned int x_idx_0;
  int niccp;
  int nx;
  int a_tmp;
  int naxpy;
  int j;
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  x_idx_0 = static_cast<unsigned int>(x->size[0]);
  niccp = y->size[0];
  y->size[0] = static_cast<int>(x_idx_0);
  emxEnsureCapacity_real_T(y, niccp);
  nx = x->size[0];
  if (x->size[0] < 6) {
    niccp = x->size[0] - 1;
  } else {
    niccp = 5;
  }

  for (k = 0; k <= niccp; k++) {
    y->data[k] = zi_data[k];
  }

  niccp += 2;
  for (k = niccp; k <= nx; k++) {
    y->data[k - 1] = 0.0;
  }

  for (k = 0; k < nx; k++) {
    a_tmp = nx - k;
    if (a_tmp < 7) {
      naxpy = a_tmp;
    } else {
      naxpy = 7;
    }

    for (j = 0; j < naxpy; j++) {
      niccp = k + j;
      y->data[niccp] += x->data[k] * b_data[j];
    }

    naxpy = a_tmp - 1;
    if (naxpy >= 6) {
      naxpy = 6;
    }

    a1 = -y->data[k];
    for (j = 0; j < naxpy; j++) {
      niccp = (k + j) + 1;
      y->data[niccp] += a1 * a_data[1 + j];
    }
  }
}

void g_filter(double b_data[], double a_data[], const emxArray_real_T *x, const
              emxArray_real_T *zi, emxArray_real_T *y)
{
  double a1;
  int k;
  unsigned int sx_idx_0;
  unsigned int sx_idx_1;
  int i14;
  int nx;
  int nc_tmp;
  int niccp;
  int c;
  emxArray_real_T *r4;
  int b_c;
  int b_niccp;
  int naxpy;
  int i15;
  int j;
  double as;
  double b_b_data[7];
  double b_a_data[7];
  int b_k;
  int a_tmp;
  int b_naxpy;
  int b_j;
  a1 = a_data[0];
  if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] == 0.0)) &&
      (a_data[0] != 1.0)) {
    for (k = 0; k < 7; k++) {
      b_data[k] /= a1;
    }

    for (k = 0; k < 6; k++) {
      a_data[k + 1] /= a1;
    }

    a_data[0] = 1.0;
  }

  sx_idx_0 = static_cast<unsigned int>(x->size[0]);
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  i14 = y->size[0] * y->size[1];
  y->size[0] = static_cast<int>(sx_idx_0);
  y->size[1] = static_cast<int>(sx_idx_1);
  emxEnsureCapacity_real_T(y, i14);
  nx = x->size[0];
  sx_idx_1 = static_cast<unsigned int>(x->size[1]);
  nc_tmp = static_cast<int>(sx_idx_1) - 1;
  if (static_cast<int>(sx_idx_1) >= 2) {

#pragma omp parallel \
 num_threads(omp_get_max_threads()) \
 private(r4,b_niccp,i15,as,b_b_data,b_a_data,b_k,a_tmp,b_naxpy,b_j)

    {
      emxInit_real_T(&r4, 1);

#pragma omp for nowait

      for (c = 0; c <= nc_tmp; c++) {
        for (i15 = 0; i15 < 7; i15++) {
          b_b_data[i15] = b_data[i15];
          b_a_data[i15] = a_data[i15];
        }

        as = a_data[0];
        if ((!rtIsInf(a_data[0])) && (!rtIsNaN(a_data[0])) && (!(a_data[0] ==
              0.0)) && (a_data[0] != 1.0)) {
          for (b_k = 0; b_k < 7; b_k++) {
            b_b_data[b_k] /= as;
          }

          for (b_k = 0; b_k < 6; b_k++) {
            b_a_data[b_k + 1] /= as;
          }

          b_a_data[0] = 1.0;
        }

        i15 = x->size[0];
        b_niccp = r4->size[0];
        r4->size[0] = i15;
        emxEnsureCapacity_real_T(r4, b_niccp);
        i15 = x->size[0];
        b_niccp = x->size[0];
        if (b_niccp < 6) {
          b_niccp = x->size[0] - 1;
        } else {
          b_niccp = 5;
        }

        for (b_k = 0; b_k <= b_niccp; b_k++) {
          r4->data[b_k] = zi->data[b_k + 6 * c];
        }

        for (b_k = b_niccp + 2; b_k <= i15; b_k++) {
          r4->data[b_k - 1] = 0.0;
        }

        for (b_k = 0; b_k < i15; b_k++) {
          a_tmp = i15 - b_k;
          if (a_tmp < 7) {
            b_naxpy = a_tmp;
          } else {
            b_naxpy = 7;
          }

          for (b_j = 0; b_j < b_naxpy; b_j++) {
            b_niccp = b_k + b_j;
            r4->data[b_niccp] += x->data[b_k + x->size[0] * c] * b_b_data[b_j];
          }

          b_naxpy = a_tmp - 1;
          if (b_naxpy >= 6) {
            b_naxpy = 6;
          }

          as = -r4->data[b_k];
          for (b_j = 0; b_j < b_naxpy; b_j++) {
            b_niccp = (b_k + b_j) + 1;
            r4->data[b_niccp] += as * b_a_data[b_j + 1];
          }
        }

        b_niccp = r4->size[0];
        for (i15 = 0; i15 < b_niccp; i15++) {
          y->data[i15 + y->size[0] * c] = r4->data[i15];
        }
      }

      emxFree_real_T(&r4);
    }
  } else {
    niccp = x->size[0];
    if (niccp >= 6) {
      niccp = 6;
    }

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (k = 0; k < niccp; k++) {
        y->data[k] = zi->data[k];
      }

      i14 = niccp + 1;
      for (k = i14; k <= nx; k++) {
        y->data[k - 1] = 0.0;
      }
    }

    for (b_c = 0; b_c <= nc_tmp; b_c++) {
      for (k = 0; k < nx; k++) {
        niccp = nx - k;
        if (niccp < 7) {
          naxpy = niccp;
        } else {
          naxpy = 7;
        }

        for (j = 0; j < naxpy; j++) {
          i14 = k + j;
          y->data[i14] += x->data[k] * b_data[j];
        }

        naxpy = niccp - 1;
        if (naxpy >= 6) {
          naxpy = 6;
        }

        a1 = -y->data[k];
        for (j = 0; j < naxpy; j++) {
          i14 = (k + j) + 1;
          y->data[i14] += a1 * a_data[j + 1];
        }
      }
    }
  }
}

/* End of code generation (filter.cpp) */
