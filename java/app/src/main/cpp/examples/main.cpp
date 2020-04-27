/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.cpp
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "main.h"
#include "pt_terminate.h"
#include "pt_emxAPI.h"
#include "pt_initialize.h"

/* Function Declarations */
static emxArray_real_T *argInit_1xUnbounded_real_T();
static signed char argInit_int8_T();
static double argInit_real_T();
static void main_pt();

/* Function Definitions */
static emxArray_real_T *argInit_1xUnbounded_real_T()
{
  emxArray_real_T *result;
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreate_real_T(1, 2);

  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < result->size[1U]; idx1++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx1] = argInit_real_T();
  }

  return result;
}

static signed char argInit_int8_T()
{
  return 0;
}

static double argInit_real_T()
{
  return 0.0;
}

static void main_pt()
{
  emxArray_real_T *qrs_amp_raw;
  emxArray_real_T *qrs_i_raw;
  emxArray_real_T *ecg;
  double delay;
  emxInitArray_real_T(&qrs_amp_raw, 2);
  emxInitArray_real_T(&qrs_i_raw, 2);

  /* Initialize function 'pt' input arguments. */
  /* Initialize function input argument 'ecg'. */
  ecg = argInit_1xUnbounded_real_T();

  /* Call the entry-point 'pt'. */
  pt(ecg, argInit_real_T(), argInit_int8_T(), qrs_amp_raw, qrs_i_raw, &delay);
  emxDestroyArray_real_T(qrs_i_raw);
  emxDestroyArray_real_T(qrs_amp_raw);
  emxDestroyArray_real_T(ecg);
}

int main(int, const char * const [])
{
  /* Initialize the application.
     You do not need to do this more than one time. */
  pt_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_pt();

  /* Terminate the application.
     You do not need to do this more than one time. */
  pt_terminate();
  return 0;
}

/* End of code generation (main.cpp) */
