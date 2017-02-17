function mse = getMSE(Im1, Im2)
% function getMSE returns Mean Square Error between two images

Dif = Im1-Im2;
mse = mean2(Dif.^2);