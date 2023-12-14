%% tasks 1 & 2
clc, clearvars, clear

SYMBOLS = 10; % number of symbols
s = randi(2, 1, SYMBOLS) - 1; % random sequence of 1 and 0

SAMPLES_PER_SYMBOL = 100; % numbero of samples utilized per each syimbol


% --- Transmitted signal
s0 = ones(1, SAMPLES_PER_SYMBOL); % unipolar pulses carrier
sTx = kron(s, s0); % kroner multiplication simulating DAC

subplot(3, 1, 1), plot(sTx, 'b', 'Linewidth', 1), grid on; % draws the first plot
xlabel('Time, units'), ylabel('Signal'), title('Transmitted signal'), ylim([-.5, 1.5]); % labels and title


% --- Signal with GWN
SNR = 10; % dB

sRx = awgn(sTx, SNR); % adds noise to the trasmitted signal
threshold = ( max(sTx) + min(sTx) ) / 2; % calculates the threshold 

subplot(3, 1, 2), plot(sRx, 'b'), grid on; % draws the second plot
xlabel('Time, units'), ylabel('Signal'), title('Disturbed signal'), ylim([min(sRx), max(sRx)]); % labels and title
hold on, plot([0, length(sTx)], [threshold, threshold], 'r', 'Linewidth', 1), hold off; % adds threshold red line


% --- Detected signal
sD = sRx > threshold; % regenerate the signal

subplot(3, 1, 3), plot(sD, 'b', 'Linewidth', 1); grid on; % draws the third plot
xlabel('Time, units'), ylabel('Signal'), title('Detected signal'); ylim([-.5, 1.5]); % labels and title








%% Tasks 3 and 4
clc, clearvars, clear

SYMBOLS = 10;
% s = randi(2, 1, SYMBOLS) - 1;
s = [0, 0, 1, 1, 1, 1, 0, 1, 0, 0];

SAMPLES_PER_SYMBOL = 100;

% --- Transmitted signal
s0 = ones(1, SAMPLES_PER_SYMBOL); % unipolar pulses carrier
sTx = kron(s, s0); % kroner multiplication simulating DAC

subplot(3, 1, 1), plot(sTx, 'b', 'Linewidth', 1), grid on; % draws the first plot
xlabel('Time, units'), ylabel('Signal'), title('Transmitted signal'), ylim([-.5, 1.5]); % labels and title


% --- Signal with GWN
SNR = -5; % dB

sRx = awgn(sTx, SNR); % adds noise to the trasmitted signal
threshold = ( max(sTx) + min(sTx) ) / 2; % calculates the threshold 

subplot(3, 1, 2), plot(sRx, 'b'), grid on; % draws the second plot
xlabel('Time, units'), ylabel('Signal'), title('Disturbed signal'), ylim([min(sRx), max(sRx)]); % labels and title
hold on, plot([0, length(sTx)], [threshold, threshold], 'r', 'Linewidth', 1), hold off; % adds threshold red line


% --- Detected signal
sRx = reshape(sRx, SAMPLES_PER_SYMBOL, SYMBOLS); % slice recieved signal into segments 
sD = mean(sRx) > threshold; % compare the mean of each clumn with the threshold  
sDvec = kron(sD,ones(1,SAMPLES_PER_SYMBOL)); 

subplot(3, 1, 3), stairs(sDvec, 'b', 'Linewidth', 1); grid on; % draws the third plot
xlabel('Time, units'), ylabel('Signal'), title('Detected signal'); ylim([-.5, 1.5]); % labels and title








%% Task 5
clc, clearvars, clear

SYMBOLS = 10000;
s = randi(2, 1, SYMBOLS) - 1; % random sequence of 1 and 0

SAMPLES_PER_SYMBOL = 100;
TOTAL_SAMPLES = SYMBOLS * SAMPLES_PER_SYMBOL; 


% --- Transmitted signal
s0 = ones(1, SAMPLES_PER_SYMBOL); % unipolar pulses carrier
sTx = kron(s, s0); % kroner multiplication simulating DAC

subplot(3, 1, 1), plot( sTx(1:25*SAMPLES_PER_SYMBOL) , 'b', 'Linewidth', 1), grid on; % draws the first plot
xlabel('Time, units'), ylabel('Signal'), title('Transmitted signal'), ylim([-.5, 1.5]); % labels and title


% --- Signal with GWN
SNR = -5; % dB

sRx = awgn(sTx, SNR); % adds noise to the trasmitted signal
threshold = ( max(sTx) + min(sTx) ) / 2; % calculates the threshold 

subplot(3, 1, 2), plot(sRx(1:25*SAMPLES_PER_SYMBOL), 'b'), grid on; % draws the second plot
xlabel('Time, units'), ylabel('Signal'), title('Disturbed signal'), ylim([min(sRx), max(sRx)]); % labels and title
hold on, plot([0, 25*SAMPLES_PER_SYMBOL], [threshold, threshold], 'r', 'Linewidth', 1), hold off; % adds threshold red line


% --- Detected signal
sRx = reshape(sRx, SAMPLES_PER_SYMBOL, SYMBOLS); % slice recieved signal into segments 
sD = mean(sRx) > threshold; % compare the mean of each clumn with the threshold  
sDvec = kron(sD,ones(1,SAMPLES_PER_SYMBOL));

