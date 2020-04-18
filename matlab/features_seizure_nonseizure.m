%% features of seizure signal and non-seizure signal
%run script extracting the seizure part from each patients signal
close all
clear all
clc

run get_seizure_signal.m

%% windowing parameters set
wSize = 60; 
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
[StartPbefore22, EndPbefore22] = windows(HRVcolbefore22, wSize, Wdist);
[StartPunder22, EndPunder22] = windows(HRVcolunder22, wSize, Wdist);
[StartPafter22, EndPafter22] = windows(HRVcolafter22, wSize, Wdist);

%% windowing for patient 3

% HRV as a column vector before seizure 1
HRVcolbefore31 = HRVbefore31';
% HRV as a column vector under seizure 1
HRVcolunder31 = HRVunder31';
% HRV as a column vector after seizure 1
HRVcolafter31 = HRVafter31';

% HRV as a column vector before seizure 2
HRVcolbefore32 = HRVbefore32';
% HRV as a column vector under seizure 2
HRVcolunder32 = HRVunder32';
% HRV as a column vector after seizure 2
HRVcolafter32 = HRVafter32';

% window start and end points for patient 2 seizure 1
[StartPbefore31, EndPbefore31] = windows(HRVcolbefore31, wSize, Wdist);
[StartPunder31, EndPunder31] = windows(HRVcolunder31, wSize, Wdist);
[StartPafter31, EndPafter31] = windows(HRVcolafter31, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore32, EndPbefore32] = windows(HRVcolbefore32, wSize, Wdist);
[StartPunder32, EndPunder32] = windows(HRVcolunder32, wSize, Wdist);
[StartPafter32, EndPafter32] = windows(HRVcolafter32, wSize, Wdist);

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

% HRV as a column vector before seizure 1
HRVcolbefore61 = HRVbefore61';
% HRV as a column vector under seizure 1
HRVcolunder61 = HRVunder61';
% HRV as a column vector after seizure 1
HRVcolafter61 = HRVafter61';

% HRV as a column vector before seizure 2
HRVcolbefore62 = HRVbefore62';
% HRV as a column vector under seizure 2
HRVcolunder62 = HRVunder62';
% HRV as a column vector after seizure 2
HRVcolafter62 = HRVafter62';

% window start and end points for patient 6 seizure 1
[StartPbefore61, EndPbefore61] = windows(HRVcolbefore61, wSize, Wdist);
[StartPunder61, EndPunder61] = windows(HRVcolunder61, wSize, Wdist);
[StartPafter61, EndPafter61] = windows(HRVcolafter61, wSize, Wdist);

% window start and end points for patient 2 seizure 2
[StartPbefore62, EndPbefore62] = windows(HRVcolbefore62, wSize, Wdist);
[StartPunder62, EndPunder62] = windows(HRVcolunder62, wSize, Wdist);
[StartPafter62, EndPafter62] = windows(HRVcolafter62, wSize, Wdist);

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

%% features calculations %%%%
%% patient 1 features

% features before a seizure
[Tfeaturesbefore1,TfeaturesNormbefore1] = TimeFeats(HRVcolbefore1,StartPbefore1,EndPbefore1);
% features under a seizure
[Tfeaturesunder1,TfeaturesNormunder1] = TimeFeats(HRVcolunder1,StartPunder1,EndPunder1);
% features after a seizure
[Tfeaturesafter1,TfeaturesNormafter1] = TimeFeats(HRVcolafter1,StartPafter1,EndPafter1);


%% patient 2 features

% features before seizure 1
[Tfeaturesbefore21,TfeaturesNormbefore21] = TimeFeats(HRVcolbefore21,StartPbefore21,EndPbefore21);
% features under seizure 1
[Tfeaturesunder21,TfeaturesNormunder21] = TimeFeats(HRVcolunder21,StartPunder21,EndPunder21);
% features after seizure 1
[Tfeaturesafter21,TfeaturesNormafter21] = TimeFeats(HRVcolafter21,StartPafter21,EndPafter21);

% features before seizure 2
[Tfeaturesbefore22,TfeaturesNormbefore22] = TimeFeats(HRVcolbefore22,StartPbefore22,EndPbefore22);
% features under seizure 2
[Tfeaturesunder22,TfeaturesNormunder22] = TimeFeats(HRVcolunder22,StartPunder22,EndPunder22);
% features after seizure 2
[Tfeaturesafter22,TfeaturesNormafter22] = TimeFeats(HRVcolafter22,StartPafter22,EndPafter22);

%% patient 3 features

