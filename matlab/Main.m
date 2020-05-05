%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7 Weeks project                                               %
% Topic: Automatic detection and warning of epilepsy seizures   %
% Main script                                                   %
% Cours: 22056 Personal portable health technologies            %
% Author: Victor Holm s144765                                   %
% Last update: 23-03-2020                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
Fs = 200;           % sample freq.

% Godt link:
% https://epilepsychicago.org/epilepsy/seizure-types/partial-seizures/

% loading the data
ECG = LoadingData(); % Givs two plots, one with all patient and one with only patient p.
close all

% Freq. plot for one patient.
p=1;

Y = fft(ECG(p).data);
L = length(ECG(p).data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
% figure
% plot(f,P1) 
% title(sprintf('Single-Sided Amplitude Spectrum of ECG for patient %d', p))
% xlabel('f (Hz)')
% ylabel('|A_{ecg}(f)|')

%------------------------Pre Processing-----------------------------------%

% creating a notchb filter to remove 60Hz
wo = 60/(Fs/2);  
bw = wo/35;
[b,a] = iirnotch(wo,bw);
% Using bandpass function to design a bandpass filter 
for p=1:7
y = bandpass(ECG(p).data,[0.5 40],Fs); % bandpass filter
F_ECG(p).data = filter(b,a,y);      % notch filter
end
%
% plotting the data before and after the preprocessing
figure
for p=1:7

subplot(4,2,p)
t = 0:1/Fs:(length(ECG(p).data)-1)/Fs;
plot(t/60,ECG(p).data,'b')
hold on
plot(t/60,F_ECG(p).data,'Color',[0.8500 0.3250 0.0980])
plot([ECG(p).start(1)/60 ECG(p).start(1)/60],[min(ECG(p).data) max(ECG(p).data)], 'g');
plot([ECG(p).end(1)/60 ECG(p).end(1)/60],[min(ECG(p).data) max(ECG(p).data)], 'r');

if length(ECG(p).end)>1
    plot([ECG(p).start(2)/60 ECG(p).start(2)/60],[min(ECG(p).data) max(ECG(p).data)], 'g');
    plot([ECG(p).end(2)/60 ECG(p).end(2)/60],[min(ECG(p).data) max(ECG(p).data)], 'r');
end

xlabel('time [min]')
ylabel('Amplitude [mV]')
title(sprintf('Patient %d',p))
legend('Before preprocessing','After preprocessing')
hold off

end

%% selecting the before, during and after seizure data.
% one exsample on the selecting of seizure data.
p = 1;      % patient number
mint = 5;    % number minuttes 

indx_start = length(0:1/Fs:ECG(p).start);       % start index for seizure
indx_end = length(0:1/Fs:ECG(p).end);           % end index for seizure
indx_before = indx_start-length(0:1/Fs:mint*60);% before index for seizure
indx_after = indx_end+length(0:1/Fs:mint*60);   % after index for seizure

figure
subplot(2,3,1:3)
t = 0:1/Fs:(length(F_ECG(p).data)-1)/Fs;
plot(t(indx_before:indx_after)/60,F_ECG(p).data(indx_before:indx_after))
hold on
plot([ECG(p).start(1)/60 ECG(p).start(1)/60],[min(F_ECG(p).data(indx_before:indx_after)) max(F_ECG(p).data(indx_before:indx_after))], 'g');
plot([ECG(p).end(1)/60 ECG(p).end(1)/60],[min(F_ECG(p).data(indx_before:indx_after)) max(F_ECG(p).data(indx_before:indx_after))], 'r');
ylabel('Amplitude [mV]')
xlabel('time [min]')
title(sprintf('The hole signal for patient %d',p))

subplot(2,3,4)
plot(t(indx_before:indx_start)/60,F_ECG(p).data(indx_before:indx_start))
ylabel('Amplitude [mV]')
xlabel('time [min]')
title(sprintf('The signal %d before the seizure',mint))

subplot(2,3,5)
plot(t(indx_start:indx_end)/60,F_ECG(p).data(indx_start:indx_end))
ylabel('Amplitude [mV]')
xlabel('time [min]')
title(sprintf('The signal in the seizure'))

subplot(2,3,6)
plot(t(indx_end:indx_after)/60,F_ECG(p).data(indx_end:indx_after))
ylabel('Amplitude [mV]')
xlabel('time [min]')
title(sprintf('The signal %d after the seizure',mint))

% indx_matrix(1).before = indx_before;
% indx_matrix(1).start = indx_start;
% indx_matrix(1).end = indx_end;
% indx_matrix(1).after = indx_after;
% indx_matrix(1).patent = p;

% doing to the rest of the patient.
i = 0;
for p=1:length(ECG(:))
i = i + 1;
indx_matrix(i).start = length(0:1/Fs:ECG(p).start);       % start index for seizure
indx_matrix(i).end = length(0:1/Fs:ECG(p).end);           % end index for seizure
indx_matrix(i).before = indx_matrix(i).start-length(0:1/Fs:mint*60);% before index for seizure
indx_matrix(i).after = indx_matrix(i).end+length(0:1/Fs:mint*60);   % after index for seizure
indx_matrix(i).patent = p;

if length(ECG(p).start)>1
    i = i + 1;
    indx_matrix(i).start = length(0:1/Fs:ECG(p).start(2));       % start index for seizure
    indx_matrix(i).end = length(0:1/Fs:ECG(p).end(2));           % end index for seizure
    indx_matrix(i).before = indx_matrix(i).start-length(0:1/Fs:mint*60);% before index for seizure
    indx_matrix(i).after = indx_matrix(i).end+length(0:1/Fs:mint*60);   % after index for seizure
    indx_matrix(i).patent = p;
end
end

%% ----------------------Wavelet transform--------------------------------%
% making the wavelet transform on every interval before, doing and after
% and saving that in a new struck RR_signal.
% for p=1:length(indx_matrix)
%     pa = indx_matrix(p).patent;         % patient number
%     
%     [idxHRV, HRV, RR, idxR, HR, idxHR] = getHRV(F_ECG(pa).data(indx_matrix(p).before:indx_matrix(p).after), Fs);
%     RR_signal(p).idxHRV = idxHRV;
%     RR_signal(p).HRV = HRV;
%     RR_signal(p).RR = RR;
%     RR_signal(p).idxR = idxR;
%     RR_signal(p).HR = HR;
%     RR_signal(p).idxHR = idxHR;
%     RR_signal(p).patient = pa;
% end
%% Instead of doing all the abow, run the following section

load RR_signal

%% plotting the RR signal


five_minutte_vector_8Hz = length(0:1/8:mint*60);
five_minutte_vector_1Hz = length(0:mint*60);

p = 9;          % showing the RR-signal for the 9th seizure
%for p = 1:length(RR_signal.before)      % showing all patients
    figure
    subplot(3,1,1)
    plot(RR_signal(p).idxHRV,RR_signal(p).HRV)
    title(sprintf('HRV on patient %d',RR_signal(p).patient))
    hold on
    plot([RR_signal(p).idxHRV(five_minutte_vector_8Hz), RR_signal(p).idxHRV(five_minutte_vector_8Hz)],[min(RR_signal(p).HRV) max(RR_signal(p).HRV)],'g')
    plot([RR_signal(p).idxHRV(length(RR_signal(p).idxHRV)-five_minutte_vector_8Hz), RR_signal(p).idxHRV(length(RR_signal(p).idxHRV)-five_minutte_vector_8Hz)],[min(RR_signal(p).HRV) max(RR_signal(p).HRV)],'r')
    xlabel('Time [s]')
    ylabel('Heart Rate Variability')

    subplot(3,1,2)
    plot(RR_signal(p).idxR(1:end-1),RR_signal(p).RR)
    title(sprintf('RR on patient %d',RR_signal(p).patient))
    xlabel('Sample Index')

    subplot(3,1,3)
    plot(RR_signal(p).idxHR,RR_signal(p).HR)
    title(sprintf('HR on patient %d',RR_signal(p).patient))
    hold on
    plot([RR_signal(p).idxHR(five_minutte_vector_1Hz), RR_signal(p).idxHR(five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'g')
    plot([RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz), RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'r')
    ylabel('Heart rate [bpm]')
    xlabel('Time [s]')
%end


%% ---------------------Features extraction ------------------------------%

% Finding the linear phase of the Heart Rate signal
% First filtering the signal with a 15 long median filter.
n = 20;         % order of the filter

for i = 1:length(RR_signal)
RR_signal(i).HF_F = medfilt1(RR_signal(i).HR,n);
end

% for p = 1:length(RR_signal)     % p is the seizere number
%     LPF(p).patient = linearphase(RR_signal,p,five_minutte_vector_1Hz);
% end

%% calculating the time and freq. domain features:
% REMEMBER to if change is happing then change the calculation of true_clas
% this is done in the end of the section.
Fs = 1;
color = {'r','g','b','c','m','y','k'};
color_count = 0;

%p = 7; % seizre number
clear LPF freq_F time_F true_clas
for p=1:10
    [StartP, EndP] = windows(RR_signal(p).HF_F,16,3);

    figure  % plotting all the windows in the hole signal
    subplot(2,1,1)
    plot(RR_signal(p).idxHR,RR_signal(p).HF_F)
    xlabel('time [sek]')
    hold on
    % plotting the seizre area with stars
    plot([RR_signal(p).idxHR(five_minutte_vector_1Hz), RR_signal(p).idxHR(five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    plot([RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz), RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    hold off

    subplot(2,1,2) % plotting the linear phase 
    plot(RR_signal(p).idxHR,RR_signal(p).HF_F)
    xlabel('time [sek]')
    title(sprintf('seizre number %d',p))
    hold on
    % plotting the seizre area with stars
    plot([RR_signal(p).idxHR(five_minutte_vector_1Hz), RR_signal(p).idxHR(five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    plot([RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz), RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    hold off

    endpoint = 0;
    bpm_mean = 0;
    h=1;
    
    for i=1:length(StartP)
        color_count = color_count + 1;
        if color_count > 7
            color_count = 1;
        end
        
        % plotting each window
        if RR_signal(p).idxHR(five_minutte_vector_1Hz) < RR_signal(p).idxHR(StartP(i)) && RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz) > RR_signal(p).idxHR(EndP(i))
                        
            subplot(2,1,1)
            hold on
            plot([RR_signal(p).idxHR(StartP(i)) RR_signal(p).idxHR(StartP(i))],[min(RR_signal(p).HR) max(RR_signal(p).HR)],color{color_count})
            plot([RR_signal(p).idxHR(EndP(i))-1 RR_signal(p).idxHR(EndP(i))-1],[min(RR_signal(p).HR) max(RR_signal(p).HR)],color{color_count})    
            hold off
        else 
            true_clas(i,1,p) = 0;
        end

        % Finding out if the window is in the sezire area
        if RR_signal(p).idxHR(five_minutte_vector_1Hz) < StartP(i) && RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz) > EndP(i)
            time_F_seizre(i) = 1; % time_F_seizre tells if the time features is in the seizre area (then = 1) or not (then =0)
        else 
            time_F_seizre(i) = 0;
        end
        % taking the signal in the windowe area
        data = RR_signal(p).HF_F(StartP(i):EndP(i));
        t = RR_signal(p).idxHR(StartP(i):EndP(i));

        % calculating the linear phase features
        subplot(2,1,2)
        hold on
        
        [LPF(:,i,p), d, flag] = linearphase2(data,t,endpoint,bpm_mean,1);
        if LPF(:,1) > 0
            bpm_mean = 0;
            h = i + 4;
        else 
            bpm_mean = mean(RR_signal(p).HF_F(StartP(h):EndP(i)));
        end
        endpoint = d;
        if flag == 1
            % calculating the time domain features
            time_F(:,i,p) = timeFeatures_extration(data);
            % calculating the freq. domain features
            freq_F(:,i,p) = Frequency_features(data,Fs,0);
        end
        hold off
    end
end
true_clas = transpose([1 0 1 0 1 1 0 0 1 1 1 1 1]);

%% putting all the features together
LPF(LPF==0)=[];
LPF_data = transpose(reshape(LPF,7,size(LPF,2)/7));

freq_F(freq_F==0)=[];
freq_F_data = transpose(reshape(freq_F,7,size(freq_F,2)/7));

time_F(time_F==0)=[];
time_F_data = transpose(reshape(time_F,7,size(time_F,2)/7));

data_matrix=[time_F_data freq_F_data LPF_data true_clas];
data_matrix(end,:)=[];
% %% Removing some of the features
% data_matrix(:,15)=[];
% data_matrix(:,13)=[];
% data_matrix(:,12)=[];
% data_matrix(:,10)=[];
% data_matrix(:,9)=[];
% data_matrix(:,8)=[];
% data_matrix(:,7)=[];
% data_matrix(:,5)=[];
% data_matrix(:,3)=[];
% data_matrix(:,2)=[];
% data_matrix(:,1)=[];


%% Testing the classifier

fs =200;
p = 10;       % Here the last patient is selected
pa = indx_matrix(p).patent;         % patient number

[idxHRV, HRV, RR, idxR, HR, idxHR] = getHRV(F_ECG(pa).data, fs);
test_RR_signal.idxHRV = idxHRV;
test_RR_signal.HRV = HRV;
test_RR_signal.RR = RR;
test_RR_signal.idxR = idxR;
test_RR_signal.HR = HR;
test_RR_signal.idxHR = idxHR;
test_RR_signal.patient = pa;
%
test_data = Classifier_KNN(test_RR_signal);


%% Leave one out training for classifier SVM
X = data_matrix(:,1:end-1);
Y = true_clas(1:end-1,:);
SVMModel = fitcsvm(X,Y,'Standardize',true,'ClassNames',[-1,1]);
CVSVMModel = crossval(SVMModel,'Leaveout','on');
TrainedModel = CVSVMModel.Trained{1};
label = predict(TrainedModel,test_data);
sprintf('The classifier predict the class to be %d',label)

%% Get predicted classes
clc
for i = 1:size(X,1)
    YPredict(i) = predict(CVSVMModel.Trained{8},X(i,:));
end
YPredict


%% Frequency features
% % load test signal in
% close all
% load Gamle_RR_signal
% load Gamle_RR_signal_time
% 
% % plotting the signal
% figure
% plot(t_vq2,vq2)
% title('Gamle RR-interval signal (test signal)')
% xlabel('time [s]')
% ylabel('R-peak')
% Fs =  8;
% 
% FreqFeatures = Frequency_features(vq2,Fs);



