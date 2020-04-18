%% Get_seizure_signal
% Dette script har til formål at blive bekendt med variablen 
% 5_minuttes_before_index_matrix som er en matrixe som indeholder index
% værdierne for seizures'ne samt 5 minutter før og 5 minutter efter. 
% For at dette script kan virker skal man have hele ECG signalet indlæset
% før man starter. Dermed skal man huske at udskifte variablen ECG_signal 
% med sin egen variable af ECG_signal. HUSK at holde øje at der er 10
% seizures i alt men kun 7 patienter. I indx_matrix kan man se hvilke
% seizures som høre til hvilke patienter.

% loading af matrixen 
load 5_minuttes_before_index_matrix.mat
load F_ECG.mat

% navne i matrixen refferer til seizures'ne, dvs at variablen 'start' er
% sttart index for seizuren samt, variablen 'before' er start index for 5
% minutter før seizuren starter. 

%% patient 1

% Hvis man gerne vil have signalet før seizuren gøres det på denne måde:
signal_before1 = F_ECG(1).data(indx_matrix(1).before:indx_matrix(1).start);
% tallet (1) betyder at man tager den værdi som er i første række i 
% matrixen indx_matrix. Så indx_matrix(1).before = 115200 og 
% indx_matrix(2).before = 692600. 

