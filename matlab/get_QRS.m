function [R_ind_post_processing,QRS_on_post_processing,QRS_off_post_processing,RR,ecg_out] = get_QRS( ecg,fs,gr )
%GET_QRS This function gets as input an ECG signal and returns back the
%position of the R wave, QRS onset and QRS offset
%
%---INPUT---
%ecg = the ECG signal
%fs = the sampling freqeuncy
%gr = when set to 1, the plots are displayed, when set to 0 they are not
%displayed
%
%---OUTPUT---
%R_ind_post_processing = position of the R waves
%QRS_on_post_processing = position of the QRS onset 
%QRS_off_post_processing = position of the QRS offset
%RR = RR intervals
%ecg_out = ECG signal that is resized for calculating the SWT
% Original Code: Matteo Cesari, 2016, Edited by: Bragi Marin?sson

%--INITIALIZATION OF THE VARIABLES-----------------------------------------
R_ind = [];
QRS_on = [];
QRS_off = [];
RR = [];
%--------------------------------------------------------------------------

%--COMPUTATION OF THE SWT--------------------------------------------------
N = length(ecg);
if rem(N,2^4)~=0 %Signal length reduced to a power of 2
    l=N-rem(N,2^4);
    ecg=ecg(1:l);
end

N = length(ecg); % New ECG length
time = [0:1/fs:N/fs-1/fs]; %Time useful for plots
ecg_out = ecg; % ECG after resize
WT=swt(ecg,4,'db3'); %The wavelet transform is calculated
WT_6 = WT(4,:); %The scale 4 is used
% [c,l] = wavedec(ecg,4,'db3');
% D = detcoef(c,l,'db3'); 
% WT_6 = D{4};

if gr % Plotting
    figure
    plot(time,ecg)
    hold on
    plot(time,WT_6);
    plot(time,zeros(1,length(time)))
    title('ECG after denoising and 5th scale WT (db1)')
    xlabel('Time [s]')
    ylabel('Amplitude [mV]')
    legend('ECG','SWT 3rd and 4th level','Zero level')
end
%--------------------------------------------------------------------------

%--SELECTION OF THE AREAS WHERE THE QRS COMPLEXES ARE EXPECTED-------------

squared_WT_6 = WT_6.^2; % Squaring the signal

x_kernel = [-5*0.16*fs:5*0.16*fs]; %Definition of the Gaussian kernel
kernel = normpdf(x_kernel,0,0.1*fs);

convolved = conv(squared_WT_6,kernel,'same'); %Convolution

%The peaks of the convolved signal are found and the noisy peaks are
%removed
[pks,locs_pks] = findpeaks(convolved);
n_pks = 10; %The peaks are divided into sets of 10 peaks
number_division = ceil(length(pks)/n_pks);
to_delete = []; %Keeps track of the peaks to remove
for i = 1:number_division-1
    indices = 1+(i-1)*n_pks:i*n_pks;
    selected_pks = pks(indices);
    threshold = 0.1*rms(selected_pks); %Threshold for removing a peak
    to_delete = [to_delete indices(selected_pks<threshold)];
end
%Last set: the threshold is different and set to 0.25*median_selected_peaks
indices = 1+(number_division)*n_pks:length(pks);
selected_pks = pks(indices);
median_selected_pks = median(selected_pks);
to_delete = [to_delete indices(selected_pks<0.25*median_selected_pks)];
%Plot of the selected peaks and the peaks that have to be removed
if gr
    figure
    plot(time,ecg)
    hold on 
    plot(time,convolved,'r-')
    plot(locs_pks/fs,pks,'k*','MarkerSize',8)
    plot(locs_pks(to_delete)/fs,convolved(locs_pks(to_delete)),'ko','MarkerSize',8,'MarkerFaceColor','k')
    xlabel('Time [s]')
    ylabel('Amplitude [mV]')
    legend('ECG','ConvWT6','Peaks considered','Peaks removed')
 end

pks(to_delete) = []; %Noisy peaks are deleted
locs_pks(to_delete) = [];

