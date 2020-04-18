%% features of seizure signal and non-seizure signal
%run script extracting the seizure part from each patients signal
close all
clear all
clc

run get_seizure_signal.m

%% windowing parameters set
Wwidth = 60; 
Wdist = 20;

%% windowing for patient 1

% HRV as a column vector before the seizure
HRVcolbefore1 = HRVbefore1';
% HRV as a column vector under the seizure
HRVcolunder1 = HRVunder1';
% HRV as a column vector after the seizure
HRVcolafter1 = HRVafter1';

% window start and end points for patient 1
[StartPbefore1, EndPbefore1] = windows(HRVcolbefore1, wSize, Wdist);
[StartPunder1, EndPunder1] = windows(HRVcolunder1, wSize, Wdist);
[StartPafter1, EndPafter1] = windows(HRVcolafter1, wSize, Wdist);

%% windowing for patient 2

% HRV as a column vector before seizure 1
HRVcolbefore21 = HRVbefore21';
% HRV as a column vector under seizure 1
HRVcolunder21 = HRVunder21';
% HRV as a column vector after seizure 1
HRVcolafter21 = HRVafter21';

% HRV as a column vector before seizure 2
HRVcolbefore22 = HRVbefore22';
% HRV as a column vector under seizure 2
HRVcolunder22 = HRVunder22';
% HRV as a column vector after seizure 2
HRVcolafter22 = HRVafter22';

% window start and end points for patient 2 seizure 1
[StartPbefore21, EndPbefore21] = windows(HRVcolbefore21, wSize, Wdist);
[StartPunder21, EndPunder21] = windows(HRVcolunder21, wSize, Wdist);
[StartPafter21, EndPafter21] = windows(HRVcolafter21, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore1, EndPbefore22] = windows(HRVcolbefore22, wSize, Wdist);
[StartPunder1, EndPunder22] = windows(HRVcolunder22, wSize, Wdist);
[StartPafter1, EndPafter22] = windows(HRVcolafter22, wSize, Wdist);

%% windowing for patient 3

% HRV as a column vector before seizure 1
HRVcolbefore21 = HRVbefore31';
% HRV as a column vector under seizure 1
HRVcolunder21 = HRVunder31';
% HRV as a column vector after seizure 1
HRVcolafter21 = HRVafter31';

% HRV as a column vector before seizure 2
HRVcolbefore22 = HRVbefore32';
% HRV as a column vector under seizure 2
HRVcolunder22 = HRVunder32';
% HRV as a column vector after seizure 2
HRVcolafter22 = HRVafter32';

% window start and end points for patient 2 seizure 1
[StartPbefore31, EndPbefore31] = windows(HRVcolbefore31, wSize, Wdist);
[StartPunder31, EndPunder31] = windows(HRVcolunder31, wSize, Wdist);
[StartPafter31, EndPafter31] = windows(HRVcolafter31, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore31, EndPbefore32] = windows(HRVcolbefore32, wSize, Wdist);
[StartPunder31, EndPunder32] = windows(HRVcolunder32, wSize, Wdist);
[StartPafter31, EndPafter32] = windows(HRVcolafter32, wSize, Wdist);

%% windowing for patient 4

% HRV as a column vector before the seizure
HRVcolbefore4 = HRVbefore4';
% HRV as a column vector under the seizure
HRVcolunder4 = HRVunder4';
% HRV as a column vector after the seizure
HRVcolafter4 = HRVafter4';

% window start and end points for patient 1
[StartPbefore4, EndPbefore4] = windows(HRVcolbefore4, wSize, Wdist);
[StartPunder4, EndPunder4] = windows(HRVcolunder4, wSize, Wdist);
[StartPafter4, EndPafter4] = windows(HRVcolafter4, wSize, Wdist);


%% windowing for patient 5

% HRV as a column vector before the seizure
HRVcolbefore5 = HRVbefore5';
% HRV as a column vector under the seizure
HRVcolunder5 = HRVunder5';
% HRV as a column vector after the seizure
HRVcolafter5 = HRVafter5';

% window start and end points for patient 1
[StartPbefore5, EndPbefore5] = windows(HRVcolbefore5, wSize, Wdist);
[StartPunder5, EndPunder5] = windows(HRVcolunder5, wSize, Wdist);
[StartPafter5, EndPafter5] = windows(HRVcolafter5, wSize, Wdist);

%% windowing for patient 6


%% windowing for patient 7

% HRV as a column vector before the seizure
HRVcolbefore7 = HRVbefore7';
% HRV as a column vector under the seizure
HRVcolunder7 = HRVunder7';
% HRV as a column vector after the seizure
HRVcolafter7 = HRVafter7';

% window start and end points for patient 1
[StartPbefore7, EndPbefore7] = windows(HRVcolbefore7, wSize, Wdist);
[StartPunder7, EndPunder7] = windows(HRVcolunder7, wSize, Wdist);
[StartPafter7, EndPafter7] = windows(HRVcolafter7, wSize, Wdist);
