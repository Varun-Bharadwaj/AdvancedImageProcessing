load iptest_im.mat
A = iptest256a;

[X,Y] = size(A);

%Haar
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'haar', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'haar', 'mode', 'per');
%3rd level of decomposition
[A3,h3,v3,d3] = dwt2(A2, 'haar', 'mode', 'per');

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

%reconstruction of the image
Ar3 = idwt2(A3,h3,v3,d3,'haar','mode','per',size(A2));
Ar2 = idwt2(Ar3,h2,v2,d2,'haar','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'haar','mode','per',size(A));

Ar = A - uint8(Ar1);
figure
ip_disp(A)
title('Original image')
print('Original image','-djpeg')

figure
ip_disp(Ad)
title('Three stages of decomposition using haar')
print('Three stages of decomposition using haar','-djpeg')

figure
ip_disp(Ar1)
title('Reconstructed image using haar')
print('Reconstructed image using haar','-djpeg')

figure
ip_dispsc(Ar)
title('Difference between original and reconstructed image using haar')
print('Difference between original and reconstructed image using haar','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sym4
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'sym4', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'sym4', 'mode', 'per');
%3rd level of decomposition
[A3,h3,v3,d3] = dwt2(A2, 'sym4', 'mode', 'per');

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

%reconstruction of the image
Ar3 = idwt2(A3,h3,v3,d3,'sym4','mode','per',size(A2));
Ar2 = idwt2(Ar3,h2,v2,d2,'sym4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'sym4','mode','per',size(A));

Ar = A - uint8(Ar1);

ip_disp(Ad)
title('Three stages of decomposition using sym4')
print('Three stages of decomposition using sym4','-djpeg')

figure
ip_disp(Ar1)
title('Reconstructed image using sym4')
print('Reconstructed image using sym4','-djpeg')

figure
ip_dispsc(Ar)
title('Difference between original and reconstructed image using sym4')
print('Difference between original and reconstructed image using sym4','-djpeg')