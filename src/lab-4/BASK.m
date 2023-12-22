clc, clear, format compact

run("../lab-3/BASK.m")

% Plot disturbed received signal
if draw_plots
    f = figure(2);
    f.Position = [450, 100, 700, 600];
    f.Name = 'BASK';
    
    subplot(211), plot(BASK_intervals, BASK_with_noise), grid on; % plot
    xlabel("Time [s]"), ylabel("BASK signal with noise"); % labels
    ylim([-4 4]); % limits
end


% Optimal orrelator receiver

% Recieve each symbol
integrator = []; %  peparation for integrator output signal 

for k = 1 : N
    % indexes of the signal segment
    index = (1:200) + (k-1)*200;

    % correlator multiplication 
    sM1 = s0 .* BASK_with_noise(index);  

    % calculate continuous integral using a finite sum
    integrator = [integrator, cumsum(sM1)]; 

    % symbol detection is achieved by comparing the integrator signal with
    % half of the carrier energy
    detected_symbols(k) = integrator(end) > Eb/2;
end


% Plot integrated signal
if draw_plots
    subplot(212), plot(BASK_intervals, integrator), grid on; % plot integrator
    hold on, plot([0 BASK_intervals(end)], [Eb/2 Eb/2], "r-"), hold off; % plot threshold
    xlabel("Time [s]"), ylabel("Correlator output"); % labels
    ylim([-50, 150]); % limits
end


% Output data for comparisonù
run("show_BER.m");