%Selection of the window start and ending points
window_start = round(locs_pks-0.09*fs);
window_start(window_start<1) = 1;
window_end = round(locs_pks+0.09*fs);
window_end(window_end>length(convolved))=length(convolved);

%Definition of the windows
windows = [];
for i=1:length(locs_pks)
    windows{i}(1,:) = window_start(i):window_end(i);
end

if gr %Plotting the windows
    figure
    plot(convolved)
    hold on
    plot(ecg)
    plot(1:length(ecg),zeros(1,length(ecg)))
    plot(WT_6)
    plot(locs_pks,pks,'r*')
    plot(window_start,convolved(window_start),'go')
    plot(window_end,convolved(window_end),'ko')
end
%--------------------------------------------------------------------------

%--DELINEATION OF THE R PEAKS, QRS ONSET AND OFFSET------------------------

%Calculating all the zero-crossings of the WT6
WT_6_sign = sign(WT_6);
diff_WT_6_sign = diff(WT_6_sign);
zero_crossings = find(diff_WT_6_sign ~= 0);

%Definition of the pairs of peaks and find the R peak and QRS
for i=1:size(windows,2)
    window_selected = windows{1,i}(:); %Selection of the window
    WT_6_window = WT_6(1,window_selected);
    ecg_window = ecg(window_selected); %ECG in the window
    %The positive and negative peaks are found
    [pos_pks,locs_pos_pks] = findpeaks(WT_6_window);
    [neg_pks,locs_neg_pks] = findpeaks(-WT_6_window);
    neg_pks = -neg_pks;
    
    pairs = []; %In this matrix the pair are in the order: positive followed by negative 
    k = 1;
    
    for p = 1:length(pos_pks)
        for j = 1:length(neg_pks)
            abs_distance = abs(locs_pos_pks(p)-locs_neg_pks(j));
            if abs_distance<0.3*fs %Check that they are inside the window
                pairs(k,1) = locs_pos_pks(p);
                pairs(k,2) = locs_neg_pks(j);
                k = k + 1;
            end
        end
    end
    
    if ~isempty(pairs) %The QRS complex can be defined only if the pairs are not empty
        %Initializiation of the variables
       candidate_R_wave = zeros(1,size(pairs,1));
       index_candidate_R_wave = zeros(1,size(pairs,1));
       s = zeros(1,size(pairs,2)); % Initialization of the index s

        for m = 1:size(pairs,1) %Analysis done for each pair of peaks
            position_positive = pairs(m,1);
            position_negative = pairs(m,2);

            if position_positive<position_negative % A positive R peaks is expected in this case
                [candidate_R_wave(m),index] = max(ecg_window(position_positive:position_negative));
                index_candidate_R_wave(m) = position_positive+index;
                %Calculation of the s index
                s(m) = abs(ecg_window(index_candidate_R_wave(m)))+abs(WT_6_window(position_positive))+abs(WT_6_window(position_negative));
            else %Negative R peak expected 
                [candidate_R_wave(m),index] = min(ecg_window(position_negative:position_positive));
                index_candidate_R_wave(m) = position_negative+index;
                %Calculation of the s index
                s(m) = abs(ecg_window(index_candidate_R_wave(m)))+abs(WT_6_window(position_positive))+abs(WT_6_window(position_negative));               
            end
        end
        %The maximum s is associated with the R peak
        [~,position] = max(s);
        R_ind(i) = window_selected(1) + index_candidate_R_wave(position) - 2; %Position of the R peak
        
        %Now the QRS onset (offset) is selected as the zero crossing before
        %(after) the first (last) significant slope of the QRS.
        position_positive = pairs(position,1);
        position_negative = pairs(position,2);
        
        if position_positive<position_negative %Positive R peak
            point_on = position_positive + window_selected(1) - 2; %Position postive peak
            zero_crossing_on = find(zero_crossings<point_on);
            if ~isempty(zero_crossing_on)
                QRS_on(i) = zero_crossings(zero_crossing_on(end));
            else
                QRS_on(i) = NaN;
            end
            
            point_off = position_negative + window_selected(1) - 2; %Position negative peak
            zero_crossing_off = find(zero_crossings>point_off);
            if ~isempty(zero_crossing_off)
                QRS_off(i) = zero_crossings(zero_crossing_off(1));
            else
                QRS_off(i) = NaN;
            end
        else %Negative R peak
            point_on = position_negative + window_selected(1) - 2;
            zero_crossing_on = find(zero_crossings<point_on);
            if ~isempty(zero_crossing_on)
                QRS_on(i) = zero_crossings(zero_crossing_on(end));
            else
                QRS_on(i) = NaN;
            end
            
            point_off = position_positive + window_selected(1) - 2;
            zero_crossing_off = find(zero_crossings>point_off);
            if ~isempty(zero_crossing_off)
                QRS_off(i) = zero_crossings(zero_crossing_off(1));
            else
                QRS_off(i) = NaN;
            end
        end

    end
    
