/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * filter.h
 *
 * Code generation for function 'filter'
 *
 */

#ifndef FILTER_H
#define FILTER_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "pt_types.h"

/* Function Declarations */
extern void b_filter(double b_data[], double a_data[], const double x[18], const
                     double zi_data[], double y[18], double zf_data[], int
                     zf_size[1]);
extern void c_filter(double b_data[], double a_data[], const double x[18], const
                     double zi_data[], double y[18]);
extern void d_filter(double b_data[], double a_data[], const emxArray_real_T *x,
                     const emxArray_real_T *zi, emxArray_real_T *y,
                     emxArray_real_T *zf);
extern void e_filter(double b_data[], double a_data[], const emxArray_real_T *x,
                     const emxArray_real_T *zi, emxArray_real_T *y,
                     emxArray_real_T *zf);
extern void f_filter(double b_data[], double a_data[], const emxArray_real_T *x,
                     const emxArray_real_T *zi, emxArray_real_T *y);
extern void filter(double b_data[], double a_data[], const emxArray_real_T *x,
                   const double zi_data[], emxArray_real_T *y);
extern void g_filter(double b_data[], double a_data[], const emxArray_real_T *x,
                     const emxArray_real_T *zi, emxArray_real_T *y);

#endif

/* End of code generation (filter.h) */
