function PSNR = getPSNR(Im1, Im2)
% function getPSNR returns PSNR between two images

MSE = getMSE(Im1, Im2);
PSNR = 10*log10(255^2/MSE);