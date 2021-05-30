image=zeros(256,256,3);
image(:,129:256,1)=255; 
image(:,129:256,2)=255; 
image(1:128,:,3)=255; 
[X,Y,Z] = size(image);
V = image;

YCBCR = rgb2ycbcr(V);

figure
ip_dispsc(YCBCR(:,:,3))