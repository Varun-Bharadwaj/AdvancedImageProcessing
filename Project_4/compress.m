load Lena_Proj4_V6.mat
A = uint16(A512);

[X,Y] = size(A);

%db4
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'db4', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'db4', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);

Ad = zeros(X,Y);
Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) =(h1);
Ad(X1+1:X,1:Y1) = (v1);
Ad(X1+1:X,Y1+1:Y) = (d1);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = (h2);
Ad(X2+1:Y1,1:Y2) = (v2);
Ad(X2+1:Y1,Y2+1:Y1) = (d2);

v1(v1<10 & v1>-10) = 0;
h1(h1<10 & h1>-10) = 0;
d1(d1<10 & d1>-10) = 0;
v2(v2<10 & v2>-10) = 0;
h2(h2<10 & h2>-10) = 0;
d2(d2<10 & d2>-10) = 0;

[zipped,info] = norm2huff_16(uint16(v1(:)));
[zipped1,info1] = norm2huff_16(uint16(h1(:)));
[zipped2,info2] = norm2huff_16(uint16(d1(:)));
[zipped3,info3] = norm2huff_16(uint16(v2(:)));
[zipped4,info4] = norm2huff_16(uint16(h2(:)));
[zipped5,info5] = norm2huff_16(uint16(d2(:)));

vector = huff2norm_16(zipped,info);
vector1 = huff2norm_16(zipped1,info1);
vector2 = huff2norm_16(zipped2,info2);
vector3 = huff2norm_16(zipped3,info3);
vector4 = huff2norm_16(zipped4,info4);
vector5 = huff2norm_16(zipped5,info5);

v1 = reshape(vector,256,256);
h1 = reshape(vector1,256,256);
d1 = reshape(vector2,256,256);
v2 = reshape(vector3,128,128);
h2 = reshape(vector4,128,128);
d2 = reshape(vector5,128,128);

%reconstruction of the image
Ar2 = idwt2(A2,h2,v2,d2,'db4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'db4','mode','per',size(A));

Ar = A - uint16(Ar1);

ip_disp(Ad)
title('Three stages of decomposition using db4')
%print('Three stages of decomposition using sym4','-djpeg')

figure
ip_disp(Ar1)
title('Reconstructed image using db4')
%print('Reconstructed image using sym4','-djpeg')
figure
ip_disp(A)

figure
ip_dispsc(Ar)
title('Difference between original and reconstructed image using db4')
%print('Difference between original and reconstructed image using sym4','-djpeg')

err = immse(A,uint16(Ar1));
err = sqrt(err);
psr = psnr(A,uint16(Ar1));
save('Comp.mat','zipped','info','zipped1','info1','zipped2','info2','zipped3','info3','zipped4','info4','zipped5','info5','X1','Y1','X2','Y2','-v6')