%% features of seizure signal and non-seizure signal
%run script extracting the seizure part from each patients signal
close all
clear
clc

run get_seizure_signal.m

%% windowing parameters set
wSize = 60; 
Wdist = 20;
    
%% windowing for patient 1

% normalizing for patient 1

HRVbeforeS1 = [];
HRVunderS1 = []; 
HRVafterS1 = [];

 for i = 1:length(HRVbefore1)
     HRVbeforeS1(i) = (HRVbefore1(i) - mean(HRVbefore1))/std(HRVbefore1); 
 end

 for ii = 1:length(HRVunder1)
     HRVunderS1(ii) = (HRVunder1(ii) - mean(HRVunder1))/std(HRVunder1); 
 end

 for iii = 1:length(HRVafter1)
     HRVafterS1(iii) = (HRVafter1(iii) - mean(HRVafter1))/std(HRVafter1); 
 end

% HRV as a column vector before the seizure
HRVcolbefore1 = HRVbeforeS1';
% HRV as a column vector under the seizure
HRVcolunder1 = HRVunderS1';
% HRV as a column vector after the seizure
HRVcolafter1 = HRVafterS1';

% window start and end points for patient 1
[StartPbefore1, EndPbefore1] = windows(HRVcolbefore1, wSize, Wdist);
[StartPunder1, EndPunder1] = windows(HRVcolunder1, wSize, Wdist);
[StartPafter1, EndPafter1] = windows(HRVcolafter1, wSize, Wdist);

%% windowing for patient 2

% normalizing for patient 2

HRVbeforeS21 = [];
HRVunderS21 = []; 
HRVafterS21 = [];

 for i = 1:length(HRVbefore21)
     HRVbeforeS21(i) = (HRVbefore21(i) - mean(HRVbefore21))/std(HRVbefore21); 
 end

 for ii = 1:length(HRVunder21)
     HRVunderS21(ii) = (HRVunder21(ii) - mean(HRVunder21))/std(HRVunder21); 
 end

 for iii = 1:length(HRVafter21)
     HRVafterS21(iii) = (HRVafter21(iii) - mean(HRVafter21))/std(HRVafter21); 
 end


HRVbeforeS22 = [];
HRVunderS22 = []; 
HRVafterS22 = [];

 for i = 1:length(HRVbefore22)
     HRVbeforeS22(i) = (HRVbefore22(i) - mean(HRVbefore22))/std(HRVbefore22); 
 end

 for ii = 1:length(HRVunder22)
     HRVunderS22(ii) = (HRVunder22(ii) - mean(HRVunder22))/std(HRVunder22); 
 end

 for iii = 1:length(HRVafter22)
     HRVafterS22(iii) = (HRVafter22(iii) - mean(HRVafter22))/std(HRVafter22); 
 end
 
 
% HRV as a column vector before seizure 1
HRVcolbefore21 = HRVbeforeS21';
% HRV as a column vector under seizure 1
HRVcolunder21 = HRVunderS21';
% HRV as a column vector after seizure 1
HRVcolafter21 = HRVafterS21';

% HRV as a column vector before seizure 2
HRVcolbefore22 = HRVbeforeS22';
% HRV as a column vector under seizure 2
HRVcolunder22 = HRVunderS22';
% HRV as a column vector after seizure 2
HRVcolafter22 = HRVafterS22';

% window start and end points for patient 2 seizure 1
[StartPbefore21, EndPbefore21] = windows(HRVcolbefore21, wSize, Wdist);
[StartPunder21, EndPunder21] = windows(HRVcolunder21, wSize, Wdist);
[StartPafter21, EndPafter21] = windows(HRVcolafter21, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore22, EndPbefore22] = windows(HRVcolbefore22, wSize, Wdist);
[StartPunder22, EndPunder22] = windows(HRVcolunder22, wSize, Wdist);
[StartPafter22, EndPafter22] = windows(HRVcolafter22, wSize, Wdist);

%% windowing for patient 3

% normalizing for patient 2

