function QM = qtzDCT(M, BSZ, Q)
% function qtzDCT returns quantized matrix following DCT quantization
% of matrix M with block size BSZ at quality Q.

TabQ = getQuantizationTable(Q);
fun = @(block_struct) block_struct.data./TabQ;
QM = blockproc(M, BSZ, fun); % quantized DCT
QM = round(QM);