% For hvisning af signalet før seizuren
Fs = 200;
t1 = 0:1/Fs:(length(F_ECG(1).data)-1)/Fs;   % første laves en tids vector
t_signal_before1 = t1(indx_matrix(1).before:indx_matrix(1).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(1)
plot(t_signal_before1,signal_before1)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker for patient 1')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under1 = F_ECG(1).data(indx_matrix(1).start:indx_matrix(1).end);
t1 = 0:1/Fs:(length(F_ECG(1).data)-1)/Fs;   % første laves en tids vector
t_signal_under1 = t1(indx_matrix(1).start:indx_matrix(1).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(2)
plot(t_signal_under1,signal_under1)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after1 = F_ECG(1).data(indx_matrix(1).end:indx_matrix(1).after);
t1 = 0:1/Fs:(length(F_ECG(1).data)-1)/Fs;   % første laves en tids vector
t_signal_after1 = t1(indx_matrix(1).end:indx_matrix(1).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(3)
plot(t_signal_after1,signal_after1)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 2

% Hvis man gerne vil have signalet før seizuren gøres det på denne måde:
signal_before21 = F_ECG(2).data(indx_matrix(2).before:indx_matrix(2).start);
signal_before22 = F_ECG(2).data(indx_matrix(3).before:indx_matrix(3).start);

% tallet (1) betyder at man tager den værdi som er i første række i 
% matrixen indx_matrix. Så indx_matrix(1).before = 115200 og 
% indx_matrix(2).before = 692600. 

% For hvisning af signalet før seizuren
t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector

t_signal_before21 = t2(indx_matrix(2).before:indx_matrix(2).start); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_before22 = t2(indx_matrix(3).before:indx_matrix(3).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(4)
plot(t_signal_before21,signal_before21)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker for patient 2 for seizure 1')

figure(5)
plot(t_signal_before22,signal_before22)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker for patient 2 for seizure 2')


% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under21 = F_ECG(2).data(indx_matrix(2).start:indx_matrix(2).end);
signal_under22 = F_ECG(2).data(indx_matrix(3).start:indx_matrix(3).end);


t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector
t_signal_under21 = t2(indx_matrix(2).start:indx_matrix(2).end); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_under22 = t2(indx_matrix(3).start:indx_matrix(3).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(6)
plot(t_signal_under21,signal_under21)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 1 for patient 2')

figure(7)
plot(t_signal_under22,signal_under22)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 2 for patient 2')

% nu laves for efter seizuren
signal_after21 = F_ECG(2).data(indx_matrix(2).end:indx_matrix(2).after);
signal_after22 = F_ECG(2).data(indx_matrix(3).end:indx_matrix(3).after);

t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector
t_signal_after21 = t2(indx_matrix(2).end:indx_matrix(2).after); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_after22 = t2(indx_matrix(3).end:indx_matrix(3).after); % nu reduceres tids vectoren kun til det vi gerne vil vise


figure(8)
plot(t_signal_after21,signal_after21)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 1 for patient 2 er sket')

figure(9)
plot(t_signal_after22,signal_after22)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 2 for patient 2 er sket')

%% patient 3

signal_before31 = F_ECG(3).data(indx_matrix(4).before:indx_matrix(4).start);
signal_before32 = F_ECG(3).data(indx_matrix(5).before:indx_matrix(5).start);


% For hvisning af signalet før seizuren
t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_before31 = t3(indx_matrix(4).before:indx_matrix(4).start); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_before32 = t3(indx_matrix(5).before:indx_matrix(5).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(10)
plot(t_signal_before31,signal_before31)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizure 1 for patient 3 sker')

figure(11)
plot(t_signal_before32,signal_before32)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizure 2 for patient 3 sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under31 = F_ECG(3).data(indx_matrix(4).start:indx_matrix(4).end);
signal_under32 = F_ECG(3).data(indx_matrix(5).start:indx_matrix(5).end);

t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_under31 = t3(indx_matrix(4).start:indx_matrix(4).end); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_under32 = t3(indx_matrix(5).start:indx_matrix(5).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(12)
plot(t_signal_under31,signal_under31)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 1 for patient 3')

figure(13)
plot(t_signal_under32,signal_under32)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 2 for patient 3')

% nu laves for efter seizuren
signal_after31 = F_ECG(3).data(indx_matrix(4).end:indx_matrix(4).after);
signal_after32 = F_ECG(3).data(indx_matrix(5).end:indx_matrix(5).after);


t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_after31 = t3(indx_matrix(4).end:indx_matrix(4).after); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_after32 = t3(indx_matrix(5).end:indx_matrix(5).after); % nu reduceres tids vectoren kun til det vi gerne vil vise


figure(14)
plot(t_signal_after31,signal_after31)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 1 for patient 3 er sket')

figure(15)
plot(t_signal_after32,signal_after32)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 2 for patient 3 er sket')

%% patient 4

signal_before4 = F_ECG(4).data(indx_matrix(6).before:indx_matrix(6).start);

% For hvisning af signalet før seizuren
Fs = 200;
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_before4 = t4(indx_matrix(6).before:indx_matrix(6).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(10)
plot(t_signal_before4,signal_before4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret for patient 4 sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under4 = F_ECG(4).data(indx_matrix(6).start:indx_matrix(6).end);
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_under4 = t4(indx_matrix(6).start:indx_matrix(6).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(11)
plot(t_signal_under4,signal_under4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret for patient 4')

% nu laves for efter seizuren
signal_after4 = F_ECG(4).data(indx_matrix(6).end:indx_matrix(6).after);
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_after4 = t4(indx_matrix(6).end:indx_matrix(6).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(12)
plot(t_signal_after4,signal_after4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret for patient 4 er sket')

%% patient 5

signal_before5 = F_ECG(5).data(indx_matrix(7).before:indx_matrix(7).start);

% For hvisning af signalet før seizuren
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_before5 = t5(indx_matrix(7).before:indx_matrix(7).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(13)
plot(t_signal_before5,signal_before5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret for patient 5 sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under5 = F_ECG(5).data(indx_matrix(7).start:indx_matrix(7).end);
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_under5 = t5(indx_matrix(7).start:indx_matrix(7).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(14)
plot(t_signal_under5,signal_under5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret for patient 5')

% nu laves for efter seizuren
signal_after5 = F_ECG(5).data(indx_matrix(7).end:indx_matrix(7).after);
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_after5 = t5(indx_matrix(7).end:indx_matrix(7).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(15)
plot(t_signal_after5,signal_after5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret for patient 5 er sket')

%% patient 6

signal_before61 = F_ECG(6).data(indx_matrix(8).before:indx_matrix(8).start);
signal_before62 = F_ECG(6).data(indx_matrix(9).before:indx_matrix(9).start);


% For hvisning af signalet før seizuren
t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector
t_signal_before61 = t6(indx_matrix(8).before:indx_matrix(8).start); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_before62 = t6(indx_matrix(9).before:indx_matrix(9).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(16)
plot(t_signal_before61,signal_before61)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizure 1 for patient 6 sker')

figure(17)
plot(t_signal_before62,signal_before62)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizure 2 for patient 6 sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under61 = F_ECG(6).data(indx_matrix(8).start:indx_matrix(8).end);
signal_under62 = F_ECG(6).data(indx_matrix(9).start:indx_matrix(9).end);

t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector
t_signal_under61 = t6(indx_matrix(8).start:indx_matrix(8).end); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_under62 = t6(indx_matrix(9).start:indx_matrix(9).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(18)
plot(t_signal_under61,signal_under61)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 1 for patient 6')

figure(19)
plot(t_signal_under62,signal_under62)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizure 2 for patient 6')

% nu laves for efter seizuren
signal_after61 = F_ECG(6).data(indx_matrix(8).end:indx_matrix(8).after);
signal_after62 = F_ECG(6).data(indx_matrix(9).end:indx_matrix(9).after);

t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector

t_signal_after61 = t6(indx_matrix(8).end:indx_matrix(8).after); % nu reduceres tids vectoren kun til det vi gerne vil vise
t_signal_after62 = t6(indx_matrix(9).end:indx_matrix(9).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(20)
plot(t_signal_after61,signal_after61)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 1 for patient 6 er sket')

figure(21)
plot(t_signal_after62,signal_after62)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizure 2 for patient 6 er sket')


%% patient 7

signal_before7 = F_ECG(7).data(indx_matrix(10).before:indx_matrix(10).start);

% For hvisning af signalet før seizuren
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_before7 = t7(indx_matrix(10).before:indx_matrix(10).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(22)
plot(t_signal_before7,signal_before7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret for patient 7 sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under7 = F_ECG(7).data(indx_matrix(10).start:indx_matrix(10).end);
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_under7 = t7(indx_matrix(10).start:indx_matrix(10).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(20)
plot(t_signal_under7,signal_under7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret for patient 7')

% nu laves for efter seizuren
signal_after7 = F_ECG(7).data(indx_matrix(10).end:indx_matrix(10).after);
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_after7 = t7(indx_matrix(10).end:indx_matrix(10).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(21)
plot(t_signal_after7,signal_after7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret for patient 7 er sket')

%% calculation of HRV of all of the above signals

% function to calculate HRV
%[idxHRV, HRV, RR, idxR, HR] = getHRV(val, 200);

%% HRV for patient 1

% HRV for patient 1 before seizure
[idxHRVbefore1, HRVbefore1, RRbefore1, idxRbefore1, HRbefore1] = getHRV(signal_before1, 200);

% % HRV for patient 1 during seizure
[idxHRVunder1, HRVunder1, RRunder1, idxRunder1, HRunder1] = getHRV(signal_under1, 200);

% HRV for patient 1 after seizure
[idxHRVafter1, HRVafter1, RRafter1, idxRafter1, HRafter1] = getHRV(signal_after1, 200);

 %% HRV for patient 2
 
 % HRV for patient 2 before seizure 1
[idxHRVbefore21, HRVbefore21, RRbefore21, idxRbefore21, HRbefore21] = getHRV(signal_before21, 200);

% % HRV for patient 2 during seizure 1
[idxHRVunder21, HRVunder21, RRunder21, idxRunder21, HRunder21] = getHRV(signal_under21, 200);

% HRV for patient 2 after seizure 1
[idxHRVafter21, HRVafter21, RRafter21, idxRafter21, HRafter21] = getHRV(signal_after21, 200);


 % HRV for patient 2 before seizure 2
[idxHRVbefore22, HRVbefore22, RRbefore22, idxRbefore22, HRbefore22] = getHRV(signal_before22, 200);

% % HRV for patient 2 during seizure 2
[idxHRVunder22, HRVunder22, RRunder22, idxRunder22, HRunder22] = getHRV(signal_under22, 200);

% HRV for patient 2 after seizure 2
[idxHRVafter22, HRVafter22, RRafter22, idxRafter22, HRafter22] = getHRV(signal_after22, 200);


%% HRV for patient 3

 % HRV for patient 3 before seizure 1
[idxHRVbefore31, HRVbefore31, RRbefore31, idxRbefore31, HRbefore31] = getHRV(signal_before31, 200);

% % HRV for patient 3 during seizure 1
[idxHRVunder31, HRVunder31, RRunder31, idxRunder31, HRunder31] = getHRV(signal_under31, 200);

% HRV for patient 3 after seizure 1
[idxHRVafter31, HRVafter31, RRafter31, idxRafter31, HRafter31] = getHRV(signal_after31, 200);


 % HRV for patient 3 before seizure 2
[idxHRVbefore32, HRVbefore32, RRbefore32, idxRbefore32, HRbefore32] = getHRV(signal_before32, 200);

% % HRV for patient 3 during seizure 2
[idxHRVunder32, HRVunder32, RRunder32, idxRunder32, HRunder32] = getHRV(signal_under32, 200);

% HRV for patient 3 after seizure 2
[idxHRVafter32, HRVafter32, RRafter32, idxRafter32, HRafter32] = getHRV(signal_after32, 200);


%% HRV for patient 4

% HRV for patient 4 before seizure
[idxHRVbefore4, HRVbefore4, RRbefore4, idxRbefore4, HRbefore4] = getHRV(signal_before4, 200);

% % HRV for patient 4 during seizure
[idxHRVunder4, HRVunder4, RRunder4, idxRunder4, HRunder4] = getHRV(signal_under4, 200);

% HRV for patient 4 after seizure
[idxHRVafter4, HRVafter4, RRafter4, idxRafter4, HRafter4] = getHRV(signal_after4, 200);

%% HRV for patient 5

% HRV for patient 5 before seizure
[idxHRVbefore5, HRVbefore5, RRbefore5, idxRbefore5, HRbefore5] = getHRV(signal_before5, 200);

% % HRV for patient 5 during seizure
[idxHRVunder5, HRVunder5, RRunder5, idxRunder5, HRunder5] = getHRV(signal_under5, 200);

% HRV for patient 5 after seizure
[idxHRVafter5, HRVafter5, RRafter5, idxRafter5, HRafter5] = getHRV(signal_after5, 200);


%% HRV for patient 6

 % HRV for patient 6 before seizure 1
[idxHRVbefore61, HRVbefore61, RRbefore61, idxRbefore61, HRbefore61] = getHRV(signal_before61, 200);

% % HRV for patient 6 during seizure 1
[idxHRVunder61, HRVunder61, RRunder61, idxRunder61, HRunder61] = getHRV(signal_under61, 200);

% HRV for patient 6 after seizure 1
[idxHRVafter61, HRVafter61, RRafter61, idxRafter61, HRafter61] = getHRV(signal_after61, 200);


 % HRV for patient 6 before seizure 2
[idxHRVbefore62, HRVbefore62, RRbefore62, idxRbefore62, HRbefore62] = getHRV(signal_before62, 200);

% % HRV for patient 6 during seizure 2
[idxHRVunder62, HRVunder62, RRunder62, idxRunder62, HRunder62] = getHRV(signal_under62, 200);

% HRV for patient 6 after seizure 2
[idxHRVafter62, HRVafter62, RRafter62, idxRafter62, HRafter62] = getHRV(signal_after62, 200);

%% HRV for patient 7

% HRV for patient 7 before seizure
[idxHRVbefore7, HRVbefore7, RRbefore7, idxRbefore7, HRbefore7] = getHRV(signal_before7, 200);

% % HRV for patient 7 during seizure
[idxHRVunder7, HRVunder7, RRunder7, idxRunder7, HRunder7] = getHRV(signal_under7, 200);

% HRV for patient 7 after seizure
[idxHRVafter7, HRVafter7, RRafter7, idxRafter7, HRafter7] = getHRV(signal_after7, 200);


