X = zeros(64,64,3);
X(33:64,1:32,2) = 255;
X(1:32,33:64,2) = 255;
X(1:32,1:32,3) = 255;
X(33:64,33:64,1) = 255;
f = [1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1 1;];
f = f.*(1/81);

Z = repmat(X,4,4);
Z1 = Z./255;

[Y,Cb,Cr] = RGB_YCbCr(Z1);
YCbCr = zeros(256,256,3);
y1 = ib_filt(Y,f);
YCbCr(:,:,1) = y1;
YCbCr(:,:,2) = Cb;
YCbCr(:,:,3) = Cr;

Cb = Cb+0.5;
Cr = Cr+0.5;
figure
subplot(2,2,1)
ip_dispc(Z)
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