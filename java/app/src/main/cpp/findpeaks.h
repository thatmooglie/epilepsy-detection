/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * findpeaks.h
 *
 * Code generation for function 'findpeaks'
 *
 */

#ifndef FINDPEAKS_H
#define FINDPEAKS_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "pt_types.h"

/* Function Declarations */
extern void findpeaks(const emxArray_real_T *Yin, double varargin_2,
                      emxArray_real_T *Ypk, emxArray_real_T *Xpk);

#endif

/* End of code generation (findpeaks.h) */
