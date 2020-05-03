function [test_data]=Classifier_KNN(test_RR_signal)
% function Classifier_SVM(test_RR_signal)
% this classifier gets a input HR signal and predict when the seizure is
% happining. Before runnning this function make sure to have loaded the classifier model name: "KNN_833_9p_5f"

    n = 20;         % order of the filter
    test_RR_signal.HF_F = medfilt1(test_RR_signal.HR,n);

    Fs = 1;
    color = {'r','g','b','c','m','y','k'};
    color_count = 0;

    %p = 7; % seizre number
    clear LPF freq_F time_F true_clas

    [StartP, EndP] = windows(test_RR_signal.HF_F,16,3);

    figure  % plotting all the windows in the hole signal
    subplot(2,1,1)
    plot(test_RR_signal.idxHR,test_RR_signal.HF_F)
    xlabel('time [sek]')
    title('test signal')
    %hold on
    % plotting the seizre area with stars
    %plot([RR_signal(p).idxHR(five_minutte_vector_1Hz), RR_signal(p).idxHR(five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    %plot([RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz), RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    %hold off

    subplot(2,1,2) % plotting the linear phase 
    plot(test_RR_signal.idxHR,test_RR_signal.HF_F)
    xlabel('time [sek]')
    title(sprintf('patient number %d',test_RR_signal.patient))
    %hold on
    % plotting the seizre area with stars
    %plot([RR_signal(p).idxHR(five_minutte_vector_1Hz), RR_signal(p).idxHR(five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    %plot([RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz), RR_signal(p).idxHR(length(RR_signal(p).idxHR)-five_minutte_vector_1Hz)],[min(RR_signal(p).HR) max(RR_signal(p).HR)],'*')
    %hold off

    endpoint = 0;
    bpm_mean = 0;
    h=1;

    for i=1:length(StartP)
        color_count = color_count + 1;
        if color_count > 7
            color_count = 1;
        end

        % plotting each window
        subplot(2,1,1)
    %     hold on
    %     plot([test_RR_signal.idxHR(StartP(i)) test_RR_signal.idxHR(StartP(i))],[min(test_RR_signal.HF_F) max(test_RR_signal.HF_F)],color{color_count})
    %     plot([test_RR_signal.idxHR(EndP(i))-1 test_RR_signal.idxHR(EndP(i))-1],[min(test_RR_signal.HF_F) max(test_RR_signal.HF_F)],color{color_count})    
    %     hold off

        % taking the signal in the windowe area
        data = test_RR_signal.HF_F(StartP(i):EndP(i));
        t = test_RR_signal.idxHR(StartP(i):EndP(i));

        % calculating the linear phase features
        subplot(2,1,2)
        hold on

        [LPF(:,i), d, flag] = test_linearphase2(data,t,endpoint,bpm_mean,1);
        if LPF(:,1,1) > 0
            bpm_mean = 0;
            h = i + 4;
        else 
            bpm_mean = mean(test_RR_signal.HF_F(StartP(h):EndP(i)));
        end
        endpoint = d;
        if flag == 1
            % calculating the time domain features
            time_F(:,i,1) = test_timeFeatures_extration(data);
            % calculating the freq. domain features
            freq_F(:,i,1) = test_Frequency_features(data,Fs,0);
        end
        hold off
    end

    LPF(LPF==0)=[];
    LPF_data = transpose(reshape(LPF,7,size(LPF,2)/7));

    freq_F(freq_F==0)=[];
    freq_F_data = transpose(reshape(freq_F,7,size(freq_F,2)/7));

    time_F(time_F==0)=[];
    time_F_data = transpose(reshape(time_F,7,size(time_F,2)/7));

    test_data=[time_F_data freq_F_data LPF_data];

    load KNN_833_9p_5f
    
    clc
    c = trainedModel_KNN_833_5f.predictFcn(test_data);
    sprintf('The classifier predict the class to be %d',c)
end
