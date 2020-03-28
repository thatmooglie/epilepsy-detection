clear all
close all
load sz01m.mat
get_QRS(val,200,1)
%%
bsFilt = designfilt('bandstopiir','FilterOrder',80, ...
         'HalfPowerFrequency1',59.9,'HalfPowerFrequency2',60.1, ...
         'SampleRate',200);
val = filter(bsFilt, -val);
bpFilt = designfilt('bandpassfir','FilterOrder',64, ...
         'CutoffFrequency1',0.5,'CutoffFrequency2',40, ...
         'SampleRate',200);
val = filter(bpFilt, val);
start = 24500;
WT = swt(val(start: start+2^10-1),4,'db1');
c = corr(val(start: start+2^10-1)', WT');

x = abs(WT(3,:).*WT(4,:));
subplot(211)
plot(x)
subplot(212)
plot(val(start:start+2^10-1))

%%[R_ind_post_processing,QRS_on_post_processing,QRS_off_post_processing,RR,ecg_out] = get_QRS(val,200,1);