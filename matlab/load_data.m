
%close all
load sz01m.mat
L = 2*2048;
fs_hrv = 8;
start = 165000;
wSize = 2^15;
%[idxHRV, HRV, RR, idxR, HR] = getHRV(val, 200);
testData = val(1:2^15);
%WT=swt(testData,4,'db3');
%[c,l] = wavedec(testData,4,'db3');
%D = detcoef(c,l,'db3');

[qrs_amp_raw,qrs_i_raw,delay]= pt(testData,200,1);
%%
fileID = fopen('testData.txt', 'w')
for i=1:length(testData)
    fprintf(fileID, '%f\n', testData(i));
end
fclose(fileID);
