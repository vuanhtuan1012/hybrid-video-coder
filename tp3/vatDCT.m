function RM = vatDCT(I)
% function vatDCT returns the Discrete Cosine Transform (DCT) of image I.
% This function is written by VU Anh Tuan. That's why it's called vatDCT

[m, n] = size(I);
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
% I = double(I);
RM = A*I*A'; % returned matrix