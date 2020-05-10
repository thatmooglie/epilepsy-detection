
close all
load sz07m.mat
L = 2*2048;
fs_hrv = 8;
start = 165000;
wSize = 2^15;
[idxHRV, HRV, RR, idxR, HR] = getHRV(-val, 200);
[R_ind_post_processing,QRS_on_post_processing,QRS_off_post_processing,RR,ecg_out] = get_QRS( -val,200,0 );
testData = val;
%WT=swt(testData,4,'db3');
%[c,l] = wavedec(testData,4,'db3');
%D = detcoef(c,l,'db3');

[qrs_amp_raw,qrs_i_raw,delay]= pan_tompkin(-testData,200,0);
%%
[b,a] = butter(6, 40/100, 'low');
x = filter(b,a,-testData);
[b,a] = butter(9, 5/100, 'high');
xx = filter(b,a,x);
plot(xx)
%%
testData = val(810000:840000);
fileID = fopen('testData.txt', 'w')
for i=1:length(testData)
    fprintf(fileID, '%f\n', -testData(i));
end
fclose(fileID);

