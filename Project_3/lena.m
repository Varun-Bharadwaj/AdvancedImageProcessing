Z = imread('lena_color_512.tif');
Z = double(Z); 
figure
subplot(2,2,1)
ip_dispc(Z)
subplot(2,2,2)
ip_dispsc(Z(:,:,1))
title('R')
subplot(2,2,3)
ip_dispsc(Z(:,:,2))
title('G')
subplot(2,2,4)    
ip_dispsc(Z(:,:,3))
title('B')
print('Lena RGB components','-djpeg')

A1 = Z;

%normalize the values
A1(:,:,1) = A1(:,:,1)/255; %R
A1(:,:,2) = A1(:,:,2)/255; %G
A1(:,:,3) = A1(:,:,3)/255; %B

%RGB to HSI conversion
[H,S,I] = RGB_HSI(A1,512,512);
HSI = zeros(512,512,3);
%Adjusting the skin tone of the image
I1 = ((I.*255) - 35)./(255);
HSI(:,:,1) = H;
HSI(:,:,2) = S;
HSI(:,:,3) = I1;
H = H./(360);

figure
subplot(2,2,1)
ip_dispc(Z)
subplot(2,2,2)
ip_disp(H.*255)
title('H')
subplot(2,2,3)
ip_disp(S.*255)
title('S')
subplot(2,2,4)
ip_disp(I.*255)
title('I')
print('Lena HSI components','-djpeg')

%HSI to RGB conversion
[R,G,B] = HSI_RGB(HSI,512,512);
rgb = zeros(512,512,3);
rgb(:,:,1) = R.*255;
rgb(:,:,2) = G.*255;
rgb(:,:,3) = B.*255;

figure
subplot(1,2,1)
ip_dispc(Z)
title('Original image')
subplot(1,2,2)
ip_dispc(rgb)
title('Modified image')
print('Skin tone modified image of Lena','-djpeg')