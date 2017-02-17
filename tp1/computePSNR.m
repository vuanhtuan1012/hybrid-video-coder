function PSNR = computePSNR(I1, I2)
% function computePSNR computes the PSNR between two images I1, I2

I1 = double(I1); I2 = double(I2);
MSE = mean2((I1-I2).^2);
PSNR = 10*log10(255^2/MSE);