%% main time features 


%% window start and end point calculation
Wwidth = 5; 
Wdist = 2;

HRVcol = HRV';

[StartP, EndP] = windows(HRVcol, Wwidth, Wdist);

%% features calculation

Tfeatures = TimeFeats(HRVcol,StartP,EndP);

%% visualization
