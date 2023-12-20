clc, clear, format compact

run("../lab-3/BASK.m")

% Correlator receiver
f = figure(2);
f.Position = [450, 100, 700, 600];
f.Name = 'BASK';

subplot(211), plot(BASK_intervals, BASK_with_noise), grid on; % plot
xlabel("Time [s]"), ylabel("BASK signal with noise"); % labels
ylim([-4 4]); % limits


% Recieve each symbol
integrator = []; % empty brakets, peparation for integrator output signal 

for k = 1:N
    index = (1:200) + (k-1)*200; % indicises of signal segment
    sM1 = s0 .* BASK_with_noise(index);  % correlator multiplication 
    integrator = [integrator, cumsum(sM1)]; % calculate continuous integral
    detected_symbols(k) = integrator(end) > Eb/2; % detected symbols compared with threshold = eb / 2 = half of the carrier energy
end


% Plot integrated signal
subplot(212), plot(BASK_intervals, integrator), grid on; % plot integrator
hold on, plot([0 BASK_intervals(end)], [Eb/2 Eb/2], "r-"), hold off; % plot threshold
xlabel("Time [s]"), ylabel("Correlator output"); % labels
ylim([-50, 150]); % limits

% Output data for comparison
check = binary_sequence == detected_symbols;
disp(check')