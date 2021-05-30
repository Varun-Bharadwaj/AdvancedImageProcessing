function ip_disp(A)
% simplified routine to display 8-bit gray scale images
% Syntax: ip_disp(A) 
% where A is an image matrix, typically uint8
%
% Copyright 2004-2008 Cameron H. G. Wright

L=256;
L1=L-1;
A=double(A); % just in case
[X Y]=size(A);
% switch X and Y for proper image display
% (0,0) is in UL corner with X rows and Y columns
image(0:Y-1,0:X-1,A)
axis ij
axis equal
axis tight
colormap(gray(L))
end

