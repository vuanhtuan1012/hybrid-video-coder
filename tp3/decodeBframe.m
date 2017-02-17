function decFr = decodeBframe(RefFr, MV, bsz)
% function decodeBframe decodes motion vectors
% based on the Block Matching Algorithm in forward prediction mode
% return decoded frame

% initial
[height, width] = size(RefFr);
bwid = bsz(1); % width of block
bhei = bsz(2); % height of block

% zeros padding if width, height
% is not an integer times of bwid, bhei respectively
% % initial for zeros padding
hei = height;
wid = width;
% % zeros padding in horizontal direction
times = ceil(wid/bwid);
if wid < times*bwid
    wid = times*bwid;
    RefFr(:,width+1:wid) = 0;
end
% % zeros padding in veritcal direction
times = ceil(hei/bhei);
if hei < times*bhei
    hei = times*bhei;
    RefFr(height+1:hei,:) = 0;
end

% get cordinate of top-left corner of block
tmp = 0:bwid:wid;
X = tmp(2:end); % x coordinate
tmp = 0:bhei:hei;
Y = tmp(2:end); % y coordinate
xlen = length(X);
ylen = length(Y);

decFr = zeros(hei, wid); % initial decoded frame

% match block to decoded frame
for i = 1:ylen
    yb = Y(i) - bhei + 1; % begin of block y coordinate
    ye = Y(i); % end of block y coordinate
    for j = 1:xlen
        xb = X(j) - bwid + 1; % begin of block x coordinate
        xe = X(j); % end of block x coordinate
        k = (i-1)*xlen + j; % index of block in motion vector
        % top-left coordinate of matching block
        y = yb + MV(k, 1);
        x = xb + MV(k, 2);
        decFr(yb:ye, xb:xe) = RefFr(y:y+bhei-1, x:x+bwid-1);
    end
end

decFr = decFr(1:height,1:width);  % cutoff zeros padding