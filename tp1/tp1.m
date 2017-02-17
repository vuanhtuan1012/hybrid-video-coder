% initial environment
clc; clear; close all;

F = {'lena.bmp', 'peppers.bmp'}; % images to work on
Q = 0:10:100; % quality factor
n = length(Q);
PSNR = zeros(1, n);
CR = zeros(1, n); % compression ratio

for i = 1:length(F)
    % read image
    fprintf('Working on image: %s\n', F{i});
    I = imread(F{i});
    IMS = size(I);
    
    % check condition of algorithm
    [rows, cols] = size(I);
    if (mod(rows, 8) > 0) || (mod(cols, 8) > 0)
        fprintf('Algorithm works only on images whos size is multiple of 8.\n');
        continue;
    end
    
    % do compression and reconstruction with different Q
    for j = 1:n
        [DC, AC] = im2jpeg(I, Q(j)); % forward
        Ih = jpeg2im(DC, AC, IMS, Q(j)); % backward
        
        % compute PSNR, compression ratio and display result
        PSNR(j) = computePSNR(I, Ih); % compute PSNR
        CR(j) = IMS(1)*IMS(2)/(length(DC) + length(AC)); % compression ratio
        fprintf('- Q = %d => PSNR = %g\n', Q(j), PSNR(j));
        fprintf('         => CR   = %g\n', CR(j));
    end
    
    % plot graphs
    figure; plot(Q, PSNR); % Q vs. PSNR
    xlabel('Q'); ylabel('PSNR'); title(F{i});
    fname = strrep(F{i}, '.bmp', '-psnr.eps');
    print(fname, '-depsc');
    figure; plot(PSNR, CR); % PSNR vs. CR
    xlabel('PSNR'); ylabel('Compression Ratio'); title(F{i});
    fname = strrep(F{i}, '.bmp', '-cr.eps');
    print(fname, '-depsc');
end