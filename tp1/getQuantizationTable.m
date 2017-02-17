function TabQ = getQuantizationTable(Q)
% function getQuantizationTable generates quantization table 
% based on the quality factor Q

% quatization table for quality factor equal to 50
Tab50 = [16  11  10  16  24   40   51   61;...
         12  12  14  19  26   58   60   55;...
         14  13  16  24  40   57   69   56;...
         14  17  22  29  51   87   80   62;...
         18  22  37  56  68   109  103  77;...
         24  35  55  64  81   104  113  92;...
         49  64  78  87  103  121  120  101;...
         72  92  95  98  112  100  103  99];

if Q < 50
    E = 50/Q;
else
    E = 2 - Q/50;
end

% create quantization table for Q
if Q == 50
    TabQ = Tab50;
else
    TabQ = Tab50*E + 0.5;
end