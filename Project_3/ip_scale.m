function OUT = ip_scale(IN, cx, cy)
%
% This function performs image scaling using the affine transformation
% matrix.  It uses the inverse mapping approach and bilinear interpolation 
% on a 2-D image to produce a scaled image of the same size 
% as the original.  Since the size stays the same, some cropping of the 
% original image may occur.
%
% Usage: OUT=ip_scale(IN, cx, cy)
%                  where IN is a 2-D image 8-bit grayscale, 
%                  cx and cy are scale factors.
% 
% The matrix generated is returned as OUT.  
%
% Copyright (c) 2011-2018 Cameron H. G. Wright
%
if nargin~=3
    error('Image matrix, cx and cy required as inputs');
end;

if (isvector(IN) || ndims(IN) > 2)
    error('Input must be a grayscale image matrix');
end;

if ~(isa(IN,'uint8'))
    error('Image matrix must be uint8');
end;

[xold, yold] = size(IN); % get size of image
IN=double(IN); % so math is correct on the pixel values

B=zeros(xold,yold);  % preallocate matrix same size as original
vw=zeros(1,3); % preallocate pixel vector

% create the affine transformation matrix for rotation
A=[ cx     0     0;
    0      cy    0;
    0      0     1];

% find the inverse matrix
Ai=inv(A);

% step through every pixel location in the output image (i,j) and find the 
% associated location in the input image (v,w), then perform bilinear
% interpolation as needed to assign the gray level for the output pixel
% location
for i=0:xold-1
    for j=0:yold-1
        % matrix math assumes origin is (0,0) not (1,1)
        vw=Ai*[i; j; 1]; % vw will be [v; w; 1]
        % next 2 lines for debugging only
%         s=sprintf('(x,y) = (%g,%g)  (v,w) = (%g,%g)',i,j,vw(1),vw(2));
%         disp(s);
        % extract v and w from vector for easier to use name
        % add 1 to get back to MATLAB indexing
        v=vw(1)+1;
        w=vw(2)+1;
        % skip if out of range location
        if ~((v < 1) || (v > xold) ||(w < 1) || (w > yold))
            vint=fix(v);
            dv=v-vint;
            wint=fix(w);
            dw=w-wint;
            % perform bilinear interpolation
            % special cases for endpoints of image A
            if (vint < xold) && (wint < yold)
                temp1=(1-dv)*IN(vint,wint)+(dv)*IN(vint+1,wint);
                temp2=(1-dv)*IN(vint,wint+1)+(dv)*IN(vint+1,wint+1);
                B(i+1,j+1)=(1-dw)*temp1+(dw)*temp2;
            elseif (vint == xold) && (wint < yold)
                temp1=IN(vint,wint);
                temp2=IN(vint,wint+1);
                B(i+1,j+1)=(1-dw)*temp1+(dw)*temp2;
            elseif (vint < xold) && (wint == yold)
                temp1=(1-dv)*IN(vint,wint)+(dv)*IN(vint+1,wint);
                B(i+1,j+1)=temp1;
            elseif (vint == xold) && (wint == yold)
                B(i+1,j+1)=IN(vint,wint);
            end
        end
    end
end


B=round(B);  % round to nearest integer
B=uint8(B);  % convert to 8-bit unsigned integer

% optional figures depending upon how the function was called
if nargout == 0 % then show results as figures
    close all
    figure(1)
    subplot(1,2,1)
    ip_disp(IN)
    title('original image')
    subplot(1,2,2)
    ip_disp(B)
    title('scaled image')
else % provide output matrix
    OUT=B;
end
