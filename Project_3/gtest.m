load green_screen.mat
A = AFA;
B = double(F16./255);
% Smoothing filter
F4 = ones(3);
F4 = F4*(1/9);

% Interpolating the green screen image to have same dimension as background
B1 = ib_bi_int(F16(:,:,1),1312,2000);
B2 = ib_bi_int(F16(:,:,2),1312,2000);
B3 = ib_bi_int(F16(:,:,3),1312,2000);
% Scaling the green screen image
S1 = ip_scale(uint8(B1),0.15,0.15);
S2 = ip_scale(uint8(B2),0.15,0.15);
S3 = ip_scale(uint8(B3),0.15,0.15);
% Translating the green screen image to approriate position
T1 = ib_translate(S1,0,1701);
T2 = ib_translate(S2,0,1701);
T3 = ib_translate(S3,0,1701);
T = zeros(1312,2000,3);
T(:,:,1) = T1;
T(:,:,2) = T2;
T(:,:,3) = T3;
T(1:1312,1:1702,2) = 255;
T(196:1312,:,2) = 255;

% Performing sphere splicing
c = [10, 250, 10]; % RGB components
r = 45; % Radius 
distance = zeros(1312,2000);
for i=1:1312
    for j=1:2000
        distance(i,j) =  (T(i,j,1) - c(1)).^2 + (T(i,j,2) - c(2)).^2 + (T(i,j,3) - c(3)).^2;
        if distance(i,j) > r^2 % not green
            A(i,j,1) = T(i,j,1);
            A(i,j,2) = T(i,j,2);
            A(i,j,3) = T(i,j,3);
        end
    end
end

% Applying smoothing filter
f1 = ib_filt(A(:,:,1),F4);
f2 = ib_filt(A(:,:,2),F4);
f3 = ib_filt(A(:,:,3),F4);

RGB(:,:,1) = f1;
RGB(:,:,2) = f2;
RGB(:,:,3) = f3;

figure
ip_dispc(T)
title('Composite green screen image')
print('Composite green screen image','-djpeg')

figure
ip_dispc(RGB)
title('Final edited image')
print('Final edited image','-djpeg')