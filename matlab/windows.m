function [StartP, EndP] = windows(HRV, Wwidth, Wdist)

%[StartP, EndP] = windows(ecg, Wwidth, Wdist) calculates the starting and end points of each moving window from the
%       time signal in a given ecg. 
%
%       Input:
%          ECG signal       signal in column vectors. 
%          Wwidth           width of the window.
%          Wdist            distance between window centers.
%
%       Output:
%          StartP   Start point of each window segment.
%          EndP   End point of each window segment.

counter = 1;
Whalf = Wwidth/2; %length of each side from the window center
center = floor(median(1:Wwidth)); %the center corresponds to the middle value of the window
%the median is the value separating the higher half from the lower half of a data sample 

StartP(counter) = 1; %first start point (first sample point in ecg)
EndP(counter) = Wwidth; 

while EndP(counter) <= length(HRV)
    counter = counter + 1;
    center = center + Wdist;
    StartP(counter) = center - Whalf;
    EndP(counter) = center + Whalf;
   
end

if EndP(counter) > length(HRV)
    StartP(counter) = []; %remove last points because they are out of the bounds
    EndP(counter) = [];
end

EndP = EndP';
StartP = StartP';

end