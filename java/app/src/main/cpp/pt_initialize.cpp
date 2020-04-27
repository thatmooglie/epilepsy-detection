/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pt_initialize.cpp
 *
 * Code generation for function 'pt_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "pt_initialize.h"
#include "pt_data.h"

/* Function Definitions */
void pt_initialize()
{
  rt_InitInfAndNaN(8U);
  omp_init_nest_lock(&emlrtNestLockGlobal);
}

/* End of code generation (pt_initialize.cpp) */
