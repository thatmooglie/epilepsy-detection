clear all
close all
load sz01m.mat
L = 2*2048;
fs_hrv = 8;
[idxHRV, HRV, RR, idxR, HR] = getHRV(-val(1:L), 200);

