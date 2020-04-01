function [idxHRV, HRV, RR, idxR, HR] = getHRV(ecg, fs)
%getHRV This function gets as an input an ECG signal and it's sampling
%frequency and returns the location of R peaks, the RR interval, the
%resampled RR at 8 Hz (HRV), resample time indices, and Heart Rate
%   Detailed explanation goes here
fsHRV = 8;

[idxR, ~, ~, RR, ~] = get_QRS(ecg, fsHRV, 0);
HR = 60./(RR/200);
idxHRV = idxR(1):1/8:(idxR(end-1))/200;
HRV = interp1(idxR(1:end-1)/200,RR/200, idxHRV, 'extrap');
HR = 60/RR;
end