HRVbeforeS31 = [];
HRVunderS31 = []; 
HRVafterS31 = [];

 for i = 1:length(HRVbefore31)
     HRVbeforeS31(i) = (HRVbefore31(i) - mean(HRVbefore31))/std(HRVbefore31); 
 end

 for ii = 1:length(HRVunder31)
     HRVunderS31(ii) = (HRVunder31(ii) - mean(HRVunder31))/std(HRVunder31); 
 end

 for iii = 1:length(HRVafter31)
     HRVafterS31(iii) = (HRVafter31(iii) - mean(HRVafter31))/std(HRVafter31); 
 end

HRVbeforeS32 = [];
HRVunderS32 = []; 
HRVafterS32 = [];

 for i = 1:length(HRVbefore32)
     HRVbeforeS32(i) = (HRVbefore32(i) - mean(HRVbefore32))/std(HRVbefore32); 
 end

 for ii = 1:length(HRVunder32)
     HRVunderS32(ii) = (HRVunder32(ii) - mean(HRVunder32))/std(HRVunder32); 
 end

 for iii = 1:length(HRVafter32)
     HRVafterS32(iii) = (HRVafter32(iii) - mean(HRVafter32))/std(HRVafter32); 
 end


% HRV as a column vector before seizure 1
HRVcolbefore31 = HRVbeforeS31';
% HRV as a column vector under seizure 1
HRVcolunder31 = HRVunderS31';
% HRV as a column vector after seizure 1
HRVcolafter31 = HRVafterS31';

% HRV as a column vector before seizure 2
HRVcolbefore32 = HRVbeforeS32';
% HRV as a column vector under seizure 2
HRVcolunder32 = HRVunderS32';
% HRV as a column vector after seizure 2
HRVcolafter32 = HRVafterS32';

% window start and end points for patient 2 seizure 1
[StartPbefore31, EndPbefore31] = windows(HRVcolbefore31, wSize, Wdist);
[StartPunder31, EndPunder31] = windows(HRVcolunder31, wSize, Wdist);
[StartPafter31, EndPafter31] = windows(HRVcolafter31, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore32, EndPbefore32] = windows(HRVcolbefore32, wSize, Wdist);
[StartPunder32, EndPunder32] = windows(HRVcolunder32, wSize, Wdist);
[StartPafter32, EndPafter32] = windows(HRVcolafter32, wSize, Wdist);

%% windowing for patient 4

% normalizing for patient 1

HRVbeforeS4 = [];
HRVunderS4 = []; 
HRVafterS4 = [];

 for i = 1:length(HRVbefore4)
     HRVbeforeS4(i) = (HRVbefore4(i) - mean(HRVbefore4))/std(HRVbefore4); 
 end

 for ii = 1:length(HRVunder4)
     HRVunderS4(ii) = (HRVunder4(ii) - mean(HRVunder4))/std(HRVunder4); 
 end

 for iii = 1:length(HRVafter4)
     HRVafterS4(iii) = (HRVafter4(iii) - mean(HRVafter4))/std(HRVafter4); 
 end

% HRV as a column vector before the seizure
HRVcolbefore4 = HRVbeforeS4';
% HRV as a column vector under the seizure
HRVcolunder4 = HRVunderS4';
% HRV as a column vector after the seizure
HRVcolafter4 = HRVafterS4';

% window start and end points for patient 1
[StartPbefore4, EndPbefore4] = windows(HRVcolbefore4, wSize, Wdist);
[StartPunder4, EndPunder4] = windows(HRVcolunder4, wSize, Wdist);
[StartPafter4, EndPafter4] = windows(HRVcolafter4, wSize, Wdist);


%% windowing for patient 5

% normalizing for patient 5

HRVbeforeS5 = [];
HRVunderS5 = []; 
HRVafterS5 = [];

 for i = 1:length(HRVbefore5)
     HRVbeforeS5(i) = (HRVbefore5(i) - mean(HRVbefore5))/std(HRVbefore5); 
 end

 for ii = 1:length(HRVunder5)
     HRVunderS5(ii) = (HRVunder5(ii) - mean(HRVunder5))/std(HRVunder5); 
 end

 for iii = 1:length(HRVafter5)
     HRVafterS5(iii) = (HRVafter5(iii) - mean(HRVafter5))/std(HRVafter5); 
 end


