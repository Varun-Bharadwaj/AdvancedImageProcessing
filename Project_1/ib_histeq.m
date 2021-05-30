function blank = ib_histeq(A)

I = A; 
% size of the input image.
[r,c] = size(I); 

blank = zeros(r,c);

% number of pixels.
n = r*c;

% frequency pdf and cdf and some variables
f = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
out = zeros(256,1);
cum = zeros(256,1);

% Nested for loop
for i = 1:r
    for j = 1:c
        value = I(i,j);
        f(value+1) = f(value+1)+1;
        pdf(value+1) = f(value+1)/n;
    end
end

% finding cdf
sum = 0;
L = 255;

for i = 1:size(pdf)
    sum = sum + f(i);
    cum(i) = sum;
    cdf(i) = cum(i)/n;
    out(i) = round(cdf(i)*L);
end

for i = 1:r
    for j = 1:c
        blank(i,j) = out(I(i,j)+1);
    end
end

figure
ip_disp(blank)
title('2d image after applying histogram equalization')
print('2d image after applying histogram equalization','-djpeg')