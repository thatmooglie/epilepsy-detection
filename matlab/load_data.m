clear all
close all
load sz02m.mat
L = 2*2048;
fs_hrv = 8;
start = 165000;
wSize = 2^15;
[idxHRV, HRV, RR, idxR, HR] = getHRV(val, 200);

