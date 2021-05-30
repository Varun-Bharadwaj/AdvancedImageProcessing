fid = fopen('fanagl.dat','rt');
r = fscanf(fid,'%g',[127,100]);
fclose(fid);

D =2.5;
gmax = atan(1/sqrt(D^2-1));
dg = gmax/63;
db = 2*pi/100;

for j=1:100
    for i=1:127
        rp(i,j) = D*cos((i-64)*dg)*r(i,j);
    end
end

rp(128:256,:) = zeros(129,100);

ham = fftshift(hamming(256));

h = zeros(256,1);
for i=2:2:256
    h(i) = -(0.5)*(dg/(pi*dg*sin((i-129)*dg)))^2;
end
h(129) = 1/(8*dg^2);
H = abs(fft(h))*dg;

temp1 = fft(rp);
for i=1:100
    temp1(:,i) = temp1(:,i).*H.*ham;
end
q = ifft(temp1);

N = 256;
dx = 2/N;
x = -1:dx:1;
y=x;
f2d = zeros(N,N);
na = (-gmax:dg:gmax);
NA = length(na);
NA2 = floor(NA/2)+1;
qr = real(q(1:127,:));

for k=1:N
    for i=1:N
        for j=1:100
            beta = (j-i)*db;
            rise = x(i)*cos(beta) + y(k)*sin(beta);
            run = D + x(i)*sin(beta)-y(k)*cos(beta);
            gprime = atan(rise/run);
            if(gprime >= -gmax) && (gprime <= gmax)
                gg = (gprime/dg)+NA2;
                low = fix(gg);
                delta = gg - low;
                high = low+1;
                qi = qr(low,j)*(1-delta) + qr(high,j)*delta;
                L2 = rise^2 + run^2;
                f2d(k,i) = f2d(k,i)+qi/L2;
            end
        end
        f2d(k,i) = f2d(k,i)*db;
    end
end
f2d = flipud(f2d);

figure
x = 1:256;
plot(x,f2d(x,206));

A = ip_scalegray(f2d,8);
figure
ip_disp(A)