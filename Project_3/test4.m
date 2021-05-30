load green_screen.mat
A = AFA;
F = [-1 -1 -1; -1 9 -1; -1 -1 -1];
F4 = ones(3);
F4 = F4 * (1/9);
f1 = ib_filt(F16(:,:,1),F4);
f2 = ib_filt(F16(:,:,2),F4);
f3 = ib_filt(F16(:,:,3),F4);
L1 = ib_filt(f1,F);
L2 = ib_filt(f2,F);
L3 = ib_filt(f3,F);

RGB(:,:,1) = L1;
RGB(:,:,2) = L2;
RGB(:,:,3) = L3;

figure
ip_dispc(RGB)