function yuv_export(Y,U,V,filename,numfrm)
%yuv_export(Y,U,V,filename,numfrm)
%Version: 1.01, Date: 2004/11/30, author: Nikola Sprljan
%Exports YUV sequence from Matlab
%
%Input:
% Y, U ,V - cell arrays of Y,U & V components 
% filename - name of the file in which YUV sequence is to be saved
% numfrm - number of frames to write
%
%Output:
% Y, U ,V - cell arrays of Y, U and V components  
%
%Note: 
% If the file already exists, the function appends frames
%
%Example:
% [Y, U, V] = yuv_import('F:\Seq\FullSeqs\basket_704x576x4.yuv',[704 576],2);
% export_yuv(Y,U,V,'seq_test.yuv');

fid=fopen(filename,'a'); %append!
if (fid < 0) 
    error('File does not exist!');
end;
fseek(fid, 0, 'eof');
if (ftell(fid)>1) 
    fprintf('Append \n');
end;
fseek(fid, 0, 'bof');

Yd = zeros(size(Y{1},2),size(Y{1},1));
UVd = zeros(size(U{1},2),size(U{1},1));

for i=1:numfrm
    Yd = Y{i}';
    fwrite(fid,Yd,'uint8');
    
    UVd = U{i}';  
    fwrite(fid,UVd,'uint8');
    UVd = V{i}'; 
    fwrite(fid,UVd,'uint8');   
end;
fclose(fid);