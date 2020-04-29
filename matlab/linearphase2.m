function [LPF, endpoint flag] = linearphase2(signal,time,endpoint,bpm_mean,i)
% function: [LPF] = linearphase2(signal,time,StartP,EndP)
% This function calculates the linear phase on the input signal, and return
% all the features in an vector LPF. 
% ---------- Input -----------
% [vector]  signal   (this is the signal where the linear phase is calculated
% on)
% [vector]  time     (this is the time signal for the input signal)
% [int]     endpoint (this is the endpoint from the previous linear phase, when
% first used then value = 0)
% [int]     bpm_mean (this is the mean of the signal before the windowe)
% [int]     i        (this is a plot variable. Set to 1 for plot)
% ---------- Output ---------
% [vector]  LPF      (vector with all the features in it)
% [int]     endpoint (this is the endpoint from the calculated linear phase)


    data = signal;
    t = time;
    n = 1;
    linear_HRsig_test = polyfit(min(data),max(data),n);
    ind_max = find(data == max(data));
    ind_min = find(data == min(data));
    lengt = ind_max(1) - ind_min(end);
    Linaer_phase_sig_t = t(ind_min(end):ind_max(1));
    Linaer_phase_sig = data(ind_min(end):ind_max(1));
    flag = 0;

    %sprintf('linear_HRsig_test = %d, max(data) = %d and lengt = %d',linear_HRsig_test(1,1),max(data),lengt)
    if linear_HRsig_test(1,1) > 1.1 && (max(data)-bpm_mean) > 15 && lengt > 12 && bpm_mean > 0 && max(data) > 80
        sprintf('after first if-statment, endpoint = %d',endpoint)
        if endpoint > 1
            diff = (Linaer_phase_sig_t(1) - endpoint);
            sprintf('diff = %d', diff)
            if diff > 150
                endpoint = Linaer_phase_sig_t(end);
                
                flag = 1;
                LPF(1) = max(Linaer_phase_sig);
                LPF(2) = Linaer_phase_sig(1);
                LPF(3) = lengt;
                LPF(4) = mean(Linaer_phase_sig);
                LPF(5) = std(Linaer_phase_sig);
                LPF(6) = data(1);
                LPF(7) = max(Linaer_phase_sig)/data(1);
                if i == 1
                    plot(Linaer_phase_sig_t,Linaer_phase_sig,'-*')
                end
            end
        else
            sprintf('endpoint < 1')
            endpoint = Linaer_phase_sig_t(end);
            
            flag = 1;
            LPF(1) = max(Linaer_phase_sig);
            LPF(2) = Linaer_phase_sig(1);
            LPF(3) = lengt;
            LPF(4) = mean(Linaer_phase_sig);
            LPF(5) = std(Linaer_phase_sig);
            LPF(6) = data(1);
            LPF(7) = max(Linaer_phase_sig)/data(1);
            if i == 1
                plot(Linaer_phase_sig_t,Linaer_phase_sig,'-*')
            end
        end 
    end
    if flag ==  0 
        LPF = zeros(7,1);
    end

end