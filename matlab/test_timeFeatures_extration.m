function [timeFeatures] = test_timeFeatures_extration(signal)
% function: [timeFeatures] = timeFeatures_extration(signal).
% This function calculates the time domain features in a signal
% ------Input--------
% [vector] signal (that is the signal from witch time domian featurs are
% calculated from).
%-------Output-------
% [vector] timeFeatures (this vector has its first value as mean, then std,
% then RMS, var, mobility, complexity and the end is pNN50).
%   

timeFeatures(1) = mean(signal);         % mean
timeFeatures(2) = std(signal);          % standard diviation
timeFeatures(3) = rms(signal);          % RMS
timeFeatures(4) = var(signal);          % Variance
timeFeatures(5) = sqrt(var(diff(signal))/var(signal)); % Mobility
timeFeatures(6) = (sqrt(var(diff(diff(signal))))/var(diff(signal)))/(sqrt(var(diff(signal))/var(signal))); % Complexity
count = 0;
for ii = 2:length(signal)
    if abs(signal(ii-1)-signal(ii)) > 0.05
     count = count + 1;
    end
end
timeFeatures(7) = (count/length(signal))*100; %pNN50

end