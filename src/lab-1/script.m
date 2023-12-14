clc, clearvars, clear

N = 10; % numbers of bits

% Signal to Noise Ratio
% i.e. SNR = 20 --> signal is 100 times stronger than the noise
SNR = 10; % dB

% --- 1: creating the dataset

% index = randi(2, N, 1); % randomly generated indexes
% arr=[0,1]; % creates small array
% s = arr(index); % vector of 0s and 1s
s = [0, 1, 1, 0, 0, 0 , 1, 0, 1, 1]

figure(1) % creates the figure
subplot(3, 2, 1), stem(s, "b", "Linewidth", 1) % draws the function and puts it on the figure
grid on; % adds grids
xlabel("Sample No."), ylabel("Sample Values"), title("Initial data") % adds labels and title
ylim([-.5, 1.5]); % adjusts Y-axes

% --- 2: modulaton of the bit

SC = ones(1, 100); 
sTx = kron(s, SC); % kroner multiplication

subplot(3, 2, 2), plot(sTx, "b", "Linewidth", 1);
grid on;
xlabel("Time, units"), ylabel("Signal"), title("Converted signal");
ylim([-.5, 1.5]);

% --- 3: addition of GWN to the signal

sRx = awgn(sTx, SNR); % awgn = Additive White Gaussian Noise

subplot(3, 2, 3), plot(sRx, "b");
grid on;
xlabel("Time, units"), ylabel("Signal"), title("Signal with GWN");
ylim([min(sRx), max(sRx)]);

threshold = ( max(sTx) + min(sTx) ) / 2; % calculates the threshold
hold on, plot([0, length(sTx)], [threshold, threshold], "r", "Linewidth", 1), hold off; % adds threshold red line

% --- 4: Rigenerationg signal with GWN

% detects signal
%   signal > threshold --> 1
%   signal < threshold --> 0
sDt = sRx > threshold;

subplot(3, 2, 4), plot(sDt, "r", "Linewidth", 1);
grid on;
xlabel("Time, units"), ylabel("Signal"), title("Signal detection");
ylim([-.5, 1.5]);

% --- 5: changing modulation of the signal to decrease the GWN disturbance

% creates NRZ signal:
%   1 --> -1 
%   0 --> 1
sTx = (-2 * sTx) + 1; 
sRx = awgn(sTx, SNR); % awgn = Additive White Gaussian Noise

subplot(3, 2, 5), plot(sRx, "b");
grid on;
xlabel("Time, units"), ylabel("Signal"), title("NRZ signal with GWN");
ylim([min(sRx), max(sRx)]);

threshold = ( max(sTx) + min(sTx) ) / 2; % recalculates the threshold 
hold on, plot([0, length(sTx)], [threshold, threshold], "r", "Linewidth", 1), hold off; % adds threshold red line

% detects signal
%   signal < threshold --> 1
%   signal > threshold --> 0
sDt = sRx < threshold;

subplot(3, 2, 6), plot(sDt, "r", "Linewidth", 1);
grid on;
xlabel("Time, units"), ylabel("Signal"), title("Signal detection");
ylim([-.5, 1.5]);