% HRV as a column vector before the seizure
HRVcolbefore5 = HRVbeforeS5';
% HRV as a column vector under the seizure
HRVcolunder5 = HRVunderS5';
% HRV as a column vector after the seizure
HRVcolafter5 = HRVafterS5';

% window start and end points for patient 1
[StartPbefore5, EndPbefore5] = windows(HRVcolbefore5, wSize, Wdist);
[StartPunder5, EndPunder5] = windows(HRVcolunder5, wSize, Wdist);
[StartPafter5, EndPafter5] = windows(HRVcolafter5, wSize, Wdist);

%% windowing for patient 6

% normalizing for patient 6

HRVbeforeS61 = [];
HRVunderS61 = []; 
HRVafterS61 = [];

 for i = 1:length(HRVbefore61)
     HRVbeforeS61(i) = (HRVbefore61(i) - mean(HRVbefore61))/std(HRVbefore61); 
 end

 for ii = 1:length(HRVunder61)
     HRVunderS61(ii) = (HRVunder61(ii) - mean(HRVunder61))/std(HRVunder61); 
 end

 for iii = 1:length(HRVafter61)
     HRVafterS61(iii) = (HRVafter61(iii) - mean(HRVafter61))/std(HRVafter61); 
 end


HRVbeforeS62 = [];
HRVunderS62 = []; 
HRVafterS62 = [];

 for i = 1:length(HRVbefore62)
     HRVbeforeS62(i) = (HRVbefore62(i) - mean(HRVbefore62))/std(HRVbefore62); 
 end

 for ii = 1:length(HRVunder62)
     HRVunderS62(ii) = (HRVunder62(ii) - mean(HRVunder62))/std(HRVunder62); 
 end

 for iii = 1:length(HRVafter62)
     HRVafterS62(iii) = (HRVafter62(iii) - mean(HRVafter62))/std(HRVafter62); 
 end


% HRV as a column vector before seizure 1
HRVcolbefore61 = HRVbeforeS61';
% HRV as a column vector under seizure 1
HRVcolunder61 = HRVunderS61';
% HRV as a column vector after seizure 1
HRVcolafter61 = HRVafterS61';

% HRV as a column vector before seizure 2
HRVcolbefore62 = HRVbeforeS62';
% HRV as a column vector under seizure 2
HRVcolunder62 = HRVunderS62';
% HRV as a column vector after seizure 2
HRVcolafter62 = HRVafterS62';

% window start and end points for patient 6 seizure 1
[StartPbefore61, EndPbefore61] = windows(HRVcolbefore61, wSize, Wdist);
[StartPunder61, EndPunder61] = windows(HRVcolunder61, wSize, Wdist);
[StartPafter61, EndPafter61] = windows(HRVcolafter61, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore62, EndPbefore62] = windows(HRVcolbefore62, wSize, Wdist);
[StartPunder62, EndPunder62] = windows(HRVcolunder62, wSize, Wdist);
[StartPafter62, EndPafter62] = windows(HRVcolafter62, wSize, Wdist);

%% windowing for patient 7

% normalizing for patient 1

HRVbeforeS7 = [];
HRVunderS7 = []; 
HRVafterS7 = [];

 for i = 1:length(HRVbefore7)
     HRVbeforeS7(i) = (HRVbefore7(i) - mean(HRVbefore7))/std(HRVbefore7); 
 end

 for ii = 1:length(HRVunder7)
     HRVunderS7(ii) = (HRVunder7(ii) - mean(HRVunder7))/std(HRVunder7); 
 end

 for iii = 1:length(HRVafter7)
     HRVafterS7(iii) = (HRVafter7(iii) - mean(HRVafter7))/std(HRVafter7); 
 end

% HRV as a column vector before the seizure
HRVcolbefore7 = HRVbeforeS7';
% HRV as a column vector under the seizure
HRVcolunder7 = HRVunderS7';
% HRV as a column vector after the seizure
HRVcolafter7 = HRVafterS7';

% window start and end points for patient 1
[StartPbefore7, EndPbefore7] = windows(HRVcolbefore7, wSize, Wdist);
[StartPunder7, EndPunder7] = windows(HRVcolunder7, wSize, Wdist);
[StartPafter7, EndPafter7] = windows(HRVcolafter7, wSize, Wdist);


%% features calculations %%%% including balancing of features
%% patient 1 features

