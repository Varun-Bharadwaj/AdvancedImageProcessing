%Creating an RGB image
image=zeros(256,256,3);
image(:,129:256,1)=255; 
image(:,129:256,2)=255; 
image(1:128,:,3)=255; 
[X,Y,Z] = size(image);
V = image;

figure
subplot(2,2,1)
ip_dispc(image)
subplot(2,2,2)
ip_dispsc(image(:,:,1))
title('R')
subplot(2,2,3)
ip_dispsc(image(:,:,2))
title('G')
subplot(2,2,4)
ip_dispsc(image(:,:,3))
title('B')
print('RGB components','-djpeg')

%normalize the values
image(:,:,1) = image(:,:,1)/255; %R
image(:,:,2) = image(:,:,2)/255; %G
image(:,:,3) = image(:,:,3)/255; %B

%RGB to HSI conversion
[H,S,I] = RGB_HSI(image,256,256);
HSI = zeros(256,256,3);
HSI(:,:,1) = H;
HSI(:,:,2) = S;
HSI(:,:,3) = I;

H = H./(360);%normalise the value

figure
subplot(2,2,1)
ip_dispc(V)
subplot(2,2,2)
ip_disp(H.*255)
title('H')
subplot(2,2,3)
ip_disp(S.*255)
title('S')
subplot(2,2,4)
ip_disp(I.*255)
title('I')
print('HSI components','-djpeg')

% [r,g,b] = HSI_RGB(HSI,256,256);
% figure
% subplot(2,2,1)
% ip_dispc(V)
% subplot(2,2,2)
% ip_disp(r.*255)
% subplot(2,2,3)
% ip_disp(g.*255)
% subplot(2,2,4)
% ip_dispsc(b.*255)

%RGB to YCbCr conversion
[Y,Cb,Cr] = RGB_YCbCr(image);
YCbCr = zeros(256,256,3);
YCbCr(:,:,1) = Y;
YCbCr(:,:,2) = Cb;
YCbCr(:,:,3) = Cr;

Cb = Cb+0.5;
Cr = Cr+0.5;
figure
subplot(2,2,1)
ip_dispc(V)
subplot(2,2,2)
ip_disp(Y.*255)
title('Y')
subplot(2,2,3)
ip_disp(Cb.*255)
title('Cb')
subplot(2,2,4)
ip_disp(Cr.*255)
title('Cr')
print('YCbCr components','-djpeg')

[r1,g1,b1] = YCbCr_RGB(YCbCr);
figure
subplot(2,2,1)
ip_dispc(V)
subplot(2,2,2)
ip_disp(r1.*255)
subplot(2,2,3)
ip_disp(g1.*255)
subplot(2,2,4)
ip_disp(b1.*255)