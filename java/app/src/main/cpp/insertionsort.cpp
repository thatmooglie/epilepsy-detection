/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * insertionsort.cpp
 *
 * Code generation for function 'insertionsort'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pt.h"
#include "insertionsort.h"

/* Function Definitions */
void insertionsort(int x[16], const cell_wrap_5 cmp_tunableEnvironment[2])
{
  int k;
  int xc;
  int idx;
  boolean_T exitg1;
  int i18;
  for (k = 0; k < 15; k++) {
    xc = x[k + 1] - 1;
    idx = k;
    exitg1 = false;
    while ((!exitg1) && (idx + 1 >= 1)) {
      i18 = cmp_tunableEnvironment[0].f1[x[idx] - 1];
      if ((cmp_tunableEnvironment[0].f1[xc] < i18) || ((cmp_tunableEnvironment[0]
            .f1[xc] == i18) && (cmp_tunableEnvironment[1].f1[xc] <
            cmp_tunableEnvironment[1].f1[x[idx] - 1]))) {
        x[idx + 1] = x[idx];
        idx--;
      } else {
        exitg1 = true;
      }
    }

    x[idx + 1] = xc + 1;
  }
}

/* End of code generation (insertionsort.cpp) */
