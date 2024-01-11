clc, clear, format compact


run("../lab-3/BPSK.m")


if draw_plots
    f = figure(2);
    f.Position = [450, 100, 700, 600];
    f.Name = 'BASK';

    subplot(211), plot(BPSK_intervals, BPSK_with_noise), grid on; % plot the disturbed signal
    xlabel("Time, sec"), ylabel("BASK signal with noise"); % labels
    ylim([-4, 4]); % limits
end


%  matched filter

% flip the carrier to make the covolution
s0_flipped = fliplr(s0);

% Covolution two methods
% sMF1 = filtef(hMF1, 1, BPSK_with_noise);
covolution = conv(s0_flipped, BPSK_with_noise);
covolution = covolution(1:length(BPSK_with_noise)); % trunkating lenght

% detected symbols
L = length(s0); % length of carrier signal
estimated_signal = covolution(L : L: end);
detected_symbols = estimated_signal < 0;


% plotting
if draw_plots
    ylimit = 125;
    subplot(212), plot(BPSK_intervals, covolution), grid on; % plot matched filter signal
    hold on, plot( [0, BPSK_intervals(end)], [0, 0], "r"), hold off; % plot threshold
    xlabel("Time, s"), ylabel("Matched Filter"); % labels
    ylim([-ylimit, ylimit]); % limits
end

% BER calculation
run("show_BER.m")
