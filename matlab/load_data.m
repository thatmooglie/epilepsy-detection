clear all

filename = "data\post-ictal-heart-rate-oscillations-in-partial-epilepsy-1.0.0\sz01.dat";

Fs = 200;
ts = 1/200;
fileID = fopen(filename);
OneByte = fread(fileID, 'ubit12');
signal = double(OneByte);
t = [0:ts:(length(signal)-1)/Fs]';

plot(t,signal)
xlabel('time ')
ylabel('amplitude')