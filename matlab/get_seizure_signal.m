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
title('5 minutter før seizuret sker')

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
signal_before2 = F_ECG(2).data(indx_matrix(2).before:indx_matrix(2).start);
% tallet (1) betyder at man tager den værdi som er i første række i 
% matrixen indx_matrix. Så indx_matrix(1).before = 115200 og 
% indx_matrix(2).before = 692600. 

% For hvisning af signalet før seizuren
Fs = 200;
t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector
t_signal_before2 = t2(indx_matrix(2).before:indx_matrix(2).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(4)
plot(t_signal_before2,signal_before2)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under2 = F_ECG(2).data(indx_matrix(2).start:indx_matrix(2).end);
t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector
t_signal_under2 = t2(indx_matrix(2).start:indx_matrix(2).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(5)
plot(t_signal_under1,signal_under1)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after2 = F_ECG(2).data(indx_matrix(2).end:indx_matrix(2).after);
t2 = 0:1/Fs:(length(F_ECG(2).data)-1)/Fs;   % første laves en tids vector
t_signal_after2 = t2(indx_matrix(2).end:indx_matrix(2).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(6)
plot(t_signal_after2,signal_after2)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 3

signal_before3 = F_ECG(3).data(indx_matrix(3).before:indx_matrix(3).start);

% For hvisning af signalet før seizuren
Fs = 200;
t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_before3 = t3(indx_matrix(3).before:indx_matrix(3).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(7)
plot(t_signal_before3,signal_before3)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under3 = F_ECG(3).data(indx_matrix(3).start:indx_matrix(3).end);
t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_under3 = t3(indx_matrix(3).start:indx_matrix(3).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(8)
plot(t_signal_under3,signal_under3)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after3 = F_ECG(3).data(indx_matrix(3).end:indx_matrix(3).after);
t3 = 0:1/Fs:(length(F_ECG(3).data)-1)/Fs;   % første laves en tids vector
t_signal_after3 = t3(indx_matrix(3).end:indx_matrix(3).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(9)
plot(t_signal_after3,signal_after3)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 4

signal_before4 = F_ECG(4).data(indx_matrix(4).before:indx_matrix(4).start);

% For hvisning af signalet før seizuren
Fs = 200;
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_before4 = t4(indx_matrix(4).before:indx_matrix(4).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(10)
plot(t_signal_before4,signal_before4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under4 = F_ECG(4).data(indx_matrix(4).start:indx_matrix(4).end);
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_under4 = t4(indx_matrix(4).start:indx_matrix(4).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(11)
plot(t_signal_under4,signal_under4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after4 = F_ECG(4).data(indx_matrix(4).end:indx_matrix(4).after);
t4 = 0:1/Fs:(length(F_ECG(4).data)-1)/Fs;   % første laves en tids vector
t_signal_after4 = t4(indx_matrix(4).end:indx_matrix(4).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(12)
plot(t_signal_after4,signal_after4)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 5

signal_before5 = F_ECG(5).data(indx_matrix(5).before:indx_matrix(5).start);

% For hvisning af signalet før seizuren
Fs = 200;
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_before5 = t5(indx_matrix(5).before:indx_matrix(5).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(13)
plot(t_signal_before5,signal_before5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under5 = F_ECG(5).data(indx_matrix(5).start:indx_matrix(5).end);
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_under5 = t5(indx_matrix(5).start:indx_matrix(5).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(14)
plot(t_signal_under5,signal_under5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after5 = F_ECG(3).data(indx_matrix(3).end:indx_matrix(3).after);
t5 = 0:1/Fs:(length(F_ECG(5).data)-1)/Fs;   % første laves en tids vector
t_signal_after5 = t5(indx_matrix(5).end:indx_matrix(5).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(15)
plot(t_signal_after5,signal_after5)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 6

signal_before6 = F_ECG(6).data(indx_matrix(6).before:indx_matrix(6).start);

% For hvisning af signalet før seizuren
Fs = 200;
t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector
t_signal_before6 = t6(indx_matrix(6).before:indx_matrix(6).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(16)
plot(t_signal_before6,signal_before6)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under6 = F_ECG(6).data(indx_matrix(6).start:indx_matrix(6).end);
t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector
t_signal_under6 = t6(indx_matrix(6).start:indx_matrix(6).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(17)
plot(t_signal_under6,signal_under6)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after6 = F_ECG(6).data(indx_matrix(6).end:indx_matrix(6).after);
t6 = 0:1/Fs:(length(F_ECG(6).data)-1)/Fs;   % første laves en tids vector
t_signal_after6 = t6(indx_matrix(6).end:indx_matrix(6).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(18)
plot(t_signal_after6,signal_after6)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')

%% patient 7

signal_before7 = F_ECG(7).data(indx_matrix(7).before:indx_matrix(7).start);

% For hvisning af signalet før seizuren
Fs = 200;
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_before7 = t7(indx_matrix(7).before:indx_matrix(7).start); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(19)
plot(t_signal_before7,signal_before7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter før seizuret sker')

% samme princip kan nu laves med under og efter seizuren
% først laves for under anfaldet:
signal_under7 = F_ECG(7).data(indx_matrix(7).start:indx_matrix(7).end);
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_under7 = t7(indx_matrix(7).start:indx_matrix(7).end); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(20)
plot(t_signal_under7,signal_under7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('seizuret')

% nu laves for efter seizuren
signal_after7 = F_ECG(7).data(indx_matrix(7).end:indx_matrix(7).after);
t7 = 0:1/Fs:(length(F_ECG(7).data)-1)/Fs;   % første laves en tids vector
t_signal_after7 = t7(indx_matrix(7).end:indx_matrix(7).after); % nu reduceres tids vectoren kun til det vi gerne vil vise

figure(21)
plot(t_signal_after7,signal_after7)
xlabel('tid [sekunder]')
ylabel('Voltage')
title('5 minutter efter seizuret er sket')


