function [DC, AC] = getCoefficients(QM)
% function getCoefficients returns encoded AC and DC coefficients
% of quantized matrix QM

% index to order elements in a block following zig-zag way
order = [1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 ...
         41 34 27 20 13 6 7 14 21 28 35 42 49 57 50 ...
         43 36 29 22 15 8 16 23 30 37 44 51 58 59 52 ...
         45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 ...
         62 63 56 64];
BLK = im2col(QM, [8 8], 'distinct');
BLK = BLK(order,:); % each ordered block in a column of 64 elements

DC = BLK(1,:); % get DC coefficients
oAC = BLK(2:64,:); % get AC coefficients

% DPCM on DC coefficients
for k = length(DC):-1:2
    DC(k) = DC(k) - DC(k-1);
end

% RLC on AC coefficients
AC = blanks(0);
for icol = 1:size(oAC,2)
    count0 = 0; % count number of zeros in the run
    for irow = 1:63
        if oAC(irow,icol) == 0
            count0 = count0 + 1;
        else
            AC{length(AC)+1} = num2str(count0);
            AC{length(AC)+1} = num2str(oAC(irow,icol));
            count0 = 0;
        end
        
        if irow == 63
            % add tuple (0,0) to mark end of a block
            AC{length(AC)+1} = num2str(0);
            AC{length(AC)+1} = num2str(0);
        end
    end
end