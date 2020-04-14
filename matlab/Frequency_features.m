function FreqFeatures = Frequency_features(vq2,Fs)
% vq2 er signalet i tidsdomainet
% Fs er sampling freq. på signalet vq2.
% HUSK at bandpower funktion skal måske laves omm hvis længden af signalet
% er ulige. HUSK at tjekke det.
% Den første figur er FFT spectrum af signal
% Den anden figur er power spectrumet af signalet.
% De grønne strege er skelelinerne mellem low, middel og upper limit. Det
% kan ændre ved at ændre på variable navne: LowLimit, UpperLimit og Middel


Y = fft(vq2);
L = length(vq2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

LowLimit = 0.04;
UpperLimit = 0.4;
Middel = 0.15;

f = Fs*(0:(L/2))/L;
figure
plot(f,P1) 
xlim([0 0.5])
hold on
plot([LowLimit LowLimit],[0 0.1],'-g')
plot([Middel Middel],[0 0.1],'-g')
plot([UpperLimit UpperLimit],[0 0.1],'-g')
title('Single-Sided Amplitude Spectrum of RR-signal')
xlabel('f (Hz)')
ylabel('|A_{RR}(f)|')

%w = 1000; % lenght of window
%ov = 0.5; % procentage of overlapping
[pxx,f]= pwelch(vq2,Fs);

figure
plot(f,10*log10(pxx))
xlim([0 0.5])
hold on
plot([LowLimit LowLimit],[-5 5],'-g')
plot([Middel Middel],[-5 5],'-g')
plot([UpperLimit UpperLimit],[-5 5],'-g')
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')   

LF = bandpower(vq2,Fs,[LowLimit Middel]);
HF = bandpower(vq2,Fs,[Middel UpperLimit]);
tot_p = bandpower(vq2,Fs,[0 UpperLimit]);
VLF = bandpower(vq2,Fs,[0 LowLimit]);

LFHF = LF/HF;
LFnorm = LF/(tot_p * 100);
HFnorm = HF/(tot_p * 100);

FreqFeatures.LF = LF;
FreqFeatures.HF = HF;
FreqFeatures.tot_p = tot_p;
FreqFeatures.VLF = VLF;
FreqFeatures.LFHF = LFHF;
FreqFeatures.LFnorm = LFnorm;
FreqFeatures.HFnorm = HFnorm;

end