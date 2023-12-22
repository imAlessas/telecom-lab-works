T = 1; % symbol duration [seconds]
f0 = 10; % carrier frequecy [Hz]
N = 10000; % number of symbols
binary_sequence = randi(2, 1, N) - 1; % random sequence of 1 and 0
% binary_sequence = [0 0 1 0 1 0 0 0 1 1 1 1 0 1 1 ];
SNR = 5; % Db
draw_plots = 1;