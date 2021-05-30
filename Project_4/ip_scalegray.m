function B=ip_scalegray(A,n)
% simplified routine to scale image A 
%  to full range of n-bit display
%
% B=ip_scalegray(A,n)
%
% Copyright (c) 2004, 2005 Cameron H. G. Wright

L=2^n;
L1=L-1;

A=double(A); % just in case

minA=min(min(A));
B=A-minA; % shift

maxB=max(max(B));
if maxB~=0
    B=B*L1/maxB; % compress or expand
end

% Note: do NOT round in this routine!
% Take care of this in the calling routine if needed
