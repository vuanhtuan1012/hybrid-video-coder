f1 = 'foreman.yuv'; % video file name
Q = 10:10:100;
dims = [176 144]; % dimensions of frame [width height]
numfrm = 300; % number of frames to read 300
startfrm = 0; % frame to start reading
[Y1, U1, V1] = yuv_import(f1, dims, numfrm, startfrm);
N = length(Q);

% CASE 1: fixed block size to 16 by 16
I_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_I_Q%d.yuv', Q(i));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    I_PSNR(i) = 10*log10(255^2/MSE);
end

IB_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IB_Q%d_size16by16.yuv', Q(i));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    IB_PSNR(i) = 10*log10(255^2/MSE);
end

IBB_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IBB_Q%d_size16by16.yuv', Q(i));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    IBB_PSNR(i) = 10*log10(255^2/MSE);
end

figure; plot(Q, I_PSNR, Q, IB_PSNR, Q, IBB_PSNR);
legend('GOP = I', 'GOP = IB', 'GOP = IBB', 'Location', 'northwest');
xlabel('Quality Factor'); ylabel('PSNR');
title('different GOPs with block size 16x16');
print('foreman-fixedBsz.eps', '-depsc');

% CASE 2: fixed GOP = IB
B1 = [16 16];
B1_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IB_Q%d_size%dby%d.yuv', Q(i), B1(1), B1(2));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    B1_PSNR(i) = 10*log10(255^2/MSE);
end

B2 = [16 8];
B2_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IB_Q%d_size%dby%d.yuv', Q(i), B2(1), B2(2));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    B2_PSNR(i) = 10*log10(255^2/MSE);
end

B3 = [8 16];
B3_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IB_Q%d_size%dby%d.yuv', Q(i), B3(1), B3(2));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    B3_PSNR(i) = 10*log10(255^2/MSE);
end

B4 = [8 8];
B4_PSNR = zeros(1, N);
for i = 1:N
    f2 = sprintf('foreman_IB_Q%d_size%dby%d.yuv', Q(i), B4(1), B4(2));
    [Y2, U2, V2] = yuv_import(f2, dims, numfrm, startfrm);
    MSE = 0;
    for j = 1:numfrm
        MSE = MSE + getMSE(Y1{j}, Y2{j});
        MSE = MSE + getMSE(U1{j}, U2{j});
        MSE = MSE + getMSE(V1{j}, V2{j});
    end
    B4_PSNR(i) = 10*log10(255^2/MSE);
end

figure; plot(Q, B1_PSNR, Q, B2_PSNR, Q, B3_PSNR, Q, B4_PSNR);
legend('16x16', '16x8', '8x16', '8x8', 'Location', 'northwest');
xlabel('Quality Factor'); ylabel('PSNR');
title('GOP = IB with different block sizes');
print('foreman-fixedGOP.eps', '-depsc');