% features before a seizure
Tfeaturesbefore1 = TimeFeats(HRVcolbefore1,StartPbefore1(63:end),EndPbefore1(63:end));
% features under a seizure
Tfeaturesunder1 = TimeFeats(HRVcolunder1,StartPunder1,EndPunder1);
% features after a seizure
Tfeaturesafter1 = TimeFeats(HRVcolafter1,StartPafter1(63:end),EndPafter1(63:end));


%% patient 2 features

% features before seizure 1
Tfeaturesbefore21 = TimeFeats(HRVcolbefore21,StartPbefore21(85:end),EndPbefore21(85:end));
% features under seizure 1
Tfeaturesunder21 = TimeFeats(HRVcolunder21,StartPunder21,EndPunder21);
% features after seizure 1
Tfeaturesafter21 = TimeFeats(HRVcolafter21,StartPafter21(85:end),EndPafter21(85:end));

% features before seizure 2
Tfeaturesbefore22 = TimeFeats(HRVcolbefore22,StartPbefore22(106:end),EndPbefore22(106:end));
% features under seizure 2
Tfeaturesunder22 = TimeFeats(HRVcolunder22,StartPunder22,EndPunder22);
% features after seizure 2
Tfeaturesafter22 = TimeFeats(HRVcolafter22,StartPafter22(106:end),EndPafter22(106:end));

%% patient 3 features

% features before seizure 1
Tfeaturesbefore31 = TimeFeats(HRVcolbefore31,StartPbefore31(57:end),EndPbefore31(57:end));
% features under seizure 1
Tfeaturesunder31 = TimeFeats(HRVcolunder31,StartPunder31,EndPunder31);
% features after seizure 1
Tfeaturesafter31 = TimeFeats(HRVcolafter31,StartPafter31(57:end),EndPafter31(57:end));

% features before seizure 2
Tfeaturesbefore32 = TimeFeats(HRVcolbefore32,StartPbefore32(57:end),EndPbefore32(57:end));
% features under seizure 2
Tfeaturesunder32 = TimeFeats(HRVcolunder32,StartPunder32,EndPunder32);
% features after seizure 2
Tfeaturesafter32 = TimeFeats(HRVcolafter32,StartPafter32(57:end),EndPafter32(57:end));

%% patient 4 features

% features before a seizure
Tfeaturesbefore4 = TimeFeats(HRVcolbefore4,StartPbefore4,EndPbefore4);
% features under a seizure
Tfeaturesunder4 = TimeFeats(HRVcolunder4,StartPunder4,EndPunder4);
% features after a seizure
Tfeaturesafter4 = TimeFeats(HRVcolafter4,StartPafter4,EndPafter4);


%% patient 5 features

% features before a seizure
Tfeaturesbefore5 = TimeFeats(HRVcolbefore5,StartPbefore5(72:end),EndPbefore5(72:end));
% features under a seizure
Tfeaturesunder5 = TimeFeats(HRVcolunder5,StartPunder5,EndPunder5);
% features after a seizure
Tfeaturesafter5 = TimeFeats(HRVcolafter5,StartPafter5(72:end),EndPafter5(72:end));

%% patient 6 features

% features before seizure 1
Tfeaturesbefore61 = TimeFeats(HRVcolbefore61,StartPbefore61(88:end),EndPbefore61(88:end));
% features under seizure 1
Tfeaturesunder61 = TimeFeats(HRVcolunder61,StartPunder61,EndPunder61);
% features after seizure 1
Tfeaturesafter61 = TimeFeats(HRVcolafter61,StartPafter61(88:end),EndPafter61(88:end));

% features before seizure 2
Tfeaturesbefore62 = TimeFeats(HRVcolbefore62,StartPbefore62(70:end),EndPbefore22(70:end));
% features under seizure 2
Tfeaturesunder62 = TimeFeats(HRVcolunder62,StartPunder62,EndPunder62);
% features after seizure 2
Tfeaturesafter62 = TimeFeats(HRVcolafter62,StartPafter62(70:end),EndPafter62(70:end));

%% patient 7 features

