T = 1; % symbol duration [seconds]
f0 = 10; % carrier frequecy [Hz]
N = 15; % number of symbols
binary_sequence = randi(2, 1, N) - 1; % random sequence of 1 and 0
SNR = 20; % Db
draw_plots = 1;
