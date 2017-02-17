function [DC, AC] = im2jpeg(I, Q)
% function IM2JPEG compresses image I to DC, AC coefficients at quality Q

I = double(I);
BDCT = blkDCT(I, [8 8]); % DCT by blocks
QDCT = qtzDCT(BDCT, [8 8], Q); % quantize block DCT
[DC, AC] = getCoefficients(QDCT); % get compressed DC, AC