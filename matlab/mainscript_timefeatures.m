%% main script for features extraction %%

%% window start and end point calculation
Wwidth = 120; 
Wdist = 60;

HRVcol = HRV';

[StartP, EndP] = windows(HRVcol, wSize, Wdist);

%% features calculation

[Tfeatures,TfeaturesNorm] = TimeFeats(HRVcol,StartP,EndP);

featuresMAT = [TfeaturesNorm.Mean,TfeaturesNorm.Std, TfeaturesNorm.Rms,]


FreqFeatures = Frequency_features(HRV,fs_hrv);


%% visualization

plot(TfeaturesNorm.Mean)







