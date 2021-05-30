%function fan_beam_CT()

fid = fopen('fanagl.dat','rt');
r = fscanf(fid,'%g',[127,100]);
fclose(fid);

D = 2.5; % Distance of the x-ray source from the sensor array
gamma_max = asin(1/D);
alpha = gamma_max/63;
delta_beta = 2*pi/(100);
r(128,:) = zeros(1,100);

% Converting r to r'
for i=1:100
    for j=1:128
        rd(j,i) = r(j,i) * D * cos((j-64)*alpha);
    end
end

%zrd = zeros(256,100);
zrd(1:128,:) = rd; % zero padding

fft_zrd = fft(zrd); % calcuating the fft

hm = fftshift(hamming(128)); % creating a hamming window

%creating filter
h = zeros(128,1);
for i=2:2:128
    h(i) = (-1/2)*(alpha/(pi*alpha*sin((i-65)*alpha)))^2;
end
h(65) = 1/(8*alpha^2);
ha = abs(fft(h))*alpha;

for i=1:100
    fft_zrd(:,i) = fft_zrd(:,i).*ha.*hm;
end

Q = ifft(fft_zrd); % calculating ifft
Qr = real(Q(1:128,:)); % retaining only real values and removing zero padding

res = 256; % resolution
x = -1:(2/res):1;
y = -1:(2/res):1;
F = zeros(res,res);

for i=1:res
    for j=1:res
        for k=1:100
            beta = (k-1)*delta_beta;
            rise = x(j)*cos(beta) + y(i)*sin(beta);
            run = D + x(j)*sin(beta) - y(i)*cos(beta);
            gammad = atan(rise/run);
            %Interpolating for gamma'
            if (gammad <= gamma_max) && (gammad >= -gamma_max)
                Ls = rise^2 + run^2;
                gd = (gammad/alpha)+64;
                gdf = floor(gd);
                dg = gd - gdf;
                Qd = Qr(gdf,k)*(1-dg) + Qr(gdf+1,k)*dg;
                F(i,j) = F(i,j) + Qd/Ls;
            end
        end
        F(i,j) = F(i,j)*delta_beta;
    end
end
F = flipud(F); % flipping the data upside down

figure
y = 1:256;
x = -1:(2/256):1-(2/256);
plot(x,F(206,y)) % 1-D plot for all x and y = -0.609
ylim([1 1.1]);
% xticks([-1:10:1]);
xlabel('x')
ylabel('Reconstructed Values')
% title('1-D scanline at y = -0.609')
% print('1-D scanline','-djpeg')

A = ip_scalegray(F,8);
A = round(A);
figure
ip_disp(A);

blank = ib_histeq(A); % Performing histogram equalization

% Gamma correction
P = (double(blank).^4.5);
Ps = ip_scalegray(P,8);
figure
ip_disp(Ps);
% title('2-D reconstructed image')
% print('2-D reconstructed image','-djpeg')