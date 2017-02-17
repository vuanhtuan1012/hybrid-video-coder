function [ycor, xcor] = getBestMatching(B, refFr, bcor, mspd, sreg, eps)
% function getBestMatching returns the best matching of a block
% in reference frame
% return coordinate of the top-left corner of matched block

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

% initial
[height, width] = size(refFr); % height, width of frame
[bhei, bwid] = size(B);
hspd = mspd(1); % horizontal speed
vspd = mspd(2); % vertical speed
xb = bcor(2) - sreg(1); % begin of x coordinate to find matching
if xb < 1
    xb = 1;
end
xe = bcor(2) + bwid - 1 + sreg(1); % end of x coordinate to find matching
if xe > width - bwid + 1
    xe = width - bwid + 1;
end
yb = bcor(1) - sreg(2); % begin of y coordinate to find matching
if yb < 1
    yb = 1;
end
ye = bcor(1) + bhei - 1 + sreg(2); % end of y coordinate to find matching
if ye > height - bhei + 1
    ye = height - bhei + 1;
end

% find the coordinate of top-left corner of matched block
mse = -1; % initial of MSE
xcor = 0; ycor = 0; % initial of matched block coordinate

for i = yb:vspd:ye
    for j = xb:hspd:xe
        temp = getMSE(B, refFr(i:i+bhei-1, j:j+bwid-1));
        if (mse == -1) || (temp < mse)
            mse = temp;
            ycor = i;
            xcor = j;
        end
        if mse <= eps
            break;
        end
    end
    if mse <= eps
        break;
    end
end