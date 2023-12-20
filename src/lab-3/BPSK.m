clc, clear, format compact


% Task 1
T = 1; % symbol duration [seconds]
F0 = 10; % carrier frequecy [Hz]
N = 15; % number of symbols
binary_sequence = randi(2, 1, N) - 1; % random sequence of 1 and 0
SNR = 15; % Db

% plot binary data
f = figure(3);
f.Name = 'BPSK';
f.Position = [450, 100, 700, 600];

subplot(311), stairs(0 : T : N * T, [binary_sequence binary_sequence(end)]), grid on; % plot
xlabel("Time [s]"), ylabel("Binary data"); % labels
ylim([-0.1 1.1]); % limits


% Task 2
% create carrier signal
delta_t =  T / 200; % step duration
t = 0 : delta_t : T - delta_t; % time intervals
s0 = sin (2 * pi * F0 * t); % carrier signal


% Task 3
% Generate BPSK signal with no noise
NRZ_binary_sequence = -2 * binary_sequence + 1; % convert initial data into NRZ signal
BPSK_signal = kron(NRZ_binary_sequence, s0); % Kroneker multiplication
BPSK_intervals = 0 : delta_t : N * T - delta_t; % time intervals for BPSK 

subplot(312), plot(BPSK_intervals, BPSK_signal), grid on; % plot
xlabel("Time [s]"), ylabel("BPSK signal"); % labels
ylim([-1.1 1.1]); % limits


% Task 4
% Generate AGWN
EbN0 = 10^(SNR / 10); % inversed SNR formula
Eb = sum(s0.^2); % energy of carrier signal
N0 = Eb / EbN0; % noise power spectral density
sigma = sqrt(N0 / 2); % sigma^2 = N0/2
noise = sigma * randn(1, N * 200); % get gaussian noise using randn()


% Add noise to the BPSK signal
BPSK_with_noise = BPSK_signal + noise;
subplot(313), plot(BPSK_intervals, BPSK_with_noise), grid on; % plot
xlabel("Time [s]"), ylabel("BPSK signal with noise"); % labels
ylim([-4, 4]); % limits
