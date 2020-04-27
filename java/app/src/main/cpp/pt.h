/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pt.h
 *
 * Code generation for function 'pt'
 *
 */

#ifndef PT_H
#define PT_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "pt_types.h"

/* Function Declarations */
extern void pt(const emxArray_real_T *ecg, double fs, signed char gr,
               emxArray_real_T *qrs_amp_raw, emxArray_real_T *qrs_i_raw, double *
               delay);

#endif

/* End of code generation (pt.h) */
