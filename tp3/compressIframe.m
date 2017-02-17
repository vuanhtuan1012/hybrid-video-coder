function Ih = compressIframe(I, Q)
% function compressIframe returns compressed version of I-frame

[DC, AC] = im2jpeg(I, Q); % forward
IMS = size(I);
Ih = jpeg2im(DC, AC, IMS, Q); % backward