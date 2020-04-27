/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_pt_api.h
 *
 * Code generation for function '_coder_pt_api'
 *
 */

#ifndef _CODER_PT_API_H
#define _CODER_PT_API_H

/* Include files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_pt_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void pt(emxArray_real_T *ecg, real_T fs, int8_T gr, emxArray_real_T
               *qrs_amp_raw, emxArray_real_T *qrs_i_raw, real_T *delay);
extern void pt_api(const mxArray * const prhs[3], int32_T nlhs, const mxArray
                   *plhs[3]);
extern void pt_atexit(void);
extern void pt_initialize(void);
extern void pt_terminate(void);
extern void pt_xil_shutdown(void);
extern void pt_xil_terminate(void);

#endif

/* End of code generation (_coder_pt_api.h) */
