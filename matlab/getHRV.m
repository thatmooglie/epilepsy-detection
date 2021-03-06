function [idxHRV, HRV, RR, idxR, HR, idxHR] = getHRV(ecg, fs)
%getHRV This function gets as an input an ECG signal and it's sampling
%frequency and returns the location of R peaks, the RR interval, the
%resampled RR at 8 Hz (HRV), resample time indices, and Heart Rate at 1Hz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%---INPUT---
%ecg = the ECG signal
%fs = the sampling freqeuncy
%
%---OUTPUT---
%idxHRV = Position of the HRV signal
%HRV = the HRV Signal 
%RR = the RR interval signal
%idxR = postition of the RR signal
%HR = the heartrate signal
%idxHR = postion of the heartrate signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsHRV = 8;

[idxR, ~, ~, RR, ~] = get_QRS(ecg, fs, 0);
idxHRV = idxR(1)/200:1/fsHRV:(idxR(end-1))/200;
idxHR = idxR(1)/200:(idxR(end-1))/200;
HRV = interp1(idxR(1:end-1)/200,RR/200, idxHRV, 'linear', 'extrap');
HR = 60./interp1(idxR(1:end-1)/200, RR/200, idxHR, 'linear', 'extrap');
end

