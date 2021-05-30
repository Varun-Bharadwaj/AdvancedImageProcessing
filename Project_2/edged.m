load iptest_im.mat

A = iptest256a;
[X,Y] = size(A);

%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'haar', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'haar', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);

Ad = zeros(X,Y);
%zeroing approximation component for edge detection
A2 = zeros(X2,Y2);

Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) = ip_scalegray(h1,8);
Ad(X1+1:X,1:Y1) = ip_scalegray(v1,8);
Ad(X1+1:X,Y1+1:Y) = ip_scalegray(d1,8);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = ip_scalegray(h2,8);
Ad(X2+1:Y1,1:Y2) = ip_scalegray(v2,8);
Ad(X2+1:Y1,Y2+1:Y1) = ip_scalegray(d2,8);

%Reconstruction for edge detection
Ar2 = idwt2(A2,h2,v2,d2,'haar','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'haar','mode','per',size(A));

figure
ip_disp(Ad)
title('Two stages of decomposition using haar')
print('Two stages of decomposition using haar','-djpeg')

figure
ip_disp(ip_scalegray(Ar1,8))
title('Edge detection using haar')
print('Edge detection using haar','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sym4
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'sym4', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'sym4', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);

Ad = zeros(X,Y);
%zeroing approximation component for edge detection
A2 = zeros(X2,Y2);

Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) = ip_scalegray(h1,8);
Ad(X1+1:X,1:Y1) = ip_scalegray(v1,8);
Ad(X1+1:X,Y1+1:Y) = ip_scalegray(d1,8);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = ip_scalegray(h2,8);
Ad(X2+1:Y1,1:Y2) = ip_scalegray(v2,8);
Ad(X2+1:Y1,Y2+1:Y1) = ip_scalegray(d2,8);

%Reconstruction for edge detection
Ar2 = idwt2(A2,h2,v2,d2,'sym4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'sym4','mode','per',size(A));

figure
ip_disp(Ad)
title('Two stages of decomposition using sym4')
print('Two stages of decomposition using sym4','-djpeg')

figure
ip_disp(ip_scalegray(Ar1,8))
title('Edge detection using sym4')
print('Edge detection using sym4','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%haar
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'haar', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'haar', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);

%zeroing approximation and vertical components for horizontal edge detection
Ad = zeros(X,Y);
A2 = zeros(X2,Y2);
v1 = zeros(X1,Y1);
v2 = A2;

Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) = ip_scalegray(h1,8);
Ad(X1+1:X,1:Y1) = ip_scalegray(v1,8);
Ad(X1+1:X,Y1+1:Y) = ip_scalegray(d1,8);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = ip_scalegray(h2,8);
Ad(X2+1:Y1,1:Y2) = ip_scalegray(v2,8);
Ad(X2+1:Y1,Y2+1:Y1) = ip_scalegray(d2,8);

%Reconstruction for edge detection
Ar2 = idwt2(A2,h2,v2,d2,'haar','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'haar','mode','per',size(A));

figure
ip_disp(Ad)
title('Two stages of decomposition using haar(horizontal)')
print('Two stages of decomposition using haar(horizontal)','-djpeg')
figure
ip_disp(ip_scalegray(Ar1,8))
title('Horizontal edge detection using haar')
print('Horizontal edge detection using haar','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sym4
%1st level of decomposition
[A1,h1,v1,d1] = dwt2(A, 'sym4', 'mode', 'per');
%2nd level of decomposition
[A2,h2,v2,d2] = dwt2(A1, 'sym4', 'mode', 'per');

[X1,Y1] = size(A1);
[X2,Y2] = size(A2);

Ad = zeros(X,Y);
%zeroing approximation and vertical components for horizontal edge detection
A2 = zeros(X2,Y2);
v1 = zeros(X1,Y1);
v2 = A2;

Ad(1:X1,1:Y1) = ip_scalegray(A1,8);
Ad(1:X1,Y1+1:Y) = ip_scalegray(h1,8);
Ad(X1+1:X,1:Y1) = ip_scalegray(v1,8);
Ad(X1+1:X,Y1+1:Y) = ip_scalegray(d1,8);

Ad(1:X2,1:Y2) = ip_scalegray(A2,8);
Ad(1:X2,Y2+1:Y1) = ip_scalegray(h2,8);
Ad(X2+1:Y1,1:Y2) = ip_scalegray(v2,8);
Ad(X2+1:Y1,Y2+1:Y1) = ip_scalegray(d2,8);

%Reconstruction for edge detection
Ar2 = idwt2(A2,h2,v2,d2,'sym4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'sym4','mode','per',size(A));

figure
ip_disp(Ad)
title('Two stages of decomposition using sym4(horizontal)')
print('Two stages of decomposition using sym4(horizontal)','-djpeg')

figure
ip_disp(ip_scalegray(Ar1,8))
title('Horizontal edge detection using sym4')
print('Horizontal edge detection using sym4','-djpeg')
