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


%  matched filter

% impulse response
s1_flipped = fliplr(s1);
s2_flipped = fliplr(s2);

% output of matched filter
covolution_1 = filter(s1_flipped, 1, BFSK_with_noise);
covolution_2 = filter(s2_flipped, 1, BFSK_with_noise);


% detected symbols
L = length(s1);
estimated_signal_1 = covolution_1(L:L:end);
estimated_signal_2 = covolution_2(L:L:end);
detected_symbols = estimated_signal_1 > estimated_signal_2;


% plotting
if draw_plots
    ylimit = 125;
    subplot(312), plot(BFSK_intervals, covolution_1), grid on; % plot 1st matched filter signal
    xlabel("Time [s]"), ylabel("1st matched filter"); % labels
    ylim([-ylimit, ylimit]); % limits
    
    subplot(313), plot(BFSK_intervals, covolution_2), grid on; % plot 2nd matched filter signal
    xlabel("Time [s]"), ylabel("2nd matched filter"); % labels
    ylim([-ylimit, ylimit]); % limits
end

% BER calculation
run("show_BER.m")
