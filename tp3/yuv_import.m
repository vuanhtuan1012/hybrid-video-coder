function [Y,U,V]=yuv_import(filename,dims,numfrm,startfrm)
%[Y,U,V] = yuv_import(filename,dims,numfrm,startfrm)
%Version: 2.00, Date: 2004/11/30, author: Nikola Sprljan
%Imports YUV sequence into Matlab
%
%Input:
% filename - YUV sequence file
% dims - dimensions of the frame [width height]
% numfrm - number of frames to read
% startfrm - [optional, default = 0] specifies from which frame to start reading
%            with the convention that the first frame of the sequence is denoted 
%            with 0
%
%Output:
% Y, U ,V - cell arrays of Y, U and V components  
%
%Example:
% [Y, U, V] = yuv_import('FOREMAN_352x288_30_orig_01.yuv',[352 288],2);
% image_show(Y{1},256,1,'Y component');

fid=fopen(filename,'r');
if (fid < 0) 
    error('File does not exist!');
end;

Yd = zeros(dims(1),dims(2));
UVd = zeros(dims(1)/2,dims(2)/2);
frelem = numel(Yd) + 2*numel(UVd);

if (nargin == 4) %go to the starting frame
    fseek(fid, startfrm * frelem , 0);
end;

Y = cell(1,numfrm);
U = cell(1,numfrm);
V = cell(1,numfrm);
for i=1:numfrm
    Yd = fread(fid,[dims(1) dims(2)],'uint8');
    Y{i} = Yd';
    
    UVd = fread(fid,[dims(1)/2 dims(2)/2],'uint8');
    U{i} = UVd';
    UVd = fread(fid,[dims(1)/2 dims(2)/2],'uint8');
    V{i} = UVd';    
end;
fclose(fid);

%This below is leftover from the EZBC-MCTF codec using sequences
%with a separate file for each frame 
% if mode=='sep'
%     fid=fopen([filename sprintf('%03d',i) '.yuv'],'r');
% end;    
% if mode=='sep'
%     fclose(fid);
% end;