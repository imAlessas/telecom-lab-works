clc, clear, format compact

run("../lab-3/BPSK.m")

% Correlator receiver
figure(2);
f.Name = 'BPSK';
f.Position = [450, 100, 700, 600];

subplot(211), plot(BPSK_intervals, BPSK_with_noise), grid on; % plot
xlabel("Time [s]"), ylabel("BPSK signal with noise"); % labels
ylim([-4, 4]); % limits


% Recieve each symbol
integrator = []; % empty brakets, preparation for integrator output signal 

for k = 1 : N
    % indexes of the signal segment
    index = (1:200) + (k-1)*200;

    % correlator multiplication 
    sM1 = s0 .* BPSK_with_noise(index);  

    % calculate continuous integral using a finite sum
    integrator = [integrator, cumsum(sM1)]; 

    % symbol detection is achieved by comparing the integrator signal with
    % the 0-threshold
    detected_symbols(k) = integrator(end) < 0;
end


% Plot integrated signal
subplot(212), plot(BPSK_intervals, integrator), grid on % plot integrator
hold on, plot([0 BPSK_intervals(end)], [0 0], "r-"), hold off; % plot threshold
xlabel("Time [s]"), ylabel("Correlator output"); % labels
ylim([-150, 150]); % limits


% Output data for comparison
check = binary_sequence == detected_symbols;
disp(check')