end    
%--------------------------------------------------------------------------

%--POST PROCESSING---------------------------------------------------------

%Removal of errors due to incorrect indexing
R_ind(R_ind==0) = [];
QRS_on(QRS_on==0) = [];
QRS_off(QRS_off==0) = [];
%Defintion of the variables
R_ind_post_processing = [];
QRS_on_post_processing = [];
QRS_off_post_processing = [];
i = 1; %Keeps track in the while loop

RR_pre_processing = diff(R_ind); %RR intervals
l = 21; %Set of RR intervals to consider
while i<= length(RR_pre_processing)
    %Selection of the RR intervals that are around the selected that has to
    %be analysed
    if i<=l
        selected_beats = R_ind(1:i+l);
    elseif i>=length(RR_pre_processing)-l
        selected_beats = R_ind(i-l:length(R_ind));
    else
        selected_beats = R_ind(i-l+1:i+l-1);
    end
    
    median_length = median(diff(selected_beats)); %Median of teh RR values
    
    this_distance = R_ind(i+1)-R_ind(i); %RR interval that is studied
    
    %One of the 2 conditions has to be met to consider the RR interval
    %wrong: RR interval less than 0.4 the median of the preceding and
    %following OR less than the refractory period 0.25 ms
    if this_distance<0.4*median_length || this_distance<0.25*fs
        ecg_this_beat = ecg(R_ind(i));
        ecg_next_beat = ecg(R_ind(i+1));
        %Only the beat with highest absolute value is kept
        if abs(ecg_this_beat) > abs(ecg_next_beat)
            R_ind_post_processing(i) = R_ind(i);
            QRS_on_post_processing(i) = QRS_on(i);
            QRS_off_post_processing(i) = QRS_off(i);
        else
            R_ind_post_processing(i) = R_ind(i+1);
            QRS_on_post_processing(i) = QRS_on(i+1);
            QRS_off_post_processing(i) = QRS_off(i+1);
        end
        %Not consider the other beat
        i = i + 2;
    else %Continue the analysis
        R_ind_post_processing(i) = R_ind(i);
        QRS_on_post_processing(i) = QRS_on(i);
        QRS_off_post_processing(i) = QRS_off(i);
        i = i + 1;
    end
end
%Correcting wrong indices
R_ind_post_processing(end+1) = R_ind(end);
QRS_on_post_processing(end+1) = QRS_on_post_processing(end);
QRS_off_post_processing(end+1) = QRS_off_post_processing(end);
R_ind_post_processing(R_ind_post_processing==0) = [];
QRS_on_post_processing(QRS_on_post_processing==0) = [];
QRS_off_post_processing(QRS_off_post_processing==0) = [];
%Definition of RR intervals
RR = diff(R_ind_post_processing);

%Plotting the detected fiducial points
if gr
    figure
    plot(ecg)
    hold on
    plot(R_ind_post_processing,ecg(R_ind_post_processing),'r*')
    plot(QRS_on_post_processing(~isnan(QRS_on_post_processing)),ecg(QRS_on_post_processing(~isnan(QRS_on_post_processing))),'m*')
    plot(QRS_off_post_processing(~isnan(QRS_off_post_processing)),ecg(QRS_off_post_processing(~isnan(QRS_off_post_processing))),'g*')
end
%--------------------------------------------------------------------------       
end

