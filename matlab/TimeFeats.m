function Tfeatures = TimeFeats(HRV,StartP,EndP)

% Tfeatures = TimeFeats(HRV,StartP,EndP)calculates the time features of
% each window
% the window start and end points are calculated with the function windows
% in the main script.

% input:
%       HRV : heart rate variability
%       StartP: start point of each window (in vector form)
%       EndP: End point of each window (in vector form)

% output: 
%        Tfeatures: time series features


for i = 1:length(StartP)
    data = HRV(StartP(i):EndP(i));
    Wmean(i) = mean(data);
    Wstd(i) = std(data);
end

Tfeatures.mean = Wmean';
Tfeatures.std = Wstd';

end

