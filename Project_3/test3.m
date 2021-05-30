load green_screen.mat
A = AFA;
Fh = [-1 -2 -1; 0 0 0; 1 2 1];
Fv = [-1 0 1; -2 0 2; -1 0 1];

figure
ip_disp(F16(:,:,3))
Rx = ib_filt(F16(:,:,1),Fh);
Ry = ib_filt(F16(:,:,1),Fv);
Gx = ib_filt(F16(:,:,2),Fh);
Gy = ib_filt(F16(:,:,2),Fv);
Bx = ib_filt(F16(:,:,3),Fh);
By = ib_filt(F16(:,:,3),Fv);

R = abs(Rx) + abs(Ry);
G = abs(Gx) + abs(Gy);
B = abs(Bx) + abs(By);

RGB(:,:,1) = (F16(:,:,1));
RGB(:,:,2) = uint8(G + double(F16(:,:,2)));
RGB(:,:,3) = (F16(:,:,3));

figure
ip_disp(R)

figure
ip_dispc(RGB)