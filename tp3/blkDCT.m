function BDCT = blkDCT(I, BSZ)
% function blkDCT returns the DCT by blocks
% with block size BSZ of image I.

fun = @(block_struct) vatDCT(block_struct.data);
BDCT = blockproc(I, BSZ, fun); % block DCT