%% BASK
clc, clear, format compact

% we need to get the enery of the carrier E_b


T = 1; % symbol duration = 1 second,
f0 = 10; % carrier frequecy = 10Hz

N = 10; % number of symbols
sB = randi(2, 1, N) - 1; % random sequence of 1 and 0

SNR = 50; %Db



% plot binary datas
figure(1);
subplot(311), stairs(0 : T : N * T, [sB sB(end)]), grid on
ylim([-0.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")



% plot BASK signal wihout errors
dt =  T / 200;
t = 0 : dt : T - dt;
s0 = sin (2 * pi * f0 * t);
L = length(s0); % length of carrier signal


% Generatr BASK
sBASK = kron(sB, s0);
tBASK = 0 : dt : N * T - dt;
subplot(312), plot(tBASK, sBASK), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% Generate noise
Eb = sum(s0.^2);
EbN0 = 10^(SNR / 10);
N0 = Eb / EbN0;
sigma = sqrt(N0 / 2);
sNoise = sigma * randn(1, N * L);



% Add noise
sBASKN = sBASK + sNoise;
subplot(313), plot(tBASK, sBASKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BASK signal with noise");

% ------- since here it 




%  ----- Matched filter
figure(2);
subplot(211), plot(tBASK, sBASKN), grid on;
ylim([-1.1, 1.1]); xlabel("Time, sec"), ylabel("BASK signal with noise");


% flip the carrier
hMF1 = fliplr(s0);

% Covolution two methods
% sMF1 = filtef(hMF1, 1, sBASKN);
sMF1 = conv(hMF1, sBASKN);
sMF1 = sMF1(1:length(sBASKN)); % trunkating lenght


% detected symbols
Es = sMF1(L : L : end);
sDM = Es > Eb / 2;

% plotting
subplot(212), plot(tBASK, sMF1, [0, tBASK(end)], [Eb / 2, Eb / 2], "r-"), grid on
ylim(), xlabel("Time, s"), ylabel("")






%% BFSK
clc, clear, format compact

% we need to get the enery of the carrier E_b


T = 1; % symbol duration = 1 second,
f0 = 10; % carrier frequecy = 10Hz

N = 10; % number of symbols
sB = randi(2, 1, N) - 1; % random sequence of 1 and 0

SNR = 50; %Db



% plot binary datas
figure(3);
subplot(311), stairs(0 : T : N * T, [sB sB(end)]), grid on
ylim([-0.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% Calcilate f1 and f2 frequency
k = 12;
dF = k /(2 * T);
f1 = f0 - dF/2;
f2 = f0 + dF/2;


% plot BFSK signal wihout errors
dt =  T / 200;
t = 0 : dt : T - dt;
s1 = sin (2 * pi * f1 * t);
s2 = sin (2 * pi * f2 * t);
L = length(s1);


% Generatr BFSK
sBASK1 = kron(sB, s1);
sBASK2 = kron(~sB, s2);
sBFSK = sBASK1 + sBASK2; 

tBFSK = 0 : dt : N * T - dt;
subplot(312), plot(tBFSK, sBFSK), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% Generate noise
Eb = sum(s1.^2);
EbN0 = 10^(SNR / 10);
N0 = Eb / EbN0;
sigma = sqrt(N0 / 2);
sNoise = sigma * randn(1, N * 200);



% Add noise
sBFSKN = sBFSK + sNoise;
subplot(313), plot(tBFSK, sBFSKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BFSK signal with noise");






% Maybe it is lab4


% Correlator receiver
figure(4);
subplot(311), plot(tBFSK, sBFSKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BFSK signal with noise")


% impulse response
hMF1 = fliplr(s1);
hMF2 = fliplr(s2);

% output of matched filter
sMF1 = filter(hMF1, 1, sBFSKN);
sMF2 = filter(hMF2, 1, sBFSKN);


% detected symbols
Es1 = sMF1(L:L:end);
Es2 = sMF2(L:L:end);
sDM = Es1 > Es2;





% Plot integrated signal
subplot(312), plot(tBFSK, sMF1), grid on
ylim([-110, 110]), xlabel("Time [s]"), ylabel("1st matched filter")


subplot(313), plot(tBFSK, sMF2), grid on
ylim([-110, 110]), xlabel("Time [s]"), ylabel("2nd matched filter")


% Output data for comparison
x = [sB; sDM];


%% BPSK
clc, clear, format compact

% we need to get the enery of the carrier E_b


T = 1; % symbol duration = 1 second,
f0 = 10; % carrier frequecy = 10Hz

N = 10; % number of symbols
sB = randi(2, 1, N) - 1; % random sequence of 1 and 0

sB_NRZ = -2 * sB + 1;

SNR = 5; %Db



% plot binary datas
figure(5);
subplot(311), stairs(0 : T : N * T, [sB sB(end)]), grid on
ylim([-0.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% plot BPSK signal wihout errors
dt =  T / 200;
t = 0 : dt : T - dt;
s0 = sin (2 * pi * f0 * t);
L = length(s0);


% Generatr BFSK
sBPSK = kron(sB_NRZ, s0);

tBPSK = 0 : dt : N * T - dt;
subplot(312), plot(tBPSK, sBPSK), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% Generate noise
Eb = sum(s0.^2);
EbN0 = 10^(SNR / 10);
N0 = Eb / EbN0;
sigma = sqrt(N0 / 2);
sNoise = sigma * randn(1, N * 200);



% Add noise
sBPSKN = sBPSK + sNoise;
subplot(313), plot(tBPSK, sBPSKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BFSK signal with noise");






% Maybe it is lab4


%matched filter
figure(6);
subplot(211), plot(tBPSK, sBPSKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BPSK signal with noise")

% impulse response
hMF1 = fliplr(s0);


% ouptup of matched filter
sMF1 = conv(hMF1, sBPSKN);
sMF1 = sMF1(1:length(sBPSKN));


% detected symbols
Es = sMF1(L : L: end);
sDM = Es < 0;



% Plot integrated signal
subplot(212), plot(tBPSK, sMF1), grid on
hold on, plot([0 tBPSK(end)], [0, 0], "r"), hold off
ylim([-120, 120]), xlabel("Time [s]"), ylabel("1st matched filter")


% Output data for comparison
x = [sB; sDM];


