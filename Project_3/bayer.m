X = zeros(64,64,3);
%Creating a small portion of bayer image
X(33:64,1:32,2) = 255;
X(1:32,33:64,2) = 255;
X(1:32,1:32,3) = 255;
X(33:64,33:64,1) = 255;
%9x9 unweigthed filter
f = ones(9);
f = f.*(1/81);

%Creating bayer pattern using repmat
Z = repmat(X,4,4);
Z1 = Z./255;

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
print('Bayer RGB components','-djpeg')

%RGB to HSI conversion
[H,S,I] = RGB_HSI(Z1,256,256);
h = H; s = S; i = I;
H = H./(2*pi);
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
print('Bayer HSI components','-djpeg')

%Applying smoothing filter to RGB image
R = ib_filt(Z(:,:,1),f);
G = ib_filt(Z(:,:,2),f);
B = ib_filt(Z(:,:,3),f);
RGB = zeros(256,256,3);
RBG(:,:,1) = R;
RBG(:,:,2) = G;
RBG(:,:,3) = B;

%Applying smoothing filter to HSI image
I1 = ib_filt(i,f);
HSI = zeros(256,256,3);
HSI(:,:,1) = h;
HSI(:,:,2) = s;
HSI(:,:,3) = I1;
%HSI to RGB conversion
[R1,G1,B1] = HSI_RGB(HSI,256,256);
RGB1 = zeros(256,256,3);
RBG1(:,:,1) = R1.*255;
RBG1(:,:,2) = G1.*255;
RBG1(:,:,3) = B1.*255;

%RGB to YbCr conversion
[Y,Cb,Cr] = RGB_YCbCr(Z1);
YCbCr = zeros(256,256,3);
%Applying smoothing filter to YCbCr image
y1 = ib_filt(Y,f);
YCbCr(:,:,1) = y1;
YCbCr(:,:,2) = Cb;
YCbCr(:,:,3) = Cr;

%Adjusting the range to [0 1]
Cb = Cb+0.5;
Cr = Cr+0.5;
figure
subplot(2,2,1)
ip_dispc(Z)
subplot(2,2,2)
ip_disp(Y.*255)
title('Y')
subplot(2,2,3)
ip_disp(Cb.*255)
title('Cb')
subplot(2,2,4)
ip_disp(Cr.*255)
title('Cr')
print('Bayer YCbCr components','-djpeg')

%YCbCr to RGB conversion
[R2,G2,B2] = YCbCr_RGB(YCbCr);
RGB2 = zeros(256,256,3);
RGB2(:,:,1) = R2.*255;
RGB2(:,:,2) = G2.*255;
RGB2(:,:,3) = B2.*255;

figure
subplot(2,2,1)
ip_dispc(Z)
subplot(2,2,2)
ip_dispc(RBG)
title('RGB')
subplot(2,2,3)
ip_dispc(RBG1)
title('HSI')
subplot(2,2,4)
ip_dispc(RGB2)
title('YCbCr')
suptitle('RGB,HSI,YCbCr color models with smoothing')
print('RGB,HSI,YCbCr color models with smoothing','-djpeg')