function ip_dispc(A)
% simplified routine to display 24-bit color images
% Syntax: ip_dispc(A) 
% where A is an NxMx3 image matrix, typically uint8
% Forces A to uint8 for display purposes, so pixel
% values need to be on 0-255 range.
%
% Copyright 2004-2011 Cameron H. G. Wright

L=256;
L1=L-1;
A=uint8(A); % just in case
[X Y Z]=size(A);
% switch X and Y for proper image display
% (0,0) is in UL corner with X rows and Y columns
image(0:Y-1,0:X-1,A)
axis ij
axis equal
axis tight
end

