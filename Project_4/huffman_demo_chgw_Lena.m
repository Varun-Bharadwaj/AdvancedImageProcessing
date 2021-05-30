function huffman_demo_chgw_Lena()
%HUFFMAN_DEMO: huffman_demo_chgw_Lena()
%  This demo shows compression-decompression of Lena
%  using the m-files written by Giuseppe Ridino.
%  Also uses my_mse.m written by CHGW.

% Hardcode an increased font size globally for figures
set(0,'DefaultAxesFontSize',14);
set(0,'DefaultTextFontSize',14);

fprintf('\n')
disp('This is an example of standard Huffman compression-decompression.')
fprintf('\n')
disp('The 512x512 8-bit Lena image will be compressed and decompressed')
disp('using the norm2huff and huff2norm functions.')
disp('The image is in uint8 format.')
disp('Working...')

load lena
% the 512x512 8-bit image matrix is called A512
% A512 is already in uint8 format, so no conversion is needed here
A512a = uint16(A512);  
[M,N]=size(A512a);  % need to know original dimensions of image
AA=zeros(M,N);     % preallocate a holding array


% encode the data
[huff,table] = norm2huff_16(A512a);

% then decode the data
% decoded data comes back as a vector of 8-bit chars
unhuff = huff2norm_16(huff,table);

% need to reformat the image back to the rows and columns
k=1;
for n=1:N
    for m=1:M
        AA(m,n)=unhuff(k);
        k=k+1;
    end
end
% convert image array back into uint8 data type
AA=uint8(AA);

isOK = isequal(A512,AA); % check if before/after the same

fprintf('\n')  % skip a line
if (isOK)
    disp('The decoded image is exactly equal to the original image.')
else
    disp('Oops! the decoded image is NOT equal to the original image.')
    fprintf('The MSE is %g \n', my_mse(A512,AA))
end
fprintf('\n')  % skip a line

% show size of some key data variables
whos A512 huff unhuff  AA table

% calculate the compression ratio
wA512=whos('A512');
whuff=whos('huff');
CR=wA512.bytes/whuff.bytes;
fprintf('The compression ratio is %g \n', CR)

% display results
close all % close all figure windows

figure(1)
bar(frequency(A512)); 
axis tight
title('Raw data histogram for Lena image')
figure(2)
subplot(1,2,1)
ip_disp(A512)
xlabel('Before encoding')
subplot(1,2,2)
ip_disp(AA)
xlabel('After decoding')

figure(1)


% finished
disp('Demo finished!')
