function [Y,Cb,Cr] = RGB_YCbCr(image)

R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

Y = 0.2988*R + 0.5869*G + 0.1143*B;
Cb = -0.1689*R - 0.3311*G + 0.5000*B;
Cr = 0.5000*R - 0.4189*G - 0.0811*B;

