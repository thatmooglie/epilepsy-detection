/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * conv.h
 *
 * Code generation for function 'conv'
 *
 */

#ifndef CONV_H
#define CONV_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "pt_types.h"

/* Function Declarations */
extern void b_conv(const emxArray_real_T *A, emxArray_real_T *C);
extern void c_conv(const emxArray_real_T *A, emxArray_real_T *C);
extern void conv(const emxArray_real_T *A, emxArray_real_T *C);
extern void d_conv(const emxArray_real_T *A, const double B_data[], const int
                   B_size[2], emxArray_real_T *C);

#endif

/* End of code generation (conv.h) */
