clc, clear, format compact

run("../lab-3/BFSK.m")


% Correlator receiver
f = figure(2);
f.Position = [450, 100, 700, 600];
f.Name = 'BFSK';

subplot(311), plot(BFSK_intervals, BFSK_with_noise), grid on
ylim([-4 4]), xlabel("Time [s]"), ylabel("BFSK signal with noise")


% Recieve each symbol
integrator1 = []; % empty brakets, peparation for integrator output signal 
integrator2 = [];

for k = 1:N
    index = (1:200) + (k-1)*200; % indicises of signal segment
    sM1 = s1 .* BFSK_with_noise(index);  % correlator multiplication 
    integrator1 = [integrator1, cumsum(sM1)]; % calculate continuous integral

    sM2 = s2 .* BFSK_with_noise(index);  % correlator multiplication 
    integrator2 = [integrator2, cumsum(sM2)]; % calculate continuous integral


    detected_symbols(k) = integrator1(end) > integrator2(end); % detected symbols compared with threshold
end



% Plot integrated signal
subplot(312), plot(BFSK_intervals, integrator1), grid on
hold on, plot([0 BFSK_intervals(end)], [Eb/2 Eb/2], "r-"), hold off; % plot threshold
ylim([-50, 150]), xlabel("Time [s]"), ylabel("1st Correlator output")


subplot(313), plot(BFSK_intervals, integrator2), grid on
hold on, plot([0 BFSK_intervals(end)], [Eb/2 Eb/2], "r-"), hold off; % plot threshold
ylim([-50, 150]), xlabel("Time [s]"), ylabel("2nd Correlator output")


% Output data for comparison
check = binary_sequence == detected_symbols;
disp(check')