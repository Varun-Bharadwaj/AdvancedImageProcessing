image=zeros(256,256,3);
image(:,129:256,1)=255; 
image(:,129:256,2)=255; 
image(1:128,:,3)=255; 
[X,Y,Z] = size(image);
V = image;

%normalize the values
image(:,:,1) = image(:,:,1)/255; %R
image(:,:,2) = image(:,:,2)/255; %G
image(:,:,3) = image(:,:,3)/255; %B


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
subplot(2,2,3)
ip_disp(Cb.*255)
subplot(2,2,4)
ip_disp(Cr.*255)

[r1,g1,b1] = YCbCr_RGB(YCbCr);
rgb = zeros(256,256,3);
rgb(:,:,1) = r1.*255;
rgb(:,:,2) = g1.*255;
rgb(:,:,3) = b1.*255;

figure
subplot(2,2,1)
ip_dispc(rgb)
subplot(2,2,2)
ip_disp(r1.*255)
subplot(2,2,3)
ip_disp(g1.*255)
subplot(2,2,4)
ip_disp(b1.*255)

%Applying smoothing filter to YCbCr image
y1 = ib_filt(Y,f);
YCbCr(:,:,1) = y1;
YCbCr(:,:,2) = Cb;
YCbCr(:,:,3) = Cr;
%YCbCr to RGB conversion
[R2,G2,B2] = YCbCr_RGB(YCbCr);
RGB2 = zeros(256,256,3);
RGB2(:,:,1) = R2.*255;
RGB2(:,:,2) = G2.*255;
RGB2(:,:,3) = B2.*255;