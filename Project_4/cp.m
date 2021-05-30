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

%Thresholding the detail coefficients
v1(v1<65 & v1>-65) = 0;
h1(h1<65 & h1>-65) = 0;
d1(d1<110 & d1>-110)= 0;
v2(v2<25 & v2>-25) = 0;
h2(h2<25 & h2>-25) = 0;
d2(d2<110 & d2>-110) = 0;

%encoding the detail coefficients using Huffman coding
[z,in] = norm2huff_16(uint16(A2(:)));
[zipped,info] = norm2huff_16(uint16(v1(:)));
[zipped1,info1] = norm2huff_16(uint16(h1(:)));
[zipped2,info2] = norm2huff_16(uint16(d1(:)));
[zipped3,info3] = norm2huff_16(uint16(v2(:)));
[zipped4,info4] = norm2huff_16(uint16(h2(:)));
[zipped5,info5] = norm2huff_16(uint16(d2(:)));

%Saving the compressed file as .MAT -v6 file
save('Comp.mat','zipped','info','zipped1','info1','zipped2','info2','zipped3','info3','zipped4','info4','zipped5','info5','X','Y','X1','Y1','X2','Y2','z','in','-v6')

figure
ip_disp(A)
title('Original Image')
%print('Original Image','-djpeg')