function [R,G,B] = HSI_RGB(A,X,Y)
R = zeros(X,Y);
G = zeros(X,Y);
B = zeros(X,Y);
H = A(:,:,1);
S = A(:,:,2);
I = A(:,:,3);

for i=1:X
    for j=1:Y
        if (0<=H(i,j))&&(H(i,j)<120)
            R(i,j) = I(i,j)*(1+(S(i,j)*cosd(H(i,j))/cosd(60-H(i,j))));
            B(i,j) = I(i,j)*(1 - S(i,j));
            G(i,j) = 3*I(i,j) - (R(i,j) + B(i,j));
            
        elseif (120<=H(i,j))&&(H(i,j)<240)
            H(i,j) = H(i,j) -120;
            R(i,j) = I(i,j)*(1 - S(i,j));
            G(i,j) = I(i,j)*(1+(S(i,j)*cosd(H(i,j))/cosd(60-H(i,j))));
            B(i,j) = 3*I(i,j) - (R(i,j) + G(i,j));
            
        elseif (240<=H(i,j))&&(H(i,j)<360)
            H(i,j) = H(i,j) - 240;
            G(i,j) = I(i,j)*(1 - S(i,j));
            B(i,j) = I(i,j)*(1+(S(i,j)*cosd(H(i,j))/cosd(60-H(i,j))));
            R(i,j) = 3*I(i,j) - (G(i,j) + B(i,j));
        end
    end
end