% features before seizure 1
[Tfeaturesbefore31,TfeaturesNormbefore31] = TimeFeats(HRVcolbefore31,StartPbefore31,EndPbefore31);
% features under seizure 1
[Tfeaturesunder31,TfeaturesNormunder31] = TimeFeats(HRVcolunder31,StartPunder31,EndPunder31);
% features after seizure 1
[Tfeaturesafter31,TfeaturesNormafter31] = TimeFeats(HRVcolafter31,StartPafter31,EndPafter31);

% features before seizure 2
[Tfeaturesbefore32,TfeaturesNormbefore32] = TimeFeats(HRVcolbefore32,StartPbefore32,EndPbefore32);
% features under seizure 2
[Tfeaturesunder32,TfeaturesNormunder32] = TimeFeats(HRVcolunder32,StartPunder32,EndPunder32);
% features after seizure 2
[Tfeaturesafter32,TfeaturesNormafter32] = TimeFeats(HRVcolafter32,StartPafter32,EndPafter32);

%% patient 4 features

% features before a seizure
[Tfeaturesbefore4,TfeaturesNormbefore4] = TimeFeats(HRVcolbefore4,StartPbefore4,EndPbefore4);
% features under a seizure
[Tfeaturesunder4,TfeaturesNormunder4] = TimeFeats(HRVcolunder4,StartPunder4,EndPunder4);
% features after a seizure
[Tfeaturesafter4,TfeaturesNormafter4] = TimeFeats(HRVcolafter4,StartPafter4,EndPafter4);


%% patient 5 features

% features before a seizure
[Tfeaturesbefore5,TfeaturesNormbefore5] = TimeFeats(HRVcolbefore5,StartPbefore5,EndPbefore5);
% features under a seizure
[Tfeaturesunder5,TfeaturesNormunder5] = TimeFeats(HRVcolunder5,StartPunder5,EndPunder5);
% features after a seizure
[Tfeaturesafter5,TfeaturesNormafter5] = TimeFeats(HRVcolafter5,StartPafter5,EndPafter5);

%% patient 6 features

% features before seizure 1
[Tfeaturesbefore61,TfeaturesNormbefore61] = TimeFeats(HRVcolbefore61,StartPbefore61,EndPbefore61);
% features under seizure 1
[Tfeaturesunder61,TfeaturesNormunder61] = TimeFeats(HRVcolunder61,StartPunder61,EndPunder61);
% features after seizure 1
[Tfeaturesafter61,TfeaturesNormafter61] = TimeFeats(HRVcolafter61,StartPafter61,EndPafter61);

% features before seizure 2
[Tfeaturesbefore62,TfeaturesNormbefore62] = TimeFeats(HRVcolbefore62,StartPbefore62,EndPbefore22);
% features under seizure 2
[Tfeaturesunder62,TfeaturesNormunder62] = TimeFeats(HRVcolunder62,StartPunder62,EndPunder62);
% features after seizure 2
[Tfeaturesafter62,TfeaturesNormafter62] = TimeFeats(HRVcolafter62,StartPafter62,EndPafter62);

%% patient 7 features

% features before a seizure
[Tfeaturesbefore7,TfeaturesNormbefore7] = TimeFeats(HRVcolbefore7,StartPbefore7,EndPbefore7);
% features under a seizure
[Tfeaturesunder7,TfeaturesNormunder7] = TimeFeats(HRVcolunder7,StartPunder7,EndPunder7);
% features after a seizure
[Tfeaturesafter7,TfeaturesNormafter7] = TimeFeats(HRVcolafter7,StartPafter7,EndPafter7);

%% seizure features collected

% patient 1
SeizureFeatures.Patient1.Seizure1.normalized = TfeaturesNormunder1;
SeizureFeatures.Patient1.Seizure1.regular = Tfeaturesunder1;

%patient 2
SeizureFeatures.Patient2.Seizure1.normalized = TfeaturesNormunder21;
SeizureFeatures.Patient2.Seizure1.regular = Tfeaturesunder21;
SeizureFeatures.Patient2.Seizure2.normalized = TfeaturesNormunder22;
SeizureFeatures.Patient2.Seizure2.regular = Tfeaturesunder22;

% patient 3
SeizureFeatures.Patient3.Seizure1.normalized = TfeaturesNormunder31;
SeizureFeatures.Patient3.Seizure1.regular = Tfeaturesunder31;
SeizureFeatures.Patient3.Seizure2.normalized = TfeaturesNormunder32;
SeizureFeatures.Patient3.Seizure2.regular = Tfeaturesunder32;

%patient 4
SeizureFeatures.Patient4.Seizure1.normalized = TfeaturesNormunder4;
SeizureFeatures.Patient4.Seizure1.regular = Tfeaturesunder4;

%patient 5
SeizureFeatures.Patient5.Seizure1.normalized = TfeaturesNormunder5;
SeizureFeatures.Patient5.Seizure1.regular = Tfeaturesunder5;

