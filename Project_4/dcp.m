load Comp.mat

%Decoding from Huffman to normal
v = huff2norm_16(z,in);
vector = huff2norm_16(zipped,info);
vector1 = huff2norm_16(zipped1,info1);
vector2 = huff2norm_16(zipped2,info2);
vector3 = huff2norm_16(zipped3,info3);
vector4 = huff2norm_16(zipped4,info4);
vector5 = huff2norm_16(zipped5,info5);

%Reshaping the vector to get the matrix
A2 = reshape(v,X2,Y2);
v1 = reshape(vector,X1,Y1);
h1 = reshape(vector1,X1,Y1);
d1 = reshape(vector2,X1,Y1);
v2 = reshape(vector3,X2,Y2);
h2 = reshape(vector4,X2,Y2);
d2 = reshape(vector5,X2,Y2);
A1 = zeros(X1,Y1);
A = zeros(X,Y);

%reconstruction of the image using inverse wavelet transform
Ar2 = idwt2(A2,h2,v2,d2,'db4','mode','per',size(A1));
Ar1 = idwt2(Ar2,h1,v1,d1,'db4','mode','per',size(A));

figure
ip_disp(Ar1)
title('Decompressed Image')
%print('Decompressed Image','-djpeg')
% err = immse(A,uint16(Ar1));
% err = sqrt(err);
% psr = psnr(A,uint16(Ar1));