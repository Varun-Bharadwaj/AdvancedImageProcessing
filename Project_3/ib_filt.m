%Filter mask
function O = ib_filt(I,F)
%  I = [1 2 3 3; 4 5 6 3; 7 8 9 3; 2 3 4 5];
%  F = [1 1 1; 1 1 1; 1 1 1];
%  F = F*(1/9);
[Ix,Iy] = size(I); % Image size
[Fx,Fy] = size(F); % Filter size

zpad = (Fx - 1);
zIx = zpad + Ix;
zIy = zpad + Iy;

zI = zeros(zIx,zIy);
X = zpad/2;
zI(1+X:zIx-X,1+X:zIy-X)=I; % Zero padding the image
O = zeros(Ix,Iy); % Output matrix

for i=1:Ix 
    for j=1:Iy 
        for k=1:Fx
            for l=1:Fy
                O(i,j) = O(i,j) + (zI(i+k-1,j+l-1)*F(k,l));
            end
        end
    end
end

% figure()
% % ip_disp(I);
% imshow(I)
% % title("iptest256a");
% % print('iptest256a','-djpeg');
% % 
% figure()
% % ip_disp(abs(O));
% imshow(O)
% title("iptest256a _ filtered");
% print('iptest256a _ filtered','-djpeg');