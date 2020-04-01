clear all
close all
load sz06m.mat
L = 2048;
fs_hrv = 8;
[R_ind_post_processing,~, ~, RR, ~]= get_QRS(val(1:2048),200,0);
%[hrv, hrv_t] = resample(RR,R_ind_post_processing(2:end),fs_hrv);
t_rs = 0:R_ind_post_processing(end)-1;
hrv_lin = interp1(R_ind_post_processing(2:end),RR, t_rs);

