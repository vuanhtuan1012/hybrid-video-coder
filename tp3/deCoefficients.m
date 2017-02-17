function QM = deCoefficients(DC, AC, IMS)
% function deCoefficients decompress encoded DC, AC coefficients
% to quantized matrix

cols = length(DC);
DECOEF = zeros(64, cols); % decoded coefficients

% decode DPCM of DC coefficients
for i=2:cols
    DC(i) = DC(i-1) + DC(i);
end
DECOEF(1,:) = DC;

% decode RLC of AC coefficients
blk = 1; % current block
ind = 2; % current index

for i=1:2:length(AC)-1
    count0 = AC{i}; count0 = str2double(count0);
    val = AC{i+1}; val = str2double(val);
    
    if (count0 == 0) && (val == 0) % end of block
        DECOEF(ind:end,blk) = 0;
        blk = blk + 1;
        ind = 2;
    else
        DECOEF(ind:ind+count0-1,blk) = 0;
        DECOEF(ind+count0,blk) = val;
        ind = ind+count0+1;
    end
end

% index to reverse zig-zag way to normal
rev = [1 3 4 10 11 21 22 36 2 5 9 12 20 23 35 ...
       37 6 8 13 19 24 34 38 49 7 14 18 25 33 39 ...
       48 50 15 17 26 32 40 47 51 58 16 27 31 41 46 ...
       52 57 59 28 30 42 45 53 56 60 63 29 43 44 54 ...
       55 61 62 64];
DECOEF = DECOEF(rev, :);
QM = col2im(DECOEF, [8 8], IMS, 'distinct'); % rearrange to quantized matrix
