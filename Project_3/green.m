load green_screen.mat
A = AFA;
B = double(F16./255);
f = [-1 -1 -1; -1 9 -1; -1 -1 -1]; %466x720
F4 = ones(3);
F4 = F4*(1/9);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1 = ib_filt(F16(:,:,1),F4);
f2 = ib_filt(F16(:,:,2),F4);
f3 = ib_filt(F16(:,:,3),F4);
L1 = ib_filt(f1,f);
L2 = ib_filt(f2,f);
L3 = ib_filt(f3,f);

RGB(:,:,1) = L1;
RGB(:,:,2) = L2;
RGB(:,:,3) = L3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B1 = ib_bi_int(F16(:,:,1),1312,2000);
B2 = ib_bi_int(F16(:,:,2),1312,2000);
B3 = ib_bi_int(F16(:,:,3),1312,2000);


S1 = ip_scale(uint8(B1),0.15,0.15);
S2 = ip_scale(uint8(B2),0.15,0.15);
S3 = ip_scale(uint8(B3),0.15,0.15);

T1 = ib_translate(S1,0,1701);
T2 = ib_translate(S2,0,1701);
T3 = ib_translate(S3,0,1701);
T = zeros(1312,2000,3);
T(:,:,1) = T1;
T(:,:,2) = T2;
T(:,:,3) = T3;
T(1:1312,1:1702,2) = 255;
T(196:1312,:,2) = 255;


for i=1:1312
    for j=1:2000
        if(T(i,j,2) < 250)
            A(i,j,1) = T(i,j,1);
            A(i,j,2) = T(i,j,2);
            A(i,j,3) = T(i,j,3);
        end
    end
end
figure
ip_dispc(T)

figure
ip_dispc(A)

figure
ip_dispc(RGB)