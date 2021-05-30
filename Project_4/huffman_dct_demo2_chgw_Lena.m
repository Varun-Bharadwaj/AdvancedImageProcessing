function huffman_dct_demo2_chgw_Lena()
%HUFFMAN_DEMO: huffman_dct_demo2_chgw_Lena()
%  This demo shows compression-decompression of Lena
%  using the DCT and huffman code m-files written
%  by Giuseppe Ridino and modified for uint16 by Cameron Wright.
%  This demos differs only in that it subtracts off the 
%  midpoint value (128) before taking the DCT.

% set threshold for DCT coefficient trunction
threshold = 20;

% Hardcode an increased font size globally for figures
set(0,'DefaultAxesFontSize',14);
set(0,'DefaultTextFontSize',14);

fprintf('\n')
disp('This is an example of image compression-decompression,')
disp('combining the information packing attributes of the DCT with the')
disp('coding efficiency of Huffman coding.')
fprintf('\n')
disp('The 512x512 8-bit Lena image will be compressed and decompressed')
disp('using dct2 and idct2 from the SP toolbox and the norm2huff_16 and')
disp('huff2norm_16 functions.')
disp('Working...')

load lena
% the 512x512 8-bit image matrix is called A512
% A512 is already in uint8 format, so no conversion is needed here
[M,N]=size(A512);  % need to know original dimensions of image
% don't need doubles, use integers to save space later
M=uint16(M);
N=uint16(N);
% preallocate some arrays
AA=zeros(M,N);
AAA=AA;

% take the DCT of the image, B will be an MxN array of real doubles
% subtract off the midpoint value
B=dct2(A512-128);

% now hard threshold the smaller DCT coefficients
Bt=B;  % must copy B to Bt first
Bt(abs(Bt) < threshold) = 0;

% scale to a 0-65535 range prior to converting to uint16
% must save the scaling values so you can undo it later
L=2^16;  % 65536, the number of allowed levels
L1=L-1;
Btmin=min(min(Bt));
Bt=Bt-Btmin; % shift by the minimum value
Btmax=max(max(Bt));
scale=L1/Btmax;  % compression or expansion factor
Bt=Bt*scale; % force to L-1 max value
Bt=round(Bt);  % force to integer

Bt=uint16(Bt);  % convert to uint16

% encode the data
[huff,table] = norm2huff_16(Bt);

% extract just the huffman code book to store
hbook=table.huffcodes;

% then decode the data
% decoded data comes back as a vector 
unhuff = huff2norm_16(huff,table);

% need to reformat the image back to the rows and columns
k=1;
for n=1:N
    for m=1:M
        AA(m,n)=unhuff(k);
        k=k+1;
    end
end
% we now have the scaled DCT coefficients, in the right MxN format

% convert from char to double before we "unscale"
AA=double(AA);

% now let's "unscale" the DCT coefficients
AA=AA/scale;
AA=AA+Btmin;

% now take the inverse DCT
AAA=idct2(AA);

% for testing purposes
%min(min(AAA))
%max(max(AAA))

AAA=AAA+128;  % add back in the midpoint value

% convert image array back into the original uint8 data type
AAA=uint8(AAA);



isOK = isequal(A512,AAA); % check if before/after the same

fprintf('\n')  % skip a line
if (isOK)
    disp('The decoded image is exactly equal to the original image.')
else
    disp('The decoded image is NOT equal to the original image.')
    fprintf('The MSE is %g \n', my_mse(A512,AAA))
end
fprintf('\n')  % skip a line

% show size of some key data variables
whos A512 huff unhuff AAA hbook M N

% calculate the compression ratio
wA512=whos('A512');
whuff=whos('huff');
CR=wA512.bytes/whuff.bytes;
fprintf('The raw compression ratio is %g \n', CR)
whbook=whos('hbook');
wM=whos('M');
wN=whos('N');
CRO=wA512.bytes/(whuff.bytes+whbook.bytes+wM.bytes+wN.bytes);
fprintf('The compression ratio with overhead is %g \n', CRO)

% save to disk to check file relative sizes, v6 stops extra compression
% save -v6 myLenaB4 A512;
% save -v6 myLenaB5 huff hbook M N;

% display results
close all % close all figure windows

figure(1)
bar(frequency(A512)); 
axis tight
title('Raw data histogram for Lena image')
figure(2)
B_plot=log10(abs(B)+1);
ip_dispsc(B_plot)
title('DCT magnitude (dB) spectrum of Lena image')
xlabel('Origin is upper left corner')
figure(3)
mesh(B_plot)
title('DCT magnitude (dB) spectrum of Lena image')
figure(4)
ip_disp(abs(B))
title('DCT magnitude spectrum of Lena image')
xlabel('Origin is upper left corner')
figure(5)
subplot(1,2,1)
ip_disp(A512)
xlabel('Before')
subplot(1,2,2)
ip_disp(AAA)
xlabel('After')

figure(1)


% finished
disp('Demo finished!')
