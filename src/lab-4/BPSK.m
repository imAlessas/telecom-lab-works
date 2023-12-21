clc, clear, format compact

run("../lab-3/BPSK.m")

% Correlator receiver
figure(2);
subplot(211), plot(BPSK_intervals, BPSK_with_noise), grid on
ylim([-4, 4]), xlabel("Time [s]"), ylabel("BPSK signal with noise")


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
subplot(212), plot(BPSK_intervals, integrator), grid on
hold on, plot([0 BPSK_intervals(end)], [0, 0], "r"), hold off
ylim([-150 150]), xlabel("Time [s]"), ylabel("1st Correlator output")


% Output data for comparison
check = binary_sequence == detected_symbols;
disp(check')