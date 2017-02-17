function Bcp = compressBframe(B, I, Icp, bsz)
% function compressBframe returns compressed version of B-frame

[MV, ~] = encodeFrame(B, I, bsz); % encoding
Bcp = decodeBframe(Icp, MV, bsz); % decoding