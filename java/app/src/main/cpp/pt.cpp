/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * pt.cpp
 *
 * Code generation for function 'pt'
 *
 */

/* Include files */
#include <cmath>
#include "rt_nonfinite.h"
#include "pt.h"
#include "pt_emxutil.h"
#include "mean.h"
#include "diff.h"
#include "findpeaks.h"
#include "conv.h"
#include "power.h"
#include "abs.h"
#include "mrdivide_helper.h"
#include "filtfilt.h"

/* Function Declarations */
static double rt_roundd_snf(double u);

/* Function Definitions */
static double rt_roundd_snf(double u)
{
  double y;
  if (std::abs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = std::floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = std::ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

void pt(const emxArray_real_T *ecg, double fs, signed char, emxArray_real_T
        *qrs_amp_raw, emxArray_real_T *qrs_i_raw, double *delay)
{
  emxArray_real_T *qrs_c;
  emxArray_real_T *qrs_i;
  int b_delay;
  int skip;
  double m_selected_RR;
  double mean_RR;
  int ser_back;
  emxArray_real_T *ecg_l;
  emxArray_real_T *ecg_h;
  emxArray_real_T *maxval;
  emxArray_real_T *varargin_1;
  emxArray_real_T *b_ecg_h;
  emxArray_real_T *b_varargin_1;
  int x_i_t;
  emxArray_real_T b_ecg;
  int c_ecg[1];
  int n;
  int m;
  int k;
  int d_ecg[1];
  boolean_T exitg1;
  double test_m;
  int i0;
  int loop_ub;
  unsigned int unnamed_idx_1;
  int i;
  double comp;
  emxArray_real_T *r0;
  double x_tmp_tmp;
  int tmp_size[2];
  emxArray_real_T *locs;
  double tmp_data[60];
  double THR_SIG;
  int ecg_l_size[1];
  emxArray_real_T ecg_l_data;
  double b_ecg_l_data[800];
  double THR_NOISE;
  double SIG_LEV;
  double NOISE_LEV;
  double THR_SIG1;
  emxArray_real_T c_ecg_l_data;
  double THR_NOISE1;
  double SIG_LEV1;
  double NOISE_LEV1;
  int x_i;
  double y_i;
  emxArray_real_T *r1;
  emxArray_real_T *b_ecg_l;
  double d0;
  int i1;
  int i2;
  double diffRR[8];
  int exitg2;
  int i3;
  double locs_temp;
  emxInit_real_T(&qrs_c, 2);
  emxInit_real_T(&qrs_i, 2);

  /*  This is a modified form of PAN_TOMPKIN.M (from FileExchange) for ML Coder */
  /*  function [qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(ecg,fs) */
  /*  Complete implementation of Pan-Tompkins algorithm */
  /*  Inputs */
  /*  ecg : raw ecg vector signal 1d signal */
  /*  fs : sampling frequency e.g. 200Hz, 400Hz and etc */
  /*  gr : flag to plot or not plot (set it 1 to have a plot or set it zero not */
  /*  to see any plots */
  /*  Outputs */
  /*  qrs_amp_raw : amplitude of R waves amplitudes */
  /*  qrs_i_raw : index of R waves */
  /*  delay : number of samples which the signal is delayed due to the */
  /*  filtering */
  /*  Method : */
  /*  PreProcessing */
  /*  1) Signal is preprocessed , if the sampling frequency is higher then it is downsampled */
  /*  and if it is lower upsampled to make the sampling frequency 200 Hz */
  /*  with the same filtering setups introduced in Pan */
  /*  tompkins paper (a combination of low pass and high pass filter 5-15 Hz) */
  /*  to get rid of the baseline wander and muscle noise.  */
  /*  2) The filtered signal */
  /*  is derivated using a derivating filter to high light the QRS complex. */
  /*  3) Signal is squared.4)Signal is averaged with a moving window to get rid */
  /*  of noise (0.150 seconds length). */
  /*  5) depending on the sampling frequency of your signal the filtering */
  /*  options are changed to best match the characteristics of your ecg signal */
  /*  6) Unlike the other implementations in this implementation the desicion */
  /*  rule of the Pan tompkins is implemented completely. */
  /*  Decision Rule  */
  /*  At this point in the algorithm, the preceding stages have produced a roughly pulse-shaped */
  /*  waveform at the output of the MWI . The determination as to whether this pulse */
  /*  corresponds to a QRS complex (as opposed to a high-sloped T-wave or a noise artefact) is */
  /*  performed with an adaptive thresholding operation and other decision */
  /*  rules outlined below; */
  /*  a) FIDUCIAL MARK - The waveform is first processed to produce a set of weighted unit */
  /*  samples at the location of the MWI maxima. This is done in order to localize the QRS */
  /*  complex to a single instant of time. The w[k] weighting is the maxima value. */
  /*  b) THRESHOLDING - When analyzing the amplitude of the MWI output, the algorithm uses */
  /*  two threshold values (THR_SIG and THR_NOISE, appropriately initialized during a brief */
  /*  2 second training phase) that continuously adapt to changing ECG signal quality. The */
  /*  first pass through y[n] uses these thresholds to classify the each non-zero sample */
  /*  (CURRENTPEAK) as either signal or noise: */
  /*  If CURRENTPEAK > THR_SIG, that location is identified as a &#xFFFD;QRS complex */
  /*  candidate&#xFFFD; and the signal level (SIG_LEV) is updated: */
  /*  SIG _ LEV = 0.125 &#xFFFD;CURRENTPEAK + 0.875&#xFFFD; SIG _ LEV */
  /*  If THR_NOISE < CURRENTPEAK < THR_SIG, then that location is identified as a */
  /*  &#xFFFD;noise peak&#xFFFD; and the noise level (NOISE_LEV) is updated: */
  /*  NOISE _ LEV = 0.125&#xFFFD;CURRENTPEAK + 0.875&#xFFFD; NOISE _ LEV */
  /*  Based on new estimates of the signal and noise levels (SIG_LEV and NOISE_LEV, */
  /*  respectively) at that point in the ECG, the thresholds are adjusted as follows: */
  /*  THR _ SIG = NOISE _ LEV + 0.25 &#xFFFD; (SIG _ LEV ? NOISE _ LEV ) */
  /*  THR _ NOISE = 0.5&#xFFFD; (THR _ SIG) */
  /*  These adjustments lower the threshold gradually in signal segments that are deemed to */
  /*  be of poorer quality. */
  /*  c) SEARCHBACK FOR MISSED QRS COMPLEXES - In the thresholding step above, if */
  /*  CURRENTPEAK < THR_SIG, the peak is deemed not to have resulted from a QRS */
  /*  complex. If however, an unreasonably long period has expired without an abovethreshold */
  /*  peak, the algorithm will assume a QRS has been missed and perform a */
  /*  searchback. This limits the number of false negatives. The minimum time used to trigger */
  /*  a searchback is 1.66 times the current R peak to R peak time period (called the RR */
  /*  interval). This value has a physiological origin - the time value between adjacent */
  /*  heartbeats cannot change more quickly than this. The missed QRS complex is assumed */
  /*  to occur at the location of the highest peak in the interval that lies between THR_SIG and */
  /*  THR_NOISE. In this algorithm, two average RR intervals are stored,the first RR interval is  */
  /*  calculated as an average of the last eight QRS locations in order to adapt to changing heart  */
  /*  rate and the second RR interval mean is the mean  */
  /*  of the most regular RR intervals . The threshold is lowered if the heart rate is not regular  */
  /*  to improve detection. */
  /*  d) ELIMINATION OF MULTIPLE DETECTIONS WITHIN REFRACTORY PERIOD - It is */
  /*  impossible for a legitimate QRS complex to occur if it lies within 200ms after a previously */
  /*  detected one. This constraint is a physiological one &#xFFFD; due to the refractory period during */
  /*  which ventricular depolarization cannot occur despite a stimulus[1]. As QRS complex */
  /*  candidates are generated, the algorithm eliminates such physically impossible events, */
  /*  thereby reducing false positives. */
  /*  e) T WAVE DISCRIMINATION - Finally, if a QRS candidate occurs after the 200ms */
  /*  refractory period but within 360ms of the previous QRS, the algorithm determines */
  /*  whether this is a genuine QRS complex of the next heartbeat or an abnormally prominent */
  /*  T wave. This decision is based on the mean slope of the waveform at that position. A slope of */
  /*  less than one half that of the previous QRS complex is consistent with the slower */
  /*  changing behaviour of a T wave &#xFFFD; otherwise, it becomes a QRS detection. */
  /*  Extra concept : beside the points mentioned in the paper, this code also */
  /*  checks if the occured peak which is less than 360 msec latency has also a */
  /*  latency less than 0,5*mean_RR if yes this is counted as noise */
  /*  f) In the final stage , the output of R waves detected in smoothed signal is analyzed and double */
  /*  checked with the help of the output of the bandpass signal to improve */
  /*  detection and find the original index of the real R waves on the raw ecg */
  /*  signal */
  /*  References : */
  /* [1]PAN.J, TOMPKINS. W.J,"A Real-Time QRS Detection Algorithm" IEEE */
  /* TRANSACTIONS ON BIOMEDICAL ENGINEERING, VOL. BME-32, NO. 3, MARCH 1985. */
  /*  Author : Hooman Sedghamiz */
  /*  Linkoping university  */
  /*  email : hoose792@student.liu.se */
  /*  hooman.sedghamiz@medel.com */
  /*  Any direct or indirect use of this code should be referenced  */
  /*  Copyright march 2014 */
  /*  */
  /*  vectorize */
  /*  Initialize */
  qrs_c->size[0] = 1;
  qrs_c->size[1] = 0;

  /* amplitude of R % TMW add, was qrs_c = []; */
  qrs_i->size[0] = 1;
  qrs_i->size[1] = 0;

  /* amplitude of R % TMW add, was qrs_i = []; */
  /*  TMW add */
  b_delay = 0;
  skip = 0;

  /*  becomes one when a T wave is detected */
  /*  it is not noise when not_nois = 1 */
  /*  Selected RR intervals */
  m_selected_RR = 0.0;
  mean_RR = 0.0;
  qrs_i_raw->size[0] = 1;
  qrs_i_raw->size[1] = 0;
  qrs_amp_raw->size[0] = 1;
  qrs_amp_raw->size[1] = 0;
  ser_back = 0;

  /*  Plot differently based on filtering settings */
  /*  Noise cancelation(Filtering) % Filters (Filter in between 5-15 Hz) */
  emxInit_real_T(&ecg_l, 1);
  emxInit_real_T(&ecg_h, 1);
  emxInit_real_T(&maxval, 2);
  emxInit_real_T(&varargin_1, 1);
  if (fs == 200.0) {
    /*  Low Pass Filter  H(z) = ((1 - z^(-6))^2)/(1 - z^(-1))^2 */
    x_i_t = ecg->size[1];
    b_ecg = *ecg;
    c_ecg[0] = x_i_t;
    b_ecg.size = &c_ecg[0];
    b_ecg.numDimensions = 1;
    conv(&b_ecg, ecg_l);
    b_abs(ecg_l, varargin_1);
    n = varargin_1->size[0];
    if (!rtIsNaN(varargin_1->data[0])) {
      m = 1;
    } else {
      m = 0;
      k = 2;
      exitg1 = false;
      while ((!exitg1) && (k <= varargin_1->size[0])) {
        if (!rtIsNaN(varargin_1->data[k - 1])) {
          m = k;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (m == 0) {
      test_m = varargin_1->data[0];
    } else {
      test_m = varargin_1->data[m - 1];
      i0 = m + 1;
      for (k = i0; k <= n; k++) {
        if (test_m < varargin_1->data[k - 1]) {
          test_m = varargin_1->data[k - 1];
        }
      }
    }

    i0 = ecg_l->size[0];
    emxEnsureCapacity_real_T(ecg_l, i0);
    loop_ub = ecg_l->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      ecg_l->data[i0] /= test_m;
    }

    /* based on the paper */
    /*  High Pass filter H(z) = (-1+32z^(-16)+z^(-32))/(1+z^(-1)) */
    b_conv(ecg_l, ecg_h);
    b_abs(ecg_h, varargin_1);
    n = varargin_1->size[0];
    if (!rtIsNaN(varargin_1->data[0])) {
      m = 1;
    } else {
      m = 0;
      k = 2;
      exitg1 = false;
      while ((!exitg1) && (k <= varargin_1->size[0])) {
        if (!rtIsNaN(varargin_1->data[k - 1])) {
          m = k;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (m == 0) {
      test_m = varargin_1->data[0];
    } else {
      test_m = varargin_1->data[m - 1];
      i0 = m + 1;
      for (k = i0; k <= n; k++) {
        if (test_m < varargin_1->data[k - 1]) {
          test_m = varargin_1->data[k - 1];
        }
      }
    }

    i0 = ecg_h->size[0];
    emxEnsureCapacity_real_T(ecg_h, i0);
    loop_ub = ecg_h->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      ecg_h->data[i0] /= test_m;
    }

    b_delay = 22;

    /*  16 samples for highpass filtering */
  } else {
    emxInit_real_T(&b_ecg_h, 2);
    emxInit_real_T(&b_varargin_1, 2);

    /*     %% bandpass filter for Noise cancelation of other sampling frequencies(Filtering) */
    fs = 400.0;

    /*  TMW add: butter's inputs must be constants */
    /* cuttoff low frequency to get rid of baseline wander */
    /* cuttoff frequency to discard high frequency noise */
    /*  cutt off based on fs */
    /*  order of 3 less processing */
    /* bandpass filtering */
    x_i_t = ecg->size[1];
    b_ecg = *ecg;
    d_ecg[0] = x_i_t;
    b_ecg.size = &d_ecg[0];
    b_ecg.numDimensions = 1;
    filtfilt(&b_ecg, b_ecg_h);
    c_abs(b_ecg_h, b_varargin_1);
    m = b_varargin_1->size[0];
    n = b_varargin_1->size[1];
    unnamed_idx_1 = static_cast<unsigned int>(b_varargin_1->size[1]);
    i0 = maxval->size[0] * maxval->size[1];
    maxval->size[0] = 1;
    maxval->size[1] = static_cast<int>(unnamed_idx_1);
    emxEnsureCapacity_real_T(maxval, i0);
    if (b_varargin_1->size[1] >= 1) {
      for (x_i_t = 0; x_i_t < n; x_i_t++) {
        maxval->data[x_i_t] = b_varargin_1->data[b_varargin_1->size[0] * x_i_t];
        for (i = 2; i <= m; i++) {
          comp = maxval->data[x_i_t];
          test_m = b_varargin_1->data[(i + b_varargin_1->size[0] * x_i_t) - 1];
          if ((!rtIsNaN(test_m)) && (rtIsNaN(comp) || (comp < test_m))) {
            maxval->data[x_i_t] = b_varargin_1->data[(i + b_varargin_1->size[0] *
              x_i_t) - 1];
          }
        }
      }
    }

    emxFree_real_T(&b_varargin_1);
    mrdivide_helper(b_ecg_h, maxval, ecg_h);
    emxFree_real_T(&b_ecg_h);
  }

  /*  derivative filter H(z) = (1/8T)(-z^(-2) - 2z^(-1) + 2z + z^(2)) */
  /* 1/8*fs */
  c_conv(ecg_h, ecg_l);
  n = ecg_l->size[0];
  if (!rtIsNaN(ecg_l->data[0])) {
    m = 1;
  } else {
    m = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k <= ecg_l->size[0])) {
      if (!rtIsNaN(ecg_l->data[k - 1])) {
        m = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (m == 0) {
    test_m = ecg_l->data[0];
  } else {
    test_m = ecg_l->data[m - 1];
    i0 = m + 1;
    for (k = i0; k <= n; k++) {
      if (test_m < ecg_l->data[k - 1]) {
        test_m = ecg_l->data[k - 1];
      }
    }
  }

  i0 = ecg_l->size[0];
  emxEnsureCapacity_real_T(ecg_l, i0);
  loop_ub = ecg_l->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ecg_l->data[i0] /= test_m;
  }

  emxInit_real_T(&r0, 1);
  b_delay += 2;

  /*  delay of derivative filter 2 samples */
  /*  Squaring nonlinearly enhance the dominant peaks */
  /*  Moving average Y(nt) = (1/N)[x(nT-(N - 1)T)+ x(nT - (N - 2)T)+...+x(nT)] */
  x_tmp_tmp = rt_roundd_snf(0.15 * fs);
  x_i_t = static_cast<int>(x_tmp_tmp);
  power(ecg_l, r0);
  tmp_size[0] = 1;
  tmp_size[1] = static_cast<int>(x_tmp_tmp);
  for (i0 = 0; i0 < x_i_t; i0++) {
    tmp_data[i0] = 1.0 / static_cast<double>(static_cast<int>(x_tmp_tmp));
  }

  emxInit_real_T(&locs, 1);
  d_conv(r0, tmp_data, tmp_size, ecg_l);
  b_delay += 15;

  /*  Fiducial Mark  */
  /*  Note : a minimum distance of 40 samples is considered between each R wave */
  /*  since in physiological point of view no RR wave can occur in less than */
  /*  200 msec distance */
  findpeaks(ecg_l, rt_roundd_snf(0.2 * fs), varargin_1, locs);

  /*  initialize the training phase (2 seconds of the signal) to determine the THR_SIG and THR_NOISE */
  loop_ub = static_cast<int>(fs) << 1;
  n = static_cast<int>(fs) << 1;
  if (!rtIsNaN(ecg_l->data[0])) {
    m = 1;
  } else {
    m = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k <= loop_ub)) {
      if (!rtIsNaN(ecg_l->data[k - 1])) {
        m = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (m == 0) {
    test_m = ecg_l->data[0];
  } else {
    test_m = ecg_l->data[m - 1];
    i0 = m + 1;
    for (k = i0; k <= n; k++) {
      if (test_m < ecg_l->data[k - 1]) {
        test_m = ecg_l->data[k - 1];
      }
    }
  }

  THR_SIG = test_m / 3.0;

  /*  0.25 of the max amplitude  */
  ecg_l_size[0] = loop_ub;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_ecg_l_data[i0] = ecg_l->data[i0];
  }

  ecg_l_data.data = &b_ecg_l_data[0];
  ecg_l_data.size = &ecg_l_size[0];
  ecg_l_data.allocatedSize = 800;
  ecg_l_data.numDimensions = 1;
  ecg_l_data.canFreeData = false;
  THR_NOISE = mean(&ecg_l_data) / 2.0;

  /*  0.5 of the mean signal is considered to be noise */
  SIG_LEV = THR_SIG;
  NOISE_LEV = THR_NOISE;

  /*  Initialize bandpath filter threshold(2 seconds of the bandpass signal) */
  if (!rtIsNaN(ecg_h->data[0])) {
    m = 1;
  } else {
    m = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k <= loop_ub)) {
      if (!rtIsNaN(ecg_h->data[k - 1])) {
        m = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (m == 0) {
    test_m = ecg_h->data[0];
  } else {
    test_m = ecg_h->data[m - 1];
    i0 = m + 1;
    for (k = i0; k <= n; k++) {
      if (test_m < ecg_h->data[k - 1]) {
        test_m = ecg_h->data[k - 1];
      }
    }
  }

  THR_SIG1 = test_m / 3.0;

  /*  0.25 of the max amplitude  */
  ecg_l_size[0] = loop_ub;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_ecg_l_data[i0] = ecg_h->data[i0];
  }

  c_ecg_l_data.data = &b_ecg_l_data[0];
  c_ecg_l_data.size = &ecg_l_size[0];
  c_ecg_l_data.allocatedSize = 800;
  c_ecg_l_data.numDimensions = 1;
  c_ecg_l_data.canFreeData = false;
  THR_NOISE1 = mean(&c_ecg_l_data) / 2.0;

  /*  */
  SIG_LEV1 = THR_SIG1;

  /*  Signal level in Bandpassed filter */
  NOISE_LEV1 = THR_NOISE1;

  /*  Noise level in Bandpassed filter */
  /*  Thresholding and online desicion rule */
  x_i = 0;

  /*  TMW added */
  y_i = 0.0;

  /*  TMW added */
  i0 = varargin_1->size[0];
  emxInit_real_T(&r1, 1);
  emxInit_real_T(&b_ecg_l, 1);
  for (i = 0; i < i0; i++) {
    /*    %% locate the corresponding peak in the filtered signal  */
    if ((locs->data[i] - x_tmp_tmp >= 1.0) && (locs->data[i] <= ecg_h->size[0]))
    {
      d0 = locs->data[i] - rt_roundd_snf(0.15 * fs);
      if (d0 > locs->data[i]) {
        i1 = -1;
        i2 = -1;
      } else {
        i1 = static_cast<int>(d0) - 2;
        i2 = static_cast<int>(locs->data[i]) - 1;
      }

      n = i2 - i1;
      if (n <= 2) {
        if (n == 1) {
          y_i = ecg_h->data[i1 + 1];
          x_i = 1;
        } else if ((ecg_h->data[i1 + 1] < ecg_h->data[i1 + 2]) || (rtIsNaN
                    (ecg_h->data[i1 + 1]) && (!rtIsNaN(ecg_h->data[i1 + 2])))) {
          y_i = ecg_h->data[i1 + 2];
          x_i = 2;
        } else {
          y_i = ecg_h->data[i1 + 1];
          x_i = 1;
        }
      } else {
        if (!rtIsNaN(ecg_h->data[i1 + 1])) {
          x_i = 1;
        } else {
          x_i = 0;
          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k <= n)) {
            if (!rtIsNaN(ecg_h->data[i1 + k])) {
              x_i = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (x_i == 0) {
          y_i = ecg_h->data[i1 + 1];
          x_i = 1;
        } else {
          y_i = ecg_h->data[i1 + x_i];
          i2 = x_i + 1;
          for (k = i2; k <= n; k++) {
            i3 = i1 + k;
            if (y_i < ecg_h->data[i3]) {
              y_i = ecg_h->data[i3];
              x_i = k;
            }
          }
        }
      }
    } else if (1 + i == 1) {
      i1 = static_cast<int>(locs->data[0]);
      i2 = static_cast<int>(locs->data[0]);
      if (i2 <= 2) {
        i1 = static_cast<int>(locs->data[0]);
        if (i1 == 1) {
          y_i = ecg_h->data[0];
          x_i = 1;
        } else if ((ecg_h->data[0] < ecg_h->data[1]) || (rtIsNaN(ecg_h->data[0])
                    && (!rtIsNaN(ecg_h->data[1])))) {
          y_i = ecg_h->data[1];
          x_i = 2;
        } else {
          y_i = ecg_h->data[0];
          x_i = 1;
        }
      } else {
        if (!rtIsNaN(ecg_h->data[0])) {
          x_i = 1;
        } else {
          x_i = 0;
          k = 2;
          do {
            exitg2 = 0;
            i2 = static_cast<int>(locs->data[0]);
            if (k <= i2) {
              if (!rtIsNaN(ecg_h->data[k - 1])) {
                x_i = k;
                exitg2 = 1;
              } else {
                k++;
              }
            } else {
              exitg2 = 1;
            }
          } while (exitg2 == 0);
        }

        if (x_i == 0) {
          y_i = ecg_h->data[0];
          x_i = 1;
        } else {
          y_i = ecg_h->data[x_i - 1];
          i2 = x_i + 1;
          for (k = i2; k <= i1; k++) {
            if (y_i < ecg_h->data[k - 1]) {
              y_i = ecg_h->data[k - 1];
              x_i = k;
            }
          }
        }
      }

      ser_back = 1;
    } else {
      if (locs->data[i] >= ecg_h->size[0]) {
        d0 = locs->data[i] - rt_roundd_snf(0.15 * fs);
        if (d0 > ecg_h->size[0]) {
          i1 = -1;
          i2 = -1;
        } else {
          i1 = static_cast<int>(d0) - 2;
          i2 = ecg_h->size[0] - 1;
        }

        n = i2 - i1;
        if (n <= 2) {
          if (n == 1) {
            y_i = ecg_h->data[i1 + 1];
            x_i = 1;
          } else if ((ecg_h->data[i1 + 1] < ecg_h->data[i1 + 2]) || (rtIsNaN
                      (ecg_h->data[i1 + 1]) && (!rtIsNaN(ecg_h->data[i1 + 2]))))
          {
            y_i = ecg_h->data[i1 + 2];
            x_i = 2;
          } else {
            y_i = ecg_h->data[i1 + 1];
            x_i = 1;
          }
        } else {
          if (!rtIsNaN(ecg_h->data[i1 + 1])) {
            x_i = 1;
          } else {
            x_i = 0;
            k = 2;
            exitg1 = false;
            while ((!exitg1) && (k <= n)) {
              if (!rtIsNaN(ecg_h->data[i1 + k])) {
                x_i = k;
                exitg1 = true;
              } else {
                k++;
              }
            }
          }

          if (x_i == 0) {
            y_i = ecg_h->data[i1 + 1];
            x_i = 1;
          } else {
            y_i = ecg_h->data[i1 + x_i];
            i2 = x_i + 1;
            for (k = i2; k <= n; k++) {
              i3 = i1 + k;
              if (y_i < ecg_h->data[i3]) {
                y_i = ecg_h->data[i3];
                x_i = k;
              }
            }
          }
        }
      }
    }

    /*   %% update the heart_rate (Two heart rate means one the most recent and the other selected) */
    if (qrs_c->size[1] >= 9) {
      x_i_t = qrs_i->size[1] - 9;
      diff(*(double (*)[9])&qrs_i->data[x_i_t], diffRR);

      /* calculate RR interval */
      mean_RR = b_mean(diffRR);

      /*  calculate the mean of 8 previous R waves interval */
      comp = qrs_i->data[qrs_i->size[1] - 1] - qrs_i->data[qrs_i->size[1] - 2];

      /* latest RR */
      if ((comp <= 0.92 * mean_RR) || (comp >= 1.16 * mean_RR)) {
        /*  lower down thresholds to detect better in MVI */
        THR_SIG *= 0.5;

        /* THR_NOISE = 0.5*(THR_SIG);   */
        /*  lower down thresholds to detect better in Bandpass filtered  */
        THR_SIG1 *= 0.5;

        /* THR_NOISE1 = 0.5*(THR_SIG1);  */
      } else {
        m_selected_RR = mean_RR;

        /* the latest regular beats mean */
      }
    }

    /*       %% calculate the mean of the last 8 R waves to make sure that QRS is not */
    /*  missing(If no R detected , trigger a search back) 1.66*mean */
    if (m_selected_RR != 0.0) {
      test_m = m_selected_RR;

      /* if the regular RR availabe use it    */
    } else if (mean_RR != 0.0) {
      test_m = mean_RR;
    } else {
      test_m = 0.0;
    }

    if ((test_m != 0.0) && (locs->data[i] - qrs_i->data[qrs_i->size[1] - 1] >=
                            rt_roundd_snf(1.66 * test_m))) {
      /*  it shows a QRS is missed  */
      d0 = rt_roundd_snf(0.2 * fs);
      comp = qrs_i->data[qrs_i->size[1] - 1] + d0;
      d0 = locs->data[i] - d0;
      if (comp > d0) {
        i1 = -1;
        i2 = -1;
      } else {
        i1 = static_cast<int>(comp) - 2;
        i2 = static_cast<int>(d0) - 1;
      }

      n = i2 - i1;
      if (n <= 2) {
        if (n == 1) {
          test_m = ecg_l->data[i1 + 1];
          m = 1;
        } else if ((ecg_l->data[i1 + 1] < ecg_l->data[i1 + 2]) || (rtIsNaN
                    (ecg_l->data[i1 + 1]) && (!rtIsNaN(ecg_l->data[i1 + 2])))) {
          test_m = ecg_l->data[i1 + 2];
          m = 2;
        } else {
          test_m = ecg_l->data[i1 + 1];
          m = 1;
        }
      } else {
        if (!rtIsNaN(ecg_l->data[i1 + 1])) {
          m = 1;
        } else {
          m = 0;
          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k <= n)) {
            if (!rtIsNaN(ecg_l->data[i1 + k])) {
              m = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (m == 0) {
          test_m = ecg_l->data[i1 + 1];
          m = 1;
        } else {
          test_m = ecg_l->data[i1 + m];
          i2 = m + 1;
          for (k = i2; k <= n; k++) {
            i3 = i1 + k;
            if (test_m < ecg_l->data[i3]) {
              test_m = ecg_l->data[i3];
              m = k;
            }
          }
        }
      }

      /*  search back and locate the max in this interval */
      locs_temp = ((qrs_i->data[qrs_i->size[1] - 1] + rt_roundd_snf(0.2 * fs)) +
                   static_cast<double>(m)) - 1.0;

      /* location  */
      if (test_m > THR_NOISE) {
        i1 = qrs_c->size[1];
        i2 = qrs_c->size[0] * qrs_c->size[1];
        qrs_c->size[1] = i1 + 1;
        emxEnsureCapacity_real_T(qrs_c, i2);
        qrs_c->data[i1] = test_m;
        i1 = qrs_i->size[1];
        i2 = qrs_i->size[0] * qrs_i->size[1];
        qrs_i->size[1] = i1 + 1;
        emxEnsureCapacity_real_T(qrs_i, i2);
        qrs_i->data[i1] = locs_temp;

        /*  find the location in filtered sig */
        if (locs_temp <= ecg_h->size[0]) {
          d0 = locs_temp - rt_roundd_snf(0.15 * fs);
          if (d0 > locs_temp) {
            i1 = -1;
            i2 = -1;
          } else {
            i1 = static_cast<int>(d0) - 2;
            i2 = static_cast<int>(locs_temp) - 1;
          }

          n = i2 - i1;
          if (n <= 2) {
            if (n == 1) {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            } else if ((ecg_h->data[i1 + 1] < ecg_h->data[i1 + 2]) || (rtIsNaN
                        (ecg_h->data[i1 + 1]) && (!rtIsNaN(ecg_h->data[i1 + 2]))))
            {
              comp = ecg_h->data[i1 + 2];
              x_i_t = 2;
            } else {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            }
          } else {
            if (!rtIsNaN(ecg_h->data[i1 + 1])) {
              x_i_t = 1;
            } else {
              x_i_t = 0;
              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= n)) {
                if (!rtIsNaN(ecg_h->data[i1 + k])) {
                  x_i_t = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (x_i_t == 0) {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            } else {
              comp = ecg_h->data[i1 + x_i_t];
              i2 = x_i_t + 1;
              for (k = i2; k <= n; k++) {
                i3 = i1 + k;
                if (comp < ecg_h->data[i3]) {
                  comp = ecg_h->data[i3];
                  x_i_t = k;
                }
              }
            }
          }
        } else {
          d0 = locs_temp - x_tmp_tmp;
          if (d0 > ecg_h->size[0]) {
            i1 = -1;
            i2 = -1;
          } else {
            i1 = static_cast<int>(d0) - 2;
            i2 = ecg_h->size[0] - 1;
          }

          n = i2 - i1;
          if (n <= 2) {
            if (n == 1) {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            } else if ((ecg_h->data[i1 + 1] < ecg_h->data[i1 + 2]) || (rtIsNaN
                        (ecg_h->data[i1 + 1]) && (!rtIsNaN(ecg_h->data[i1 + 2]))))
            {
              comp = ecg_h->data[i1 + 2];
              x_i_t = 2;
            } else {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            }
          } else {
            if (!rtIsNaN(ecg_h->data[i1 + 1])) {
              x_i_t = 1;
            } else {
              x_i_t = 0;
              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= n)) {
                if (!rtIsNaN(ecg_h->data[i1 + k])) {
                  x_i_t = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (x_i_t == 0) {
              comp = ecg_h->data[i1 + 1];
              x_i_t = 1;
            } else {
              comp = ecg_h->data[i1 + x_i_t];
              i2 = x_i_t + 1;
              for (k = i2; k <= n; k++) {
                i3 = i1 + k;
                if (comp < ecg_h->data[i3]) {
                  comp = ecg_h->data[i3];
                  x_i_t = k;
                }
              }
            }
          }
        }

        /*  take care of bandpass signal threshold */
        if (comp > THR_NOISE1) {
          i1 = maxval->size[0] * maxval->size[1];
          maxval->size[0] = 1;
          maxval->size[1] = qrs_i_raw->size[1] + 1;
          emxEnsureCapacity_real_T(maxval, i1);
          loop_ub = qrs_i_raw->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            maxval->data[i1] = qrs_i_raw->data[i1];
          }

          maxval->data[qrs_i_raw->size[1]] = (locs_temp - rt_roundd_snf(0.15 *
            fs)) + (static_cast<double>(x_i_t) - 1.0);
          i1 = qrs_i_raw->size[0] * qrs_i_raw->size[1];
          qrs_i_raw->size[0] = 1;
          qrs_i_raw->size[1] = maxval->size[1];
          emxEnsureCapacity_real_T(qrs_i_raw, i1);
          loop_ub = maxval->size[0] * maxval->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            qrs_i_raw->data[i1] = maxval->data[i1];
          }

          /*  save index of bandpass  */
          i1 = qrs_amp_raw->size[1];
          i2 = qrs_amp_raw->size[0] * qrs_amp_raw->size[1];
          qrs_amp_raw->size[1] = i1 + 1;
          emxEnsureCapacity_real_T(qrs_amp_raw, i2);
          qrs_amp_raw->data[i1] = comp;

          /* save amplitude of bandpass  */
          SIG_LEV1 = 0.25 * comp + 0.75 * SIG_LEV1;

          /* when found with the second thres  */
        }

        SIG_LEV = 0.25 * test_m + 0.75 * SIG_LEV;

        /* when found with the second threshold              */
      }
    }

    /*     %%  find noise and QRS peaks */
    if (varargin_1->data[i] >= THR_SIG) {
      /*  if a QRS candidate occurs within 360ms of the previous QRS */
      /*  ,the algorithm determines if its T wave or QRS */
      if ((qrs_c->size[1] >= 3) && (locs->data[i] - qrs_i->data[qrs_i->size[1] -
           1] <= rt_roundd_snf(0.36 * fs))) {
        d0 = rt_roundd_snf(0.075 * fs);
        comp = locs->data[i] - d0;
        if (comp > locs->data[i]) {
          i1 = 1;
          i2 = 0;
        } else {
          i1 = static_cast<int>(comp);
          i2 = static_cast<int>(locs->data[i]);
        }

        /* mean slope of the waveform at that position */
        d0 = qrs_i->data[qrs_i->size[1] - 1] - d0;
        if (d0 > qrs_i->data[qrs_i->size[1] - 1]) {
          i3 = 1;
          x_i_t = 0;
        } else {
          i3 = static_cast<int>(d0);
          x_i_t = static_cast<int>(qrs_i->data[qrs_i->size[1] - 1]);
        }

        /* mean slope of previous R wave */
        m = b_ecg_l->size[0];
        loop_ub = i2 - i1;
        b_ecg_l->size[0] = loop_ub + 1;
        emxEnsureCapacity_real_T(b_ecg_l, m);
        for (i2 = 0; i2 <= loop_ub; i2++) {
          b_ecg_l->data[i2] = ecg_l->data[(i1 + i2) - 1];
        }

        b_diff(b_ecg_l, r0);
        i1 = b_ecg_l->size[0];
        loop_ub = x_i_t - i3;
        b_ecg_l->size[0] = loop_ub + 1;
        emxEnsureCapacity_real_T(b_ecg_l, i1);
        for (i1 = 0; i1 <= loop_ub; i1++) {
          b_ecg_l->data[i1] = ecg_l->data[(i3 + i1) - 1];
        }

        b_diff(b_ecg_l, r1);
        if (std::abs(mean(r0)) <= std::abs(0.5 * mean(r1))) {
          /*  slope less then 0.5 of previous R */
          skip = 1;

          /*  T wave identification */
          /*  adjust noise level in both filtered and */
          /*  MVI */
          NOISE_LEV1 = 0.125 * y_i + 0.875 * NOISE_LEV1;
          NOISE_LEV = 0.125 * varargin_1->data[i] + 0.875 * NOISE_LEV;
        }
      }

      if (skip == 0) {
        /*  skip is 1 when a T wave is detected        */
        i1 = qrs_c->size[1];
        i2 = qrs_c->size[0] * qrs_c->size[1];
        qrs_c->size[1] = i1 + 1;
        emxEnsureCapacity_real_T(qrs_c, i2);
        qrs_c->data[i1] = varargin_1->data[i];
        i1 = qrs_i->size[1];
        i2 = qrs_i->size[0] * qrs_i->size[1];
        qrs_i->size[1] = i1 + 1;
        emxEnsureCapacity_real_T(qrs_i, i2);
        qrs_i->data[i1] = locs->data[i];

        /*  bandpass filter check threshold */
        if (y_i >= THR_SIG1) {
          if (ser_back != 0) {
            i1 = qrs_i_raw->size[1];
            i2 = qrs_i_raw->size[0] * qrs_i_raw->size[1];
            qrs_i_raw->size[1] = i1 + 1;
            emxEnsureCapacity_real_T(qrs_i_raw, i2);
            qrs_i_raw->data[i1] = x_i;

            /*  save index of bandpass  */
          } else {
            i1 = maxval->size[0] * maxval->size[1];
            maxval->size[0] = 1;
            maxval->size[1] = qrs_i_raw->size[1] + 1;
            emxEnsureCapacity_real_T(maxval, i1);
            loop_ub = qrs_i_raw->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              maxval->data[i1] = qrs_i_raw->data[i1];
            }

            maxval->data[qrs_i_raw->size[1]] = (locs->data[i] - rt_roundd_snf
              (0.15 * fs)) + (static_cast<double>(x_i) - 1.0);
            i1 = qrs_i_raw->size[0] * qrs_i_raw->size[1];
            qrs_i_raw->size[0] = 1;
            qrs_i_raw->size[1] = maxval->size[1];
            emxEnsureCapacity_real_T(qrs_i_raw, i1);
            loop_ub = maxval->size[0] * maxval->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              qrs_i_raw->data[i1] = maxval->data[i1];
            }

            /*  save index of bandpass  */
          }

          i1 = qrs_amp_raw->size[1];
          i2 = qrs_amp_raw->size[0] * qrs_amp_raw->size[1];
          qrs_amp_raw->size[1] = i1 + 1;
          emxEnsureCapacity_real_T(qrs_amp_raw, i2);
          qrs_amp_raw->data[i1] = y_i;

          /*  save amplitude of bandpass  */
          SIG_LEV1 = 0.125 * y_i + 0.875 * SIG_LEV1;

          /*  adjust threshold for bandpass filtered sig */
        }

        /*  adjust Signal level */
        SIG_LEV = 0.125 * varargin_1->data[i] + 0.875 * SIG_LEV;
      }
    } else if ((THR_NOISE <= varargin_1->data[i]) && (varargin_1->data[i] <
                THR_SIG)) {
      /* adjust Noise level in filtered sig */
      NOISE_LEV1 = 0.125 * y_i + 0.875 * NOISE_LEV1;

      /* adjust Noise level in MVI */
      NOISE_LEV = 0.125 * varargin_1->data[i] + 0.875 * NOISE_LEV;
    } else {
      if (varargin_1->data[i] < THR_NOISE) {
        /*  noise level in filtered signal */
        NOISE_LEV1 = 0.125 * y_i + 0.875 * NOISE_LEV1;

        /* end       */
        /* adjust Noise level in MVI */
        NOISE_LEV = 0.125 * varargin_1->data[i] + 0.875 * NOISE_LEV;
      }
    }

    /*     %% adjust the threshold with SNR */
    if ((NOISE_LEV != 0.0) || (SIG_LEV != 0.0)) {
      THR_SIG = NOISE_LEV + 0.25 * std::abs(SIG_LEV - NOISE_LEV);
      THR_NOISE = 0.5 * THR_SIG;
    }

    /*  adjust the threshold with SNR for bandpassed signal */
    if ((NOISE_LEV1 != 0.0) || (SIG_LEV1 != 0.0)) {
      THR_SIG1 = NOISE_LEV1 + 0.25 * std::abs(SIG_LEV1 - NOISE_LEV1);
      THR_NOISE1 = 0.5 * THR_SIG1;
    }

    /*  take a track of thresholds of smoothed signal */
    /*  take a track of thresholds of filtered signal */
    skip = 0;

    /* reset parameters */
    /* reset parameters */
    ser_back = 0;

    /* reset bandpass param    */
  }

  emxFree_real_T(&b_ecg_l);
  emxFree_real_T(&r1);
  emxFree_real_T(&r0);
  emxFree_real_T(&varargin_1);
  emxFree_real_T(&maxval);
  emxFree_real_T(&ecg_h);
  emxFree_real_T(&locs);
  emxFree_real_T(&ecg_l);
  emxFree_real_T(&qrs_i);
  emxFree_real_T(&qrs_c);
  *delay = b_delay;
}

/* End of code generation (pt.cpp) */
