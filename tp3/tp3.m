tic;
Q = 10:10:100;
N = length(Q);

% case 1: fix block size to [16 16]
bsz = [16 16];
fprintf('CASE 1\n');
for i = 1:N
    fprintf('- Q = %d\n', Q(i));
    createPreVideo(1, Q(i), bsz); % GOP = I
    createPreVideo(2, Q(i), bsz); % GOP = IB
    createPreVideo(3, Q(i), bsz); % GOP = IBB
end

% case 2: fix GOP to IB
fprintf('CASE 2\n');
fprintf('- bsz = 16x8\n');
bsz = [16 8];
for i = 1:N
    fprintf('-- Q = %d\n', Q(i));
    createPreVideo(2, Q(i), bsz); % GOP = IB
end

fprintf('- bsz = 8x16\n');
bsz = [8 16];
for i = 1:N
    fprintf('-- Q = %d\n', Q(i));
    createPreVideo(2, Q(i), bsz); % GOP = IB
end

fprintf('- bsz = 8x8\n');
bsz = [8 8];
for i = 1:N
    fprintf('-- Q = %d\n', Q(i));
    createPreVideo(2, Q(i), bsz); % GOP = IB
end
toc;