% features before a seizure
Tfeaturesbefore7 = TimeFeats(HRVcolbefore7,StartPbefore7(69:end),EndPbefore7(69:end));
% features under a seizure
Tfeaturesunder7 = TimeFeats(HRVcolunder7,StartPunder7,EndPunder7);
% features after a seizure
Tfeaturesafter7 = TimeFeats(HRVcolafter7,StartPafter7(69:end),EndPafter7(69:end));

%% features collected into matrix for classifier

% mean collected:
Mean1 = [Tfeaturesbefore1.Mean' Tfeaturesunder1.Mean' Tfeaturesafter1.Mean']; 
Mean2 = [Tfeaturesbefore21.Mean' Tfeaturesunder21.Mean' Tfeaturesafter21.Mean' Tfeaturesbefore22.Mean' Tfeaturesunder22.Mean' Tfeaturesafter22.Mean'];
Mean3 = [Tfeaturesbefore31.Mean' Tfeaturesunder31.Mean' Tfeaturesafter31.Mean' Tfeaturesbefore32.Mean' Tfeaturesunder32.Mean' Tfeaturesafter32.Mean'];
Mean4 = [Tfeaturesbefore4.Mean' Tfeaturesunder4.Mean' Tfeaturesafter4.Mean']; 
Mean5 = [Tfeaturesbefore5.Mean' Tfeaturesunder5.Mean' Tfeaturesafter5.Mean']; 
Mean6 = [Tfeaturesbefore61.Mean' Tfeaturesunder61.Mean' Tfeaturesafter61.Mean' Tfeaturesbefore62.Mean' Tfeaturesunder62.Mean' Tfeaturesafter62.Mean'];
Mean7 = [Tfeaturesbefore7.Mean' Tfeaturesunder7.Mean' Tfeaturesafter7.Mean']; 

Tmean = [Mean1 Mean2 Mean3 Mean4 Mean5 Mean6 Mean7]';

% std collected
Std1 = [Tfeaturesbefore1.Std' Tfeaturesunder1.Std' Tfeaturesafter1.Std']; 
Std2 = [Tfeaturesbefore21.Std' Tfeaturesunder21.Std' Tfeaturesafter21.Std' Tfeaturesbefore22.Std' Tfeaturesunder22.Std' Tfeaturesafter22.Std'];
Std3 = [Tfeaturesbefore31.Std' Tfeaturesunder31.Std' Tfeaturesafter31.Std' Tfeaturesbefore32.Std' Tfeaturesunder32.Std' Tfeaturesafter32.Std'];
Std4 = [Tfeaturesbefore4.Std' Tfeaturesunder4.Std' Tfeaturesafter4.Std']; 
Std5 = [Tfeaturesbefore5.Std' Tfeaturesunder5.Std' Tfeaturesafter5.Std']; 
Std6 = [Tfeaturesbefore61.Std' Tfeaturesunder61.Std' Tfeaturesafter61.Std' Tfeaturesbefore62.Std' Tfeaturesunder62.Std' Tfeaturesafter62.Std'];
Std7 = [Tfeaturesbefore7.Std' Tfeaturesunder7.Std' Tfeaturesafter7.Std']; 

Tstd = [Std1 Std2 Std3 Std4 Std5 Std6 Std7]';

% rms collected
RMS1 = [Tfeaturesbefore1.Rms' Tfeaturesunder1.Rms' Tfeaturesafter1.Rms']; 
RMS2 = [Tfeaturesbefore21.Rms' Tfeaturesunder21.Rms' Tfeaturesafter21.Rms' Tfeaturesbefore22.Std' Tfeaturesunder22.Std' Tfeaturesafter22.Std'];
RMS3 = [Tfeaturesbefore31.Rms' Tfeaturesunder31.Rms' Tfeaturesafter31.Rms' Tfeaturesbefore32.Std' Tfeaturesunder32.Std' Tfeaturesafter32.Std'];
RMS4 = [Tfeaturesbefore4.Rms' Tfeaturesunder4.Rms' Tfeaturesafter4.Rms']; 
RMS5 = [Tfeaturesbefore5.Rms' Tfeaturesunder5.Rms' Tfeaturesafter5.Rms']; 
RMS6 = [Tfeaturesbefore61.Rms' Tfeaturesunder61.Rms' Tfeaturesafter61.Rms' Tfeaturesbefore62.Std' Tfeaturesunder62.Std' Tfeaturesafter62.Std'];
RMS7 = [Tfeaturesbefore7.Rms' Tfeaturesunder7.Rms' Tfeaturesafter7.Rms']; 

TRMS = [RMS1 RMS2 RMS3 RMS4 RMS5 RMS6 RMS7]';

% nn50 collected
nn1 = [Tfeaturesbefore1.NN50' Tfeaturesunder1.NN50' Tfeaturesafter1.NN50']; 
nn2 = [Tfeaturesbefore21.NN50' Tfeaturesunder21.NN50' Tfeaturesafter21.NN50' Tfeaturesbefore22.NN50' Tfeaturesunder22.NN50' Tfeaturesafter22.NN50'];
nn3 = [Tfeaturesbefore31.NN50' Tfeaturesunder31.NN50' Tfeaturesafter31.NN50' Tfeaturesbefore32.NN50' Tfeaturesunder32.NN50' Tfeaturesafter32.NN50'];
nn4 = [Tfeaturesbefore4.NN50' Tfeaturesunder4.NN50' Tfeaturesafter4.NN50']; 
nn5 = [Tfeaturesbefore5.NN50' Tfeaturesunder5.NN50' Tfeaturesafter5.NN50']; 
nn6 = [Tfeaturesbefore61.NN50' Tfeaturesunder61.NN50' Tfeaturesafter61.NN50' Tfeaturesbefore62.NN50' Tfeaturesunder62.NN50' Tfeaturesafter62.NN50'];
nn7 = [Tfeaturesbefore7.NN50' Tfeaturesunder7.NN50' Tfeaturesafter7.NN50']; 

Tnn50 = [nn1 nn2 nn3 nn4 nn5 nn6 nn7]';

% pNN50 collected
pnn1 = [Tfeaturesbefore1.pNN50' Tfeaturesunder1.pNN50' Tfeaturesafter1.pNN50']; 
pnn2 = [Tfeaturesbefore21.pNN50' Tfeaturesunder21.pNN50' Tfeaturesafter21.pNN50' Tfeaturesbefore22.pNN50' Tfeaturesunder22.pNN50' Tfeaturesafter22.pNN50'];
pnn3 = [Tfeaturesbefore31.pNN50' Tfeaturesunder31.pNN50' Tfeaturesafter31.pNN50' Tfeaturesbefore32.pNN50' Tfeaturesunder32.pNN50' Tfeaturesafter32.pNN50'];
pnn4 = [Tfeaturesbefore4.pNN50' Tfeaturesunder4.pNN50' Tfeaturesafter4.pNN50']; 
pnn5 = [Tfeaturesbefore5.pNN50' Tfeaturesunder5.pNN50' Tfeaturesafter5.pNN50']; 
pnn6 = [Tfeaturesbefore61.pNN50' Tfeaturesunder61.pNN50' Tfeaturesafter61.pNN50' Tfeaturesbefore62.pNN50' Tfeaturesunder62.pNN50' Tfeaturesafter62.pNN50'];
pnn7 = [Tfeaturesbefore7.pNN50' Tfeaturesunder7.pNN50' Tfeaturesafter7.pNN50']; 

Tpnn50 = [pnn1 pnn2 pnn3 pnn4 pnn5 pnn6 pnn7]';

% Hjort parameters collected
% activity
ac1 = [Tfeaturesbefore1.HjortPar.Activity' Tfeaturesunder1.HjortPar.Activity' Tfeaturesafter1.HjortPar.Activity']; 
ac2 = [Tfeaturesbefore21.HjortPar.Activity' Tfeaturesunder21.HjortPar.Activity' Tfeaturesafter21.HjortPar.Activity' Tfeaturesbefore22.HjortPar.Activity' Tfeaturesunder22.HjortPar.Activity' Tfeaturesafter22.HjortPar.Activity'];
ac3 = [Tfeaturesbefore31.HjortPar.Activity' Tfeaturesunder31.HjortPar.Activity' Tfeaturesafter31.HjortPar.Activity' Tfeaturesbefore32.HjortPar.Activity' Tfeaturesunder32.HjortPar.Activity' Tfeaturesafter32.HjortPar.Activity'];
ac4 = [Tfeaturesbefore4.HjortPar.Activity' Tfeaturesunder4.HjortPar.Activity' Tfeaturesafter4.HjortPar.Activity']; 
ac5 = [Tfeaturesbefore5.HjortPar.Activity' Tfeaturesunder5.HjortPar.Activity' Tfeaturesafter5.HjortPar.Activity']; 
ac6 = [Tfeaturesbefore61.HjortPar.Activity' Tfeaturesunder61.HjortPar.Activity' Tfeaturesafter61.HjortPar.Activity' Tfeaturesbefore62.HjortPar.Activity' Tfeaturesunder62.HjortPar.Activity' Tfeaturesafter62.HjortPar.Activity'];
ac7 = [Tfeaturesbefore7.HjortPar.Activity' Tfeaturesunder7.HjortPar.Activity' Tfeaturesafter7.HjortPar.Activity']; 

Tac = [ac1 ac2 ac3 ac4 ac5 ac6 ac7]';

% mobility
m1 = [Tfeaturesbefore1.HjortPar.Mobility' Tfeaturesunder1.HjortPar.Mobility' Tfeaturesafter1.HjortPar.Mobility']; 
m2 = [Tfeaturesbefore21.HjortPar.Mobility' Tfeaturesunder21.HjortPar.Mobility' Tfeaturesafter21.HjortPar.Mobility' Tfeaturesbefore22.HjortPar.Mobility' Tfeaturesunder22.HjortPar.Mobility' Tfeaturesafter22.HjortPar.Mobility'];
m3 = [Tfeaturesbefore31.HjortPar.Mobility' Tfeaturesunder31.HjortPar.Mobility' Tfeaturesafter31.HjortPar.Mobility' Tfeaturesbefore32.HjortPar.Mobility' Tfeaturesunder32.HjortPar.Mobility' Tfeaturesafter32.HjortPar.Mobility'];
m4 = [Tfeaturesbefore4.HjortPar.Mobility' Tfeaturesunder4.HjortPar.Mobility' Tfeaturesafter4.HjortPar.Mobility']; 
m5 = [Tfeaturesbefore5.HjortPar.Mobility' Tfeaturesunder5.HjortPar.Mobility' Tfeaturesafter5.HjortPar.Mobility']; 
m6 = [Tfeaturesbefore61.HjortPar.Mobility' Tfeaturesunder61.HjortPar.Mobility' Tfeaturesafter61.HjortPar.Mobility' Tfeaturesbefore62.HjortPar.Mobility' Tfeaturesunder62.HjortPar.Mobility' Tfeaturesafter62.HjortPar.Mobility'];
m7 = [Tfeaturesbefore7.HjortPar.Mobility' Tfeaturesunder7.HjortPar.Mobility' Tfeaturesafter7.HjortPar.Mobility']; 

Tm = [m1 m2 m3 m4 m5 m6 m7]';

% complexity
c1 = [Tfeaturesbefore1.HjortPar.Complexity' Tfeaturesunder1.HjortPar.Complexity' Tfeaturesafter1.HjortPar.Complexity']; 
c2 = [Tfeaturesbefore21.HjortPar.Complexity' Tfeaturesunder21.HjortPar.Complexity' Tfeaturesafter21.HjortPar.Complexity' Tfeaturesbefore22.HjortPar.Complexity' Tfeaturesunder22.HjortPar.Complexity' Tfeaturesafter22.HjortPar.Complexity'];
c3 = [Tfeaturesbefore31.HjortPar.Complexity' Tfeaturesunder31.HjortPar.Complexity' Tfeaturesafter31.HjortPar.Complexity' Tfeaturesbefore32.HjortPar.Complexity' Tfeaturesunder32.HjortPar.Complexity' Tfeaturesafter32.HjortPar.Complexity'];
c4 = [Tfeaturesbefore4.HjortPar.Complexity' Tfeaturesunder4.HjortPar.Complexity' Tfeaturesafter4.HjortPar.Complexity']; 
c5 = [Tfeaturesbefore5.HjortPar.Complexity' Tfeaturesunder5.HjortPar.Complexity' Tfeaturesafter5.HjortPar.Complexity']; 
c6 = [Tfeaturesbefore61.HjortPar.Complexity' Tfeaturesunder61.HjortPar.Complexity' Tfeaturesafter61.HjortPar.Complexity' Tfeaturesbefore62.HjortPar.Complexity' Tfeaturesunder62.HjortPar.Complexity' Tfeaturesafter62.HjortPar.Complexity'];
c7 = [Tfeaturesbefore7.HjortPar.Complexity' Tfeaturesunder7.HjortPar.Complexity' Tfeaturesafter7.HjortPar.Complexity']; 

Tc = [c1 c2 c3 c4 c5 c6 c7]';

% seizure/non-seizure discrete vector
% patient 1
pt1nSbefore = zeros(length(Tfeaturesbefore1.Mean),1)';
pt1S = ones(length(Tfeaturesunder1.Mean),1)';
pt1nSafter = zeros(length(Tfeaturesafter1.Mean),1)';

pt1 = [pt1nSbefore pt1S pt1nSafter]; 

% patient 2
pt2nSbefore1 = zeros(length(Tfeaturesbefore21.Mean),1)';
pt2S1 = ones(length(Tfeaturesunder21.Mean),1)';
pt2nSafter1 = zeros(length(Tfeaturesafter21.Mean),1)';

pt2nSbefore2 = zeros(length(Tfeaturesbefore22.Mean),1)';
pt2S2 = ones(length(Tfeaturesunder22.Mean),1)';
pt2nSafter2 = zeros(length(Tfeaturesafter22.Mean),1)';

pt2 = [pt2nSbefore1 pt2S1 pt2nSafter1 pt2nSbefore2 pt2S2 pt2nSafter2]; 

% patient 3
pt3nSbefore1 = zeros(length(Tfeaturesbefore31.Mean),1)';
pt3S1 = ones(length(Tfeaturesunder31.Mean),1)';
pt3nSafter1 = zeros(length(Tfeaturesafter31.Mean),1)';

pt3nSbefore2 = zeros(length(Tfeaturesbefore32.Mean),1)';
pt3S2 = ones(length(Tfeaturesunder32.Mean),1)';
pt3nSafter2 = zeros(length(Tfeaturesafter32.Mean),1)';

pt3 = [pt3nSbefore1 pt3S1 pt3nSafter1 pt3nSbefore2 pt3S2 pt3nSafter2];

% patient 4
pt4nSbefore = zeros(length(Tfeaturesbefore4.Mean),1)';
pt4S = ones(length(Tfeaturesunder4.Mean),1)';
pt4nSafter = zeros(length(Tfeaturesafter4.Mean),1)';

pt4 = [pt4nSbefore pt4S pt4nSafter]; 

% patient 5
pt5nSbefore = zeros(length(Tfeaturesbefore5.Mean),1)';
pt5S = ones(length(Tfeaturesunder5.Mean),1)';
pt5nSafter = zeros(length(Tfeaturesafter5.Mean),1)';

pt5 = [pt5nSbefore pt5S pt5nSafter]; 

% patient 6
pt6nSbefore1 = zeros(length(Tfeaturesbefore61.Mean),1)';
pt6S1 = ones(length(Tfeaturesunder61.Mean),1)';
pt6nSafter1 = zeros(length(Tfeaturesafter61.Mean),1)';

pt6nSbefore2 = zeros(length(Tfeaturesbefore62.Mean),1)';
pt6S2 = ones(length(Tfeaturesunder62.Mean),1)';
pt6nSafter2 = zeros(length(Tfeaturesafter62.Mean),1)';

pt6 = [pt6nSbefore1 pt6S1 pt6nSafter1 pt6nSbefore2 pt6S2 pt6nSafter2]; 

% patient 7
pt7nSbefore = zeros(length(Tfeaturesbefore7.Mean),1)';
pt7S = ones(length(Tfeaturesunder7.Mean),1)';
pt7nSafter = zeros(length(Tfeaturesafter7.Mean),1)';

pt7 = [pt7nSbefore pt7S pt7nSafter]; 

% collected:
ptsSnS = [pt1 pt2 pt3 pt4 pt5 pt6 pt7]';

% features collected
totalFeatsmat = [Tmean,Tstd,TRMS,Tac,Tm,Tc,ptsSnS];





