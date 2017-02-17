function IM = iqtzDCT(M, BSZ, Q)
% function iqtzDCT returns inverse matrix of quantized
% matrix M with block size BSZ at qualtiy factor Q

TabQ = getQuantizationTable(Q);
fun = @(block_struct) block_struct.data.*TabQ;
IM = blockproc(M, BSZ, fun);