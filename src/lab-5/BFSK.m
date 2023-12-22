clc, clear, format compact


run("../lab-3/BFSK.m")


if draw_plots
    f = figure(2);
    f.Position = [450, 100, 700, 600];
    f.Name = 'BFSK';

    subplot(311), plot(BFSK_intervals, BFSK_with_noise), grid on; % plot the disturbed signal
    xlabel("Time, sec"), ylabel("BASK signal with noise"); % labels
    ylim([-4, 4]); % limits
end


%  matched filter -- REFACTOR VARIABLES

% impulse response
hMF1 = fliplr(s1);
hMF2 = fliplr(s2);

% output of matched filter
sMF1 = filter(hMF1, 1, BFSK_with_noise);
sMF2 = filter(hMF2, 1, BFSK_with_noise);


% detected symbols
L = length(s1);
Es1 = sMF1(L:L:end);
Es2 = sMF2(L:L:end);
detected_symbols = Es1 > Es2;


% plotting
if draw_plots
    ylimit = 125;
    subplot(312), plot(BFSK_intervals, sMF1), grid on; % plot 1st matched filter signal
    xlabel("Time [s]"), ylabel("1st matched filter"); % labels
    ylim([-ylimit, ylimit]); % limits
    
    subplot(313), plot(BFSK_intervals, sMF2), grid on; % plot 2nd matched filter signal
    xlabel("Time [s]"), ylabel("2nd matched filter"); % labels
    ylim([-ylimit, ylimit]); % limits
end

% BER calculation
run("show_BER.m")
