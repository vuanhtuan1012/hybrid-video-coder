function I = iblkDCT(M, BSZ)
% function iblkDCT inverses DCT by block of the matrix M
% with block size BSZ to reconstructed image I

fun = @(block_struct) ivatDCT(block_struct.data);
I = blockproc(M, BSZ, fun);
I = uint8(I);