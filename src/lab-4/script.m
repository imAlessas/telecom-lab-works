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
sNoise = sigma * randn(1, N * 200);



% Add noise
sBASKN = sBASK + sNoise;
subplot(313), plot(tBASK, sBASKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BASK signal with noise");






% Maybe it is lab4


% Correlator receiver
figure(2);
subplot(211), plot(tBASK, sBASKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BASK signal with noise")


% Recieve each symbol
sI1 = []; % empty brakets, peparation for integrator output signal 

for k = 1:N
    idx = (1:200) + (k-1)*200; % indicises of signal segment
    sM1 = s0 .* sBASKN(idx);  % correlator multiplication 
    sI1 = [sI1, cumsum(sM1)]; % calculate continuous integral
    sDM(k) = sI1(end) > Eb/2; % detected symbols compared with threshold = eb / 2 = half of the carrier freq
end


% Plot integrated signal
subplot(212), plot(tBASK, sI1), grid on
hold on, plot([0 tBASK(end)], [Eb/2 Eb/2], "r-"), hold off
ylim([-5, Eb + 5]), xlabel("Time [s]"), ylabel("1st Correlator output")

% Output data for comparison
x = [sB; sDM];





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


% Recieve each symbol
sI1 = []; % empty brakets, peparation for integrator output signal 
sI2 = [];

for k = 1:N
    idx = (1:200) + (k-1)*200; % indicises of signal segment
    sM1 = s1 .* sBFSKN(idx);  % correlator multiplication 
    sI1 = [sI1, cumsum(sM1)]; % calculate continuous integral

    sM2 = s2 .* sBFSKN(idx);  % correlator multiplication 
    sI2 = [sI2, cumsum(sM2)]; % calculate continuous integral


    sDM(k) = sI1(end) > sI2(end); % detected symbols compared with threshold
end



% Plot integrated signal
subplot(312), plot(tBFSK, sI1), grid on
ylim([-5, Eb + 5]), xlabel("Time [s]"), ylabel("1st Correlator output")


subplot(313), plot(tBFSK, sI2), grid on
ylim([-5, Eb + 5]), xlabel("Time [s]"), ylabel("2nd Correlator output")


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

SNR = 50; %Db



% plot binary datas
figure(5);
subplot(311), stairs(0 : T : N * T, [sB sB(end)]), grid on
ylim([-0.1 1.1]), xlabel("Time [s]"), ylabel("Binary data")


% plot BPSK signal wihout errors
dt =  T / 200;
t = 0 : dt : T - dt;
s0 = sin (2 * pi * f0 * t);


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


% Correlator receiver
figure(6);
subplot(211), plot(tBPSK, sBPSKN), grid on
ylim([-1.1 1.1]), xlabel("Time [s]"), ylabel("BPSK signal with noise")


% Recieve each symbol
sI1 = []; % empty brakets, peparation for integrator output signal 

for k = 1:N
    idx = (1:200) + (k-1)*200; % indicises of signal segment
    sM1 = s0 .* sBPSKN(idx);  % correlator multiplication 
    sI1 = [sI1, cumsum(sM1)]; % calculate continuous integral

    sDM(k) = sI1(end) < 0; % detected symbols compared with threshold
end


% Plot integrated signal
subplot(212), plot(tBPSK, sI1), grid on
hold on, plot([0 tBPSK(end)], [0, 0], "r"), hold off
ylim([-Eb, Eb]), xlabel("Time [s]"), ylabel("1st Correlator output")


% Output data for comparison
x = [sB; sDM];




