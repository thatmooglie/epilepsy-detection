function [Tfeatures,TfeaturesNorm] = TimeFeats(HRV,StartP,EndP)

% Tfeatures = TimeFeats(HRV,StartP,EndP)calculates the time features of
% each window
% the window start and end points are calculated with the function windows
% in the main script.

% input:
%       HRV : heart rate variability in column vectors
%       StartP: start point of each window (in vector form)
%       EndP: End point of each window (in vector form)

% output: 
%        Tfeatures: time series features


Wmean = [];
Wstd = [];
Wrms = [];
Wactivity = [];
Wmobility = [];
Wcomplexity = [];

pNN50 = [];

count = 0;
for i = 1:length(StartP)
    data = HRV(StartP(i):EndP(i));
    Wmean(i) = mean(data);
    Wstd(i) = std(data);
    Wrms(i) = rms(data);
    Wactivity(i) = var(data);
    Wmobility(i) = sqrt(var(diff(data))/var(data));
    Wcomplexity(i) = (sqrt(var(diff(diff(data))))/var(diff(data)))/(sqrt(var(diff(data))/var(data)));
    
    for ii = 2:length(data)
        
        if abs(data(ii-1)-data(ii)) > 0.05
         count = count + 1;
        end
    end
    pNN50 = (count/length(data))*100;
end

Tfeatures.Mean = Wmean';
Tfeatures.Std = Wstd';
Tfeatures.Rms = Wrms';
Tfeatures.NN50 = count';
Tfeatures.pNN50 = pNN50;
Tfeatures.HjortPar.Activity = Wactivity';
Tfeatures.HjortPar.Mobility = Wmobility';
Tfeatures.HjortPar.Complexity = Wcomplexity';

for j = 1:length(Tfeatures.Mean)
    TfeaturesNorm.Mean(j) =  (Tfeatures.Mean(j)- min(Tfeatures.Mean))/(max(Tfeatures.Mean)- min(Tfeatures.Mean));
    TfeaturesNorm.Std(j) =  (Tfeatures.Std(j)- min(Tfeatures.Std))/(max(Tfeatures.Std)- min(Tfeatures.Std));
    TfeaturesNorm.Rms(j) =  (Tfeatures.Rms(j)- min(Tfeatures.Rms))/(max(Tfeatures.Rms)- min(Tfeatures.Rms));
    TfeaturesNorm.HjortPar.Activity(j) =  (Tfeatures.HjortPar.Activity(j)- min(Tfeatures.HjortPar.Activity))/(max(Tfeatures.HjortPar.Activity)- min(Tfeatures.HjortPar.Activity));
    TfeaturesNorm.HjortPar.Mobility(j) =  (Tfeatures.HjortPar.Mobility(j)- min(Tfeatures.HjortPar.Mobility))/(max(Tfeatures.HjortPar.Mobility)- min(Tfeatures.HjortPar.Mobility));
    TfeaturesNorm.HjortPar.Complexity(j) =  (Tfeatures.HjortPar.Complexity(j)- min(Tfeatures.HjortPar.Complexity))/(max(Tfeatures.HjortPar.Complexity)- min(Tfeatures.HjortPar.Complexity));    
end

end