% patient 6
SeizureFeatures.Patient6.Seizure1.normalized = TfeaturesNormunder61;
SeizureFeatures.Patient6.Seizure1.regular = Tfeaturesunder61;
SeizureFeatures.Patient6.Seizure2.normalized = TfeaturesNormunder62;
SeizureFeatures.Patient6.Seizure2.regular = Tfeaturesunder62;

%patient 7
SeizureFeatures.Patient7.Seizure1.normalized = TfeaturesNormunder7;
SeizureFeatures.Patient7.Seizure1.regular = Tfeaturesunder7;

%% features collected before and after seizures

% patient 1
NoSeizureFeatures.Patient1.Before.Normalized = TfeaturesNormbefore1;
NoSeizureFeatures.Patient1.Before.Regular = Tfeaturesbefore1;
NoSeizureFeatures.Patient1.After.Normalized = TfeaturesNormafter1;
NoSeizureFeatures.Patient1.After.Regular = Tfeaturesafter1;

% patient 2
NoSeizureFeatures.Patient2.Seizure1.Before.Normalized = TfeaturesNormbefore21;
NoSeizureFeatures.Patient2.Seizure1.Before.Regular = Tfeaturesbefore21;
NoSeizureFeatures.Patient2.Seizure1.After.Normalized = TfeaturesNormafter21;
NoSeizureFeatures.Patient2.Seizure1.After.Regular = Tfeaturesafter21;

NoSeizureFeatures.Patient2.Seizure2.Before.Normalized = TfeaturesNormbefore22;
NoSeizureFeatures.Patient2.Seizure2.Before.Regular = Tfeaturesbefore22;
NoSeizureFeatures.Patient2.Seizure2.After.Normalized = TfeaturesNormafter22;
NoSeizureFeatures.Patient2.Seizure2.After.Regular = Tfeaturesafter22;

% patient 3
NoSeizureFeatures.Patient3.Seizure1.Before.Normalized = TfeaturesNormbefore31;
NoSeizureFeatures.Patient3.Seizure1.Before.Regular = Tfeaturesbefore31;
NoSeizureFeatures.Patient3.Seizure1.After.Normalized = TfeaturesNormafter31;
NoSeizureFeatures.Patient3.Seizure1.After.Regular = Tfeaturesafter31;

NoSeizureFeatures.Patient3.Seizure2.Before.Normalized = TfeaturesNormbefore32;
NoSeizureFeatures.Patient3.Seizure2.Before.Regular = Tfeaturesbefore32;
NoSeizureFeatures.Patient3.Seizure2.After.Normalized = TfeaturesNormafter32;
NoSeizureFeatures.Patient3.Seizure2.After.Regular = Tfeaturesafter32;

% patient 4
NoSeizureFeatures.Patient4.Before.Normalized = TfeaturesNormbefore4;
NoSeizureFeatures.Patient4.Before.Regular = Tfeaturesbefore4;
NoSeizureFeatures.Patient4.After.Normalized = TfeaturesNormafter4;
NoSeizureFeatures.Patient4.After.Regular = Tfeaturesafter4;

% patient 5
NoSeizureFeatures.Patient5.Before.Normalized = TfeaturesNormbefore5;
NoSeizureFeatures.Patient5.Before.Regular = Tfeaturesbefore5;
NoSeizureFeatures.Patient5.After.Normalized = TfeaturesNormafter5;
NoSeizureFeatures.Patient5.After.Regular = Tfeaturesafter5;

% patient 6
NoSeizureFeatures.Patient6.Seizure1.Before.Normalized = TfeaturesNormbefore61;
NoSeizureFeatures.Patient6.Seizure1.Before.Regular = Tfeaturesbefore61;
NoSeizureFeatures.Patient6.Seizure1.After.Normalized = TfeaturesNormafter61;
NoSeizureFeatures.Patient6.Seizure1.After.Regular = Tfeaturesafter61;

NoSeizureFeatures.Patient6.Seizure2.Before.Normalized = TfeaturesNormbefore62;
NoSeizureFeatures.Patient6.Seizure2.Before.Regular = Tfeaturesbefore62;
NoSeizureFeatures.Patient6.Seizure2.After.Normalized = TfeaturesNormafter62;
NoSeizureFeatures.Patient6.Seizure2.After.Regular = Tfeaturesafter62;

% patient 7
NoSeizureFeatures.Patient7.Before.Normalized = TfeaturesNormbefore7;
NoSeizureFeatures.Patient7.Before.Regular = Tfeaturesbefore7;
NoSeizureFeatures.Patient7.After.Normalized = TfeaturesNormafter7;
NoSeizureFeatures.Patient7.After.Regular = Tfeaturesafter7;







