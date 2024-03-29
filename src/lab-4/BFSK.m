clc, clear, format compact

run("../lab-3/BFSK.m")

% Correlator receiver
if draw_plots
    f = figure(2);
    f.Position = [450, 100, 700, 600];
    f.Name = 'BFSK';
    
    subplot(311), plot(BFSK_intervals, BFSK_with_noise), grid on; % plot disturbed signal
    xlabel("Time [s]"), ylabel("BFSK signal with noise"); % labels
    ylim([-4 4]); % limits
end


% Recieve each symbol
% peparation for two integrator output signals
integrator1 = []; 
integrator2 = [];

for k = 1:N
    % indexes of the signal segment
    index = (1:200) + (k-1)*200;

    % 1st correlator multiplication 
    sM1 = s1 .* BFSK_with_noise(index);  

    % calculate 1st continuous integral using a finite sum
    integrator1 = [integrator1, cumsum(sM1)];


    % 2nd correlator multiplication 
    sM2 = s2 .* BFSK_with_noise(index);

    % calculate 2nd continuous integral using a finite sum
    integrator2 = [integrator2, cumsum(sM2)];

    % detects symbols
    
    detected_symbols(k) = integrator1(end) > integrator2(end);
end



% Plot integrated signal
if draw_plots
    subplot(312), plot(BFSK_intervals, integrator1), grid on; % plot 1st integrator
    xlabel("Time [s]"), ylabel("1st Correlator output"); % labels
    ylim([-50, 150]); % limits
    
    
    subplot(313), plot(BFSK_intervals, integrator2), grid on; % plot 2nd integrator
    xlabel("Time [s]"), ylabel("2nd Correlator output"); % labels
    ylim([-50, 150]); % limits
end


% Output data for comparison
run("show_BER.m");

