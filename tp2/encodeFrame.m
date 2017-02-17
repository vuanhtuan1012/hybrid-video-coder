function [MV, RE] = encodeFrame(Fr2, Fr1, bsz, mspd, sreg, eps)
% function encodeFrame encodes a frame to motion vector and residual error
% based on the Block Matching Algorithm in forward prediction mode
% returns motion vectors and residual error frame

switch nargin
    case 3
        mspd = [1 1]; % moving speed [horizontal vertical]
        sreg = [5 5]; % searching region [horizontal vertical]
        eps = 0; % up-bound of MSE in finding best matching block
    case 4
        sreg = [5 5];
        eps = 0;
    case 5
        eps = 0;
end

if size(Fr2) ~= size(Fr1)
    disp 'Frame to encode and Reference frame must be same size';
    return;
end

% initial
[height, width] = size(Fr2);
bwid = bsz(1); % width of block
bhei = bsz(2); % height of block

% zeros padding if width, height
% is not an integer times of bwid, bhei respectively
% % initial for zeros padding
hei = height;
wid = width;
RefFr = Fr1;
Fr2Encode = Fr2;
% % zeros padding in horizontal direction
times = ceil(wid/bwid);
if wid < times*bwid
    wid = times*bwid;
    Fr2Encode(:,width+1:wid) = 0;
    RefFr(:,width+1:wid) = 0;
end
% % zeros padding in vertical direction
times = ceil(hei/bhei);
if hei < times*bhei
    hei = times*bhei;
    Fr2Encode(height+1:hei,:) = 0;
    RefFr(height+1:hei,:) = 0;
end

% get cordinate of top-left corner of block
tmp = 0:bwid:wid;
X = tmp(2:end); % x coordinate
tmp = 0:bhei:hei;
Y = tmp(2:end); % y coordinate

% initial motion vector
xlen = length(X);
ylen = length(Y);
N = xlen*ylen; % number of block
MV = zeros(N, 2);

PtdFr = zeros(hei,wid); % predicted frame

% get motion vector of each block
for i = 1:ylen
    yb = Y(i) - bhei + 1; % begin of block y coordinate
    ye = Y(i); % end of block y coordinate
    for j = 1:xlen
        xb = X(j) - bwid + 1; % begin of block x coordinate
        xe = X(j); % end of block x coordinate
        B = Fr2Encode(yb:ye, xb:xe); % get block
        bcor = [yb, xb]; % [y x] top-left coordinate of block
        [y, x] = getBestMatching(B, RefFr, bcor, mspd, sreg, eps);
        k = (i-1)*xlen + j; % index of block
        MV(k,:) = [y-yb x-xb];
        PtdFr(yb:ye, xb:xe) = RefFr(y:y+bhei-1, x:x+bwid-1);
    end
end

% compute residual error
PtdFr = PtdFr(1:height,1:width); % cutoff zeros padding
RE = PtdFr - Fr2; % Residual Error frame