function [H,S,I] = RGB_HSI(image,X,Y)

H = zeros(X,Y);
S = zeros(X,Y);
I = zeros(X,Y);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
for i=1:X
    for j=1:Y
        a = 0.5*((R(i,j)-G(i,j))+(R(i,j)-B(i,j)));
        b = ((R(i,j)-G(i,j)).^2 + ((R(i,j)-B(i,j))*(G(i,j)-B(i,j)))).^0.5;
        if a == 0 && b == 0
            Ab = 0;
        else
            Ab = (a/b);
        end
        theta = acosd(Ab);
        if B(i,j)<=G(i,j)
            H(i,j) = theta;
        elseif B(i,j)>G(i,j)
            H(i,j) = 360 - theta;
        end 
        
        c = min(R(i,j),G(i,j));
        c = min(B(i,j),c);
        S(i,j) = 1 - 3*(c/(R(i,j)+G(i,j)+B(i,j)));
        
        I(i,j) = (R(i,j)+G(i,j)+B(i,j))/3;
    end
end