clc, clear

N = 1e6;                    % Number of bits
N
binDt = randi(2,1,N) - 1;   % Generate integer numbers in range [1, 2]
                            % Subtract 1 to format data in range [0, 1]
SNR = -50;                   % Signal to Noise ratio, dB



% ----------------------------------------------------------------------             
% Format binary data as symbols consisting of 4 bits per symbol
% Use 'reshape' command to create 4xN/4 matrix
symDt = reshape(binDt, 4, N/4);

% Each column of this matrix represents a QAM-16 symbol (4 bits)
% Convert this binary notation of symbols into decimal format
% Note: The first row denotes the most significant bit
symDt = 2.^(3:-1:0) * symDt;

% Now each symbol is represented in decimal form in range from 0 to 15



% ----------------------------------------------------------------------
% Specify QAM-16 constellation as column vector
% Each row represents coordinates of a signal in constellation with
% code matching the number of the row (-1 due to Matlab indexing specifics)
mapQAM16 = [-1-1i; -1-3i; -1+1i; -1+3i;
            -3-1i; -3-3i; -3+1i; -3+3i;
            +1-1i; +1-3i; +1+1i; +1+3i;
            +3-1i; +3-3i; +3+1i; +3+3i];


% ----------------------------------------------------------------------             
% Perform modulation by mapping integer symbols to corresponding QAM-16 signals
% Furthermore, add noise with specified SNR by using "awgn()" function.
symMod = mapQAM16(symDt + 1);     % Add +1 to each symbol to account for Matlab indexing
symNoi = awgn(symMod, SNR);

% Plot resulting signals:
%   * Blue dots - noisy signal
%   * Red crosses - ideal signals
figure(1);
plot(symNoi, 'b.'); % noisy signal
hold on, plot(mapQAM16, 'rx', 'LineWidth', 2), hold off; % ideal signal
xlim([-4, 4]), ylim([-4, 4]); % limitng axes
xticks([-4, -3, -2, -1, 0, 1, 2, 3, 4])
xlabel('Real part'), ylabel('Immaginary part'), title('QAM-16 Constellation'); % adding labels and title
axis square; % equalize scale of both axes

% ----------------------------------------------------------------------             
% Perform demodulation by finding closest ideal signal from constellation and
% convert decimal symbols into binary codewords
demodData

% ----------------------------------------------------------------------
% Count number of errors by comparing vectors binDt and binDmd
numErr = sum(binDmd ~= binDt)
BERval = numErr/N          % Number of errors ratio to total number of bits N
