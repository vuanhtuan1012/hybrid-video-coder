function I = jpeg2im(DC, AC, IMS, Q)
% function JPEG2IM decodes the encoded DC, AC coefficients
% following jpeg compression at quality factor Q to image size IMS 

DECOEF = deCoefficients(DC, AC, IMS); % decompress coefficients
IQDCT = iqtzDCT(DECOEF, [8 8], Q); % inverse quantize DCT
I = iblkDCT(IQDCT, [8 8]); % inverse DCT by blocks
I = double(I);