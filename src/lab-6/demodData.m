% The script determines the binary sequence of each received QAM-16 symbol
% This is achieved by comparing absolute distance between received symbol and every possible QAM-16 constellation signal
% Note: The resulting binary data is stored in binDmd vector-row

% This approach requires replicating column of received symbols to create a matrix with dimensions N/4x16. "repmat()" function is used to do so.
symMtx = repmat(symNoi, 1, 16);

% Likewise, convert constellation vector into row and replicate it to match dimensions of symMtx matrix.
mapMtx = repmat(mapQAM16.', N/4, 1);     % Note ".'" transpose for complex values!

% Now calculate distances to each QAM-16 symbol for each row.
dstMtx = abs(symMtx - mapMtx);

% Finds minimum distance in each row and determine the column number of this minimum
% Finds minimums in rows (dimension 2)
[dstMin, symDmd] = min(dstMtx, [], 2);

% These minimum values are decimal representations (with added +1) of binary data. Performs BIN -> DEC conversion
binDmd = dec2bin(symDmd - 1, 4);        % Subtract -1 to set minimum symbol value to 0

% The output of the dec2bin function is a TEXT string. Performs logical comparison to obtain numerical values.
binDmd = (binDmd == '1')';

% Transposes matrix to dimensions 4xN/4 and unwraps matrix into single column
binDmd = binDmd(:)';            