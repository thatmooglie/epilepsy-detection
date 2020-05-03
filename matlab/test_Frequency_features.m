function FreqFeatures = test_Frequency_features(vq2,Fs,i)
% function: FreqFeatures = Frequency_features(vq2,Fs,i)
% calculate the frequency domain features in a signal.
% -------- input ----------
% [vector]  vq2     (signal in the time domian)
% [int]     Fs      (sample freq.)
% [int]     i       (do you want to see plots (yes = 1, no = 0))
% -------- Outout --------
% [vector] FreqFeatures     (vector with the first element as LF, then HF, total power, VLF, LFHF, LFnorm and the last element is HFnorm)



Y = fft(vq2);
L = length(vq2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

LowLimit = 0.04;
UpperLimit = 0.4;
Middel = 0.15;
f = Fs*(0:(L/2))/L;

%w = 1000; % lenght of window
%ov = 0.5; % procentage of overlapping
[pxx,f2]= pwelch(vq2,[],[],[],Fs);

if i ==1
    figure
    subplot(2,1,1)
    plot(f,P1) 
    %xlim([0 0.5])
    hold on
    plot([LowLimit LowLimit],[0 0.1],'-g')
    plot([Middel Middel],[0 0.1],'-g')
    plot([UpperLimit UpperLimit],[0 0.1],'-g')
    title('Single-Sided Amplitude Spectrum of RR-signal')
    xlabel('f (Hz)')
    ylabel('|A_{RR}(f)|')

    subplot(2,1,2)
    plot(f2,10*log10(pxx))
    %xlim([0 0.5])
    hold on
    plot([LowLimit LowLimit],[-5 5],'-g')
    plot([Middel Middel],[-5 5],'-g')
    plot([UpperLimit UpperLimit],[-5 5],'-g')
    xlabel('Frequency (Hz)')
    ylabel('PSD (dB/Hz)')   
end

% LF = bandpower(vq2,Fs,[LowLimit Middel]);
% HF = bandpower(vq2,Fs,[Middel UpperLimit]);
% tot_p = bandpower(vq2,Fs,[0 UpperLimit]);
% VLF = bandpower(vq2,Fs,[0 LowLimit]);

LF = sum(pxx(find(abs(f2-LowLimit) < 0.002):find(abs(f2-Middel) < 0.002)));
HF = sum(pxx(find(abs(f2-Middel) < 0.002):find(abs(f2-UpperLimit) < 0.002)));
tot_p = sum(pxx(1:find(abs(f2-UpperLimit) < 0.002)));
VLF = sum(pxx(1:find(abs(f2-LowLimit) < 0.002)));


LFHF = LF/HF;
LFnorm = (LF/tot_p) * 100;
HFnorm = (HF/tot_p) * 100;

% FreqFeatures.LF = LF;
% FreqFeatures.HF = HF;
% FreqFeatures.tot_p = tot_p;
% FreqFeatures.VLF = VLF;
% FreqFeatures.LFHF = LFHF;
% FreqFeatures.LFnorm = LFnorm;
% FreqFeatures.HFnorm = HFnorm;


FreqFeatures(1) = LF;
FreqFeatures(2) = HF;
FreqFeatures(3) = tot_p;
FreqFeatures(4) = VLF;
FreqFeatures(5) = LFHF;
FreqFeatures(6) = LFnorm;
FreqFeatures(7) = HFnorm;
end