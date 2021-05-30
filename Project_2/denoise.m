load lena_noise.mat

A = B512;
[X,Y] = size(A);

%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'db4', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'db4', 'mode', 'per');
%3rd level of decomposition
[A3,h3,v3,d3] = dwt2(A2, 'db4', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);
[X3,Y3] = size(A3);

Ad = zeros(X,Y);
Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) = ip_scalegray(h1,8);
Ad(X1+1:X,1:Y1) = ip_scalegray(v1,8);
Ad(X1+1:X,Y1+1:Y) = ip_scalegray(d1,8);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = ip_scalegray(h2,8);
Ad(X2+1:Y1,1:Y2) = ip_scalegray(v2,8);
Ad(X2+1:Y1,Y2+1:Y1) = ip_scalegray(d2,8);

Ad(1:X3,1:Y3) = ip_scalegray(A3,8);
Ad(1:X3,Y3+1:Y2) = ip_scalegray(h3,8);
Ad(X3+1:Y2,1:Y3) = ip_scalegray(v3,8);
Ad(X3+1:Y2,Y3+1:Y2) = ip_scalegray(d3,8);

%thresholding the coefficients
v1(-20<v1<20) = 0;
h1(-20<h1<20) = 0;
d1(-20<d1<20) = 0;
v2(-1<v2<1) = 0;
h2(-1.01<h2<1.01) = 0;
d2(-0.47<d2<0.47) = 0;

%reconstruction of the denoised image
Ar3 = idwt2(A3,h3,v3,d3,'db4','mode','per',size(A2));
Ar2 = idwt2(Ar3,h2,v2,d2,'db4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'db4','mode','per',size(A));

figure
ip_disp(A)
title("Noisy image")
%print('Noisy image','-djpeg')

figure
ip_disp(Ar1)
title("Denoised image")
%print('Denoised image','-djpeg')