function C = ib_bi_int (IN, xnew, ynew)

[xog,yog] = size(IN); % Size of the input image

Ax = (xnew-1)/(xog-1);

B = zeros(xnew,yog); % Intermediate matrix

% Interpolating between rows for each column
for i=1:yog
    B(1,i) = IN(1,i); % setting the endpoint
    B(xnew,i) = IN(xog,i); % setting the endpoint
    
    for j=2:xnew-1
        Xd = (j-1)/Ax; % X' where j starts from 0
        Xd = Xd + 1; % Changing index to start from 1
        Xdf = floor(Xd);
        dx = Xd - Xdf;
        B(j,i) = IN(Xdf,i)*(1-dx) + IN(Xdf+1,i)*dx;
    end
end

Ay = (ynew-1)/(yog-1);

C = zeros(xnew,ynew); % Intermediate matrix

% Interpolating between columns for each row
for i=1:xnew
    C(i,1) = B(i,1); % setting the endpoint
    C(i,ynew) = B(i,yog); % setting the endpoint
    
    for j=2:ynew-1
        Yd = (j-1)/Ay; % Y' where j starts from 0
        Yd = Yd + 1; % Changing index to start from 1
        Ydf = floor(Yd);
        dy = Yd-Ydf;
        C(i,j) = B(i,Ydf)*(1-dy) + B(i,Ydf+1)*dy;
    end
end

C = round(C); % rounding the final value


% figure
% ip_disp(IN); % display
% title("Original Image");
% print('Original Image','-djpeg');
% 
% figure
% ip_disp(C); % display
% title("1200 x 1200 Interpolated Image");
% print('1200 x 1200 Interpolated Image','-djpeg');

% print('Disk','-djpeg');
% print('100 x 100 Interpolated Image of Disk','-djpeg');