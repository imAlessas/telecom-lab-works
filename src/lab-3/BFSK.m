clc, clear, format compact


% Task 1
run("./initial_settings.m");


% plot binary data
f = figure(1);
f.Name = 'BFSK';
f.Position = [450, 100, 700, 600];

subplot(311), stairs(0 : T : N * T, [binary_sequence binary_sequence(end)]), grid on; % plot
xlabel('Time [s]'), ylabel('Binary data'); % labels
ylim([-0.1 1.1]); % limits



% Task 2
% calculate f1 and f2 frequencies
k = 12;
delta_f = k /(2 * T); 
f1 = f0 - delta_f/2; % first frequency
f2 = f0 + delta_f/2; % second frequency

% create carrier signal
delta_t =  T / 200; % step duration
t = 0 : delta_t : T - delta_t; % time intervals
s1 = sin (2 * pi * f1 * t); % first carrier signal
s2 = sin (2 * pi * f2 * t); % second carrier signal


% Generate BFSK signal with no noise
BASK_signal_1 = kron(binary_sequence, s1); % Kroneker multiplication
BASK_signal_2 = kron(~binary_sequence, s2); % Kroneker multiplication
BFSK_signal = BASK_signal_1 + BASK_signal_2; % add together the two BASK signals
BFSK_intervals = 0 : delta_t : N * T - delta_t; % time intervals for BFSK 

subplot(312), plot(BFSK_intervals, BFSK_signal), grid on; % plot
xlabel('Time [s]'), ylabel('BFSK signal'); % labels
ylim([-1.1 1.1]); % limits


% Task 3
% Generate AGWN
EbN0 = 10^(SNR / 10); % inversed SNR formula
Eb = sum(s1.^2); % energy of carrier signal
N0 = Eb / EbN0; % noise power spectral density
sigma = sqrt(N0 / 2); % sigma^2 = N0/2
noise = sigma * randn(1, N * 200); % get gaussian noise using randn()


% Add noise to the BFSK signal
BFSK_with_noise = BFSK_signal + noise;
subplot(313), plot(BFSK_intervals, BFSK_with_noise), grid on; % plot
xlabel('Time [s]'), ylabel('BFSK signal with noise'); % labels
ylim([-4, 4]); % limits