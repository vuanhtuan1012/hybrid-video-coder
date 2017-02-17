function I = ivatDCT(M)
% function ivatDCT inverse normal DCT of a DCT matrix to an image.
% This function is written by VU Anh Tuan. That's why it is called ivat_dct

[m, n] = size(M);
if m ~= n
    fprintf('Function works on only square image\n');
    return;
end

% create cos matrix
i = 0:n-1;
T = (2*i+1)*pi/(2*n); % create T
X = cos(i'*T); % cos matrix

% create C
C = zeros(n);
C(1,:) = 1/sqrt(n);
C(2:n,:) = sqrt(2/n);

% create A
A = C.*X;

% compute DCT
I = A'*M*A; % returned image