subplot(3, 1, 3), stairs(sDvec(1:25*SAMPLES_PER_SYMBOL), 'b', 'Linewidth', 1); grid on; % draws the third plot
xlabel('Time, units'), ylabel('Signal'), title('Detected signal'); ylim([-.5, 1.5]); % labels and title

% Error calculation
errVec = (sD ~= s); % creates a vector containing the different bits between sD and s
errors = sum(errVec); % number of total errors
disp("Total errors: " + errors); % displays the number of errors





%% Task 6

clc, clearvars, clear

SYMBOLS = 10000;
s = randi(2, 1, SYMBOLS) - 1; % random sequence of 1 and 0

SAMPLES_PER_SYMBOL = 100;


% --- Transmitted signal
SAMPLES_PER_PERIOD = 20; % numer of samples per period
PERIODS = (0 : SAMPLES_PER_SYMBOL - 1 )/SAMPLES_PER_PERIOD; % calculates the number of periods for each symbol

s0 = sin(2 * pi * PERIODS); % carrier is a sine wave
sTx = kron(s, s0); % kroner multiplication simulating DAC

subplot(3, 1, 1), plot( sTx(1:25*SAMPLES_PER_SYMBOL) , 'b', 'Linewidth', 1), grid on; % draws the first plot
xlabel('Time, units'), ylabel('Signal'), title('Transmitted signal'), ylim([-1.5, 1.5]); % adds labels and title


% --- Signal with GWN
SNR = 30; % dB

sRx = awgn(sTx, SNR); % adds noise to the trasmitted signal
threshold = ( max(sTx) + min(sTx) ) / 2; % calculates the threshold 

subplot(3, 1, 2), plot(sRx(1:25*SAMPLES_PER_SYMBOL), 'b'), grid on; % draws the second plot
xlabel('Time, units'), ylabel('Signal'), title('Disturbed signal'), ylim([min(sRx), max(sRx)]); % labels and title
hold on, plot([0, 25*SAMPLES_PER_SYMBOL], [threshold, threshold], 'r', 'Linewidth', 1), hold off; % adds threshold red line


% --- Detected signal
sRx = reshape(sRx, SAMPLES_PER_SYMBOL, SYMBOLS); % slice recieved signal into segments 
sD = mean(sRx) > threshold; % compare the mean of each clumn with the threshold  
sDvec = kron(sD,ones(1,SAMPLES_PER_SYMBOL));

subplot(3, 1, 3), stairs(sDvec(1:25*SAMPLES_PER_SYMBOL), 'b', 'Linewidth', 1); grid on; % draws the third plot
xlabel('Time, units'), ylabel('Signal'), title('Detected signal'); ylim([-.5, 1.5]); % labels and title

% Error calculation
errVec = (sD ~= s); % creates a vector containing the different bits between sD and s
errors = sum(errVec); % number of total errors
disp("Total errors: " + errors); % displays the number of errors





%% Task 7

clc, clearvars, clear

SYMBOLS = 10000;
s = randi(2, 1, SYMBOLS) - 1; % random sequence of 1 and 0

SAMPLES_PER_SYMBOL = 100;


% --- Transmitted signal
SAMPLES_PER_PERIOD = 20; % numer of samples per period
PERIODS = (0 : SAMPLES_PER_SYMBOL - 1 )/SAMPLES_PER_PERIOD; % calculates the number of periods for each symbol

s0 = sin(2 * pi * PERIODS); % carrier is a sine wave
sTx = kron(s, s0); % kroner multiplication simulating DAC

subplot(3, 1, 1), plot( sTx(1:25*SAMPLES_PER_SYMBOL) , 'b', 'Linewidth', 1), grid on; % draws the first plot
xlabel('Time, units'), ylabel('Signal'), title('Transmitted signal'), ylim([-1.5, 1.5]); % adds labels and title


% --- Signal with GWN
SNR = -20; % dB

sRx = awgn(sTx, SNR); % adds noise to the trasmitted signal

subplot(3, 1, 2), plot(sRx(1:25*SAMPLES_PER_SYMBOL), 'b'), grid on; % draws the second plot
xlabel('Time, units'), ylabel('Signal'), title('Disturbed signal'), ylim([min(sRx), max(sRx)]); % labels and title


% --- Detected signal
threshold =  dot( s0, s0 ) / 2; % half of the carrier energy

sRx = reshape(sRx, SAMPLES_PER_SYMBOL, SYMBOLS); % slice recieved signal into segments 

sD = (s0 * sRx) > threshold; % compares the with the threshold  

sDvec = kron(sD,ones(1,SAMPLES_PER_SYMBOL));

subplot(3, 1, 3), stairs(sDvec(1:25*SAMPLES_PER_SYMBOL), 'b', 'Linewidth', 1); grid on; % draws the third plot
xlabel('Time, units'), ylabel('Signal'), title('Detected signal'); ylim([-.5, 1.5]); % labels and title

% Error calculation
errVec = (sD ~= s); % creates a vector containing the different bits between sD and s
errors = sum(errVec); % number of total errors
disp("Total errors: " + errors); % displays the number of errors
