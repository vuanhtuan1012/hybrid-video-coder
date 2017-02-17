function createPreVideo(c, Q, bsz)
% function createPreVideo creates predicted video of the video foreman.yuv
% based on predefined GOP, quality factor and
% block size of prediction mode list0.

switch nargin
    case 0
        c = 0;
        Q = 10; % quality factor of compression
        bsz = [16 16]; % block size 16 by 16
    case 1
        Q = 10;
        bsz = [16 16];
    case 2
        bsz = [16 16];
end

% initial
fname = 'foreman.yuv'; % video file name
dims = [176 144]; % dimensions of frame [width height]
numfrm = 300; % number of frames to read 300
startfrm = 0; % frame to start reading
[Y, U, V] = yuv_import(fname, dims, numfrm, startfrm);
% compressed frames
Ycp = cell(1, numfrm); % Y compressed
Ucp = cell(1, numfrm); % U compressed
Vcp = cell(1, numfrm); % V compressed

switch c
    case 1 % GOP = I
        for i = 1:numfrm
            Ycp{i} = compressIframe(Y{i}, Q);
            Ucp{i} = compressIframe(U{i}, Q);
            Vcp{i} = compressIframe(V{i}, Q);
        end
        
        % export to yuv file
        fname = sprintf('foreman_I_Q%d.yuv', Q);
        yuv_export(Ycp, Ucp, Vcp, fname, numfrm);
    
    case 2 % GOP = IB
        for i = 1:2:(numfrm-1)
            % Y frame
            I = Y{i}; B = Y{i+1};
            Ycp{i} = compressIframe(I, Q);
            Ycp{i+1} = compressBframe(B, I, Ycp{i}, bsz);
        
            % U frame
            I = U{i}; B = U{i+1};
            Ucp{i} = compressIframe(I, Q);
            Ucp{i+1} = compressBframe(B, I, Ucp{i}, bsz);
        
            % V frame
            I = V{i}; B = V{i+1};
            Vcp{i} = compressIframe(I, Q);
            Vcp{i+1} = compressBframe(B, I, Vcp{i}, bsz);
        end
        
        % export to yuv file
        fname = sprintf('foreman_IB_Q%d_size%dby%d.yuv', Q, bsz(1), bsz(2));
        yuv_export(Ycp, Ucp, Vcp, fname, numfrm);
        % bsz 16x16, Q = 10 => Elapsed time is  seconds.
        % bsz 16x16, Q = 15 => Elapsed time is 229.492161 seconds.
        % bsz 16x16, Q = 80 => Elapsed time is 387.043112 seconds.
        % bsz 16x16, Q = 95 => Elapsed time is 559.815534 seconds.
    
    case 3 % GOP = IBB
        for i = 1:3:(numfrm-2)
            % Y frame
            I = Y{i}; B1 = Y{i+1}; B2 = Y{i+2};
            Ycp{i} = compressIframe(I, Q);
            Ycp{i+1} = compressBframe(B1, I, Ycp{i}, bsz);
            Ycp{i+2} = compressBframe(B2, I, Ycp{i}, bsz);
            
            % U frame
            I = U{i}; B1 = U{i+1}; B2 = U{i+2};
            Ucp{i} = compressIframe(I, Q);
            Ucp{i+1} = compressBframe(B1, I, Ucp{i}, bsz);
            Ucp{i+2} = compressBframe(B2, I, Ucp{i}, bsz);
            
            % V frame
            I = V{i}; B1 = V{i+1}; B2 = V{i+2};
            Vcp{i} = compressIframe(I, Q);
            Vcp{i+1} = compressBframe(B1, I, Vcp{i}, bsz);
            Vcp{i+2} = compressBframe(B2, I, Vcp{i}, bsz);
        end
        
        % export to yuv file
        fname = sprintf('foreman_IBB_Q%d_size%dby%d.yuv', Q, bsz(1), bsz(2));
        yuv_export(Ycp, Ucp, Vcp, fname, numfrm);
        % bsz 16x16, Q = 10 => Elapsed time is 233.899963 seconds.
        % bsz 16x16, Q = 15 => Elapsed time is 249.803069 seconds.
        % bsz 16x16, Q = 80 => Elapsed time is 346.058787 seconds.
        % bsz 16x16, Q = 95 => Elapsed time is 469.635743 seconds.
        
    otherwise % help
        fprintf('function createPreVideo creates predicted video of the');
        fprintf('  video foreman.yuv\nbased on predefined GOP, quality factor and');
        fprintf(' block size of prediction mode list0.\n');
        fprintf('- Struct: createPreVideo(c, Q, bsz)\n');
        fprintf('- Where:\n');
        fprintf('-- c: case of GOP, by default c = 0\n');
        fprintf('---- c = 1 => GOP = I\n');
        fprintf('---- c = 2 => GOP = IB\n');
        fprintf('---- c = 3 => GOP = IBB\n');
        fprintf('---- otherwise => help\n');
        fprintf('-- Q: quality factor of compression, by default Q = 10\n');
        fprintf('-- bsz: block size of prediction mode, by default bsz = [16 16]\n');
end