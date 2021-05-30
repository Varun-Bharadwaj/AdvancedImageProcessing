function [R,G,B] = YCbCr_RGB(A)

Y = A(:,:,1);
Cb = A(:,:,2);
Cr = A(:,:,3);

R = Y + 1.402*Cr;
G = Y - 0.3441*Cb -0.7141*Cr;
B = Y + 1.772*Cb + 0.00015*Cr;