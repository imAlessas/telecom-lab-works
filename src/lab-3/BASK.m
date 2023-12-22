clc, clear, format compact


% Task 1
run("./initial_settings.m");

% plot binary data
if draw_plots
    f = figure(1);
    f.Position = [450, 100, 700, 600];
    f.Name = 'BASK';
    
    subplot(311), stairs(0 : T : N * T, [binary_sequence binary_sequence(end)]), grid on; % plot
    xlabel('Time [s]'), ylabel('Binary data'); % labels
    ylim([-0.1 1.1]); % limits
end


% Task 2
% create carrier signal
delta_t =  T / 200; % step duration
t = 0 : delta_t : T - delta_t; % time intervals
s0 = sin (2 * pi * f0 * t); % carrier signal


% Generate BASK signal with no noise
BASK_signal = kron(binary_sequence, s0); % Kroneker multiplication
BASK_intervals = 0 : delta_t : N * T - delta_t; % time intervals for BASK 

if draw_plots
    subplot(312), plot(BASK_intervals, BASK_signal), grid on; % plot
    xlabel('Time [s]'), ylabel('BASK signal'); % labels
    ylim([-1.1 1.1]); % limits
end


% Task 3
% Generate AGWN
EbN0 = 10^(SNR / 10); % inversed SNR formula
Eb = sum(s0.^2); % energy of carrier signal
N0 = Eb / EbN0; % noise power spectral density
sigma = sqrt(N0 / 2); % sigma^2 = N0/2
noise = sigma * randn(1, N * 200); % get gaussian noise using randn()


% Add noise to the BASK signal
BASK_with_noise = BASK_signal + noise;

if draw_plots
    subplot(313), plot(BASK_intervals, BASK_with_noise), grid on; % plot
    xlabel('Time [s]'), ylabel('BASK signal with noise'); % labels
    ylim([-4, 4]); % limits
end