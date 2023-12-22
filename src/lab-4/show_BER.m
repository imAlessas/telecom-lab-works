
check = binary_sequence == detected_symbols; % check element-wise
errors = N - sum(check); % counts errors
BER = errors / N; % calculates Bit Error Rate

disp("SNR:              " + SNR);
disp("Total symbols:    " + N);
disp("Errors:           " + errors);
disp("BER:              " + BER);