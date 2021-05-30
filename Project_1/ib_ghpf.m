function H = ib_ghpf(A,R)
% function ib_ghpf(A,R)
A = double(A);
[M,N] = size(A); % Storing dimension of the image
P = 2*M; Q = 2*N; % Filter size calculation
Do = 2*R;

% Multiplying the image f(x,y) by (-1)^(x+y)
for i=1:M
    for j=1:N
        A(i,j) = A(i,j)*(-1)^(i+j);
    end
end

Az = zeros(P,Q);
Az(1:M,1:N) = A; % Zero padding

H = zeros(P,Q);
D = zeros(P,Q);

Azf = fft2(Az); % Calculating 2D fft

% Calculating the filter function
for i=0:P-1
    for j=0:Q-1
        D(i+1,j+1) = sqrt((i-(M-1))^2 + (j-(N-1))^2);
        H(i+1,j+1) = 1 - exp(-0.5*(D(i+1,j+1)/Do)^2);
    end
end

Azh = Azf.*H;       
Aif = ifft2(Azh); % Calculating 2D ifft
Aif = real(Aif); % Obtaining the real part
Arif = Aif(1:M,1:N); % Removing the zero pad

% Multiplying the obtained image by (-1)^(x+y)
for i=1:M
    for j=1:N
        Arif(i,j) = Arif(i,j)*(-1)^(i+j);
    end
end


% figure
% ip_dispsc(log10(abs(Azf)+1))
% title('Spectrum of the test image')
% print('Spectrum of the test image','-djpeg')

% figure
% mesh(H)
% grid on
% xlabel('u')
% ylabel('v')
% zlabel('H(u,v)')
% title('Perspective plot of GHPF transfer function for R=5')
% print('Perspective plot of GHPF transfer function for R=5','-djpeg')
% 
% figure
% ip_dispsc(H)
% title('GHPF displayed as an image with R=5')
% print('GHPF displayed as an image with R=5','-djpeg')
% 
% figure
% ip_disp(Arif)
% title('GHPF filtered output for R=5')
% print('GHPF filtered output for R=5','-djpeg')