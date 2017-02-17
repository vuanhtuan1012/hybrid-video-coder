tic;
% environment
clear; clc; close all;

% get frames to test
fname = 'foreman.yuv'; % video file name
dims = [176 144]; % dimensions of frame [width height]
numfrm = 2; % number of frames to read
startfrm = 10; % frame to start reading
[Y, U, V] = yuv_import(fname, dims, numfrm, startfrm);

% get Y frames
Fr1 = Y{1}; % reference frame
Fr2 = Y{2}; % current frame

% print reference and current frames
figure; imshow(Fr1/max(max(Fr1(:)))); % reference frame
print('reference.eps','-depsc');
figure; imshow(Fr2/max(max(Fr2(:)))); % current frame
print('current.eps','-depsc');

% optional parameters
% mspd = [1 1]; % moving speed [horizontal vertical]
% sreg = [15 15]; % searching region [horizontal vertical]
% eps = 5; % up-bound of MSE in finding best matching block

% encode and decode with BMA in forward prediction mode
b = [8 16 32];
for i = 1:length(b)
    bsz = [b(i) b(i)]; % block size [width height]
    % [MV, RE] = encodeFrame(Fr2, Fr1, bsz, mspd, sreg, eps); % encoding
    [MV, RE] = encodeFrame(Fr2, Fr1, bsz); % encoding
    Fr2h = decodeFrame(Fr1, MV, RE, bsz); % decoding
    
    % show parameters and result
    fprintf('Input:\n');
    fprintf('- block size [width height] = [%d %d]\n', bsz(1), bsz(2));
    % fprintf('- moving speed [horizontal vertical] = [%d %d]\n', mspd(1), mspd(2));
    % fprintf('- searching region [horizontal vertical] = [%d %d]\n', sreg(1), sreg(2));
    % fprintf('- up-bound of MSE = %g\n', eps);
    fprintf('Output:\n');
    fprintf('- MSE = %g\n', getMSE(Fr2, Fr2h));
    fprintf('- PSNR = %g\n', getPSNR(Fr2, Fr2h));
    
    % print predicted frame
    figure; imshow(Fr2h/max(max(Fr2h(:)))); % predicted frame
    fname = sprintf('predicted-size%dby%d.eps', bsz(1), bsz(2));
    print(fname,'-depsc');
end

toc;