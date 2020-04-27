/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pt_terminate.cpp
 *
 * Code generation for function 'pt_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "pt_terminate.h"
#include "pt_data.h"

/* Function Definitions */
void pt_terminate()
{
  omp_destroy_nest_lock(&emlrtNestLockGlobal);
}

/* End of code generation (pt_terminate.cpp) */
