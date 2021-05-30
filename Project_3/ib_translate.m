function B = ib_translate (IN, tx, ty)
% IN = imread('Proj_002_image2.tif');
% load lena
% IN = A512;
% tx = 150.75;
% ty = -67.3;
[xog,yog] = size(IN); % size of the input image
B = zeros(xog,yog); % matrix to store final image

for i=1:xog
    for j=1:yog
        Xd = i - tx; % transformed X coordinates 
        Yd = j - ty; % transformed Y coordinates
        if(Yd>1 && Yd<yog && Xd>1 && Xd<xog) % Discarding values exceeding the input image dimension
            
            %Performing bilinear interpolation
            Ydf = floor(Yd);
            Xdf = floor(Xd);
            dx = Xd - Xdf;
            dy = Yd - Ydf;
            B(i,j) = (1-dy)*[(1-dx)*IN(Xdf,Ydf)+dx*IN(Xdf+1,Ydf)] + (dy)*[(1-dx)*IN(Xdf,Ydf+1)+dx*IN(Xdf+1,Ydf+1)];
        end
    end
end

B = round(B); % rounding the final value

% figure
% ip_disp(IN); % display
% title("Original Image");
% print('Original Image','-djpeg');
% 
% figure
% ip_disp(B); % display
% title("Translated Image");
% print('Translated Image','-djpeg');