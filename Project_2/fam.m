%Haar
[hphnn, hpsnn, hphn, hpsn] = wfilters('haar');

len = 0:length(hphnn)-1;
figure
subplot(2,2,1)
stem(len,hphnn)
ylabel('hphi(-n)')
title('Decomposition low pass filter')
subplot(2,2,2)
stem(len,hpsnn)
ylabel('hpsi(-n)')
title('Decomposition high pass filter')
subplot(2,2,3)
stem(len,hphn)
ylabel('hphi(n)')
title('Reconstruction low pass filter')
subplot(2,2,4)
stem(len,hpsn)
ylabel('hpsi(n)')
title('Reconstruction high pass filter')
suptitle('Haar')
%print('Haar filter coefficients','-djpeg')

figure
subplot(2,2,1)
[fh0,Z] = freqz(hphnn,1,128,1);
plot(Z,abs(fh0))
xlabel('Normalized frequency')
ylabel('hphi(-n) magnitude')
subplot(2,2,2)
[fh1,Z] = freqz(hpsnn,1,128,1);
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(-n) magnitude')
subplot(2,2,3)
[fg0,Z] = freqz(hphn,1,128,1);
plot(Z,abs(fg0))
xlabel('Normalized frequency')
ylabel('hphi(n) magnitude')
subplot(2,2,4)
[fg1,Z] = freqz(hpsn,1,128,1);
plot(Z,abs(fg1))
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(n) magnitude')
suptitle('Haar')
%print('Haar frequency response','-djpeg')

figure
subplot(2,2,1)
[ph0,Z] = phasez(hphnn,1,128,1);
ph0 = ph0*180/pi;
plot(Z,ph0)
xlabel('Normalized frequency')
ylabel('hphi(-n) phase')
subplot(2,2,2)
[ph1,Z] = phasez(hpsnn,1,128,1);
ph1 = ph1*180/pi;
plot(Z,ph1)
xlabel('Normalized frequency')
ylabel('hpsi(-n) phase')
subplot(2,2,3)
[pg0,Z] = phasez(hphn,1,128,1);
pg0 = pg0*180/pi;
plot(Z,pg0)
xlabel('Normalized frequency')
ylabel('hphi(n) phase')
subplot(2,2,4)
[pg1,Z] = phasez(hpsn,1,128,1);
pg1 = pg1*180/pi;
plot(Z,pg1)
xlabel('Normalized frequency')
ylabel('hpsi(n) phase')
suptitle('Haar')
%print('Haar phase response','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%db4
[hphnn, hpsnn, hphn, hpsn] = wfilters('db4');

len = 0:length(hphnn)-1;
figure
subplot(2,2,1)
stem(len,hphnn)
ylabel('hphi(-n)')
title('Decomposition low pass filter')
subplot(2,2,2)
stem(len,hpsnn)
ylabel('hpsi(-n)')
title('Decomposition high pass filter')
subplot(2,2,3)
stem(len,hphn)
ylabel('hphi(n)')
title('Reconstruction low pass filter')
subplot(2,2,4)
stem(len,hpsn)
ylabel('hpsi(n)')
title('Reconstruction high pass filter')
suptitle('db4')
%print('db4 filter cofficients','-djpeg')

figure
subplot(2,2,1)
[fh0,Z] = freqz(hphnn,1,128,1);
plot(Z,abs(fh0))
xlabel('Normalized frequency')
ylabel('hphi(-n) magnitude')
subplot(2,2,2)
[fh1,Z] = freqz(hpsnn,1,128,1);
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(-n) magnitude')
subplot(2,2,3)
[fg0,Z] = freqz(hphn,1,128,1);
plot(Z,abs(fg0))
xlabel('Normalized frequency')
ylabel('hphi(n) magnitude')
subplot(2,2,4)
[fg1,Z] = freqz(hpsn,1,128,1);
plot(Z,abs(fg1))
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(n) magnitude')
suptitle('db4')
%print('db4 frequency response','-djpeg')

figure
subplot(2,2,1)
[ph0,Z] = phasez(hphnn,1,128,1);
ph0 = ph0*180/pi;
plot(Z,ph0)
xlabel('Normalized frequency')
ylabel('hphi(-n) phase')
subplot(2,2,2)
[ph1,Z] = phasez(hpsnn,1,128,1);
ph1 = ph1*180/pi;
plot(Z,ph1)
xlabel('Normalized frequency')
ylabel('hpsi(-n) phase')
subplot(2,2,3)
[pg0,Z] = phasez(hphn,1,128,1);
pg0 = pg0*180/pi;
plot(Z,pg0)
xlabel('Normalized frequency')
ylabel('hphi(n) phase')
subplot(2,2,4)
[pg1,Z] = phasez(hpsn,1,128,1);
pg1 = pg1*180/pi;
plot(Z,pg1)
xlabel('Normalized frequency')
ylabel('hpsi(n) phase')
suptitle('db4')
%print('db4 phase response','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sym4
[hphnn, hpsnn, hphn, hpsn] = wfilters('sym4');

len = 0:length(hphnn)-1;
figure
subplot(2,2,1)
stem(len,hphnn)
ylabel('hphi(-n)')
title('Decomposition low pass filter')
subplot(2,2,2)
stem(len,hpsnn)
ylabel('hpsi(-n)')
title('Decomposition high pass filter')
subplot(2,2,3)
stem(len,hphn)
ylabel('hphi(n)')
title('Reconstruction low pass filter')
subplot(2,2,4)
stem(len,hpsn)
ylabel('hpsi(n)')
title('Reconstruction high pass filter')
suptitle('sym4')
%print('sym4 filter coefficients','-djpeg')

figure
subplot(2,2,1)
[fh0,Z] = freqz(hphnn,1,128,1);
plot(Z,abs(fh0))
xlabel('Normalized frequency')
ylabel('hphi(-n) magnitude')
subplot(2,2,2)
[fh1,Z] = freqz(hpsnn,1,128,1);
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(-n) magnitude')
subplot(2,2,3)
[fg0,Z] = freqz(hphn,1,128,1);
plot(Z,abs(fg0))
xlabel('Normalized frequency')
ylabel('hphi(n) magnitude')
subplot(2,2,4)
[fg1,Z] = freqz(hpsn,1,128,1);
plot(Z,abs(fg1))
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(n) magnitude')
suptitle('sym4')
%print('sym4 frequency response','-djpeg')

figure
subplot(2,2,1)
[ph0,Z] = phasez(hphnn,1,128,1);
ph0 = ph0*180/pi;
plot(Z,ph0)
xlabel('Normalized frequency')
ylabel('hphi(-n) phase')
subplot(2,2,2)
[ph1,Z] = phasez(hpsnn,1,128,1);
ph1 = ph1*180/pi;
plot(Z,ph1)
xlabel('Normalized frequency')
ylabel('hpsi(-n) phase')
subplot(2,2,3)
[pg0,Z] = phasez(hphn,1,128,1);
pg0 = pg0*180/pi;
plot(Z,pg0)
xlabel('Normalized frequency')
ylabel('hphi(n) phase')
subplot(2,2,4)
[pg1,Z] = phasez(hpsn,1,128,1);
pg1 = pg1*180/pi;
plot(Z,pg1)
xlabel('Normalized frequency')
ylabel('hpsi(n) phase')
suptitle('sym4')
%print('sym4 phase response','-djpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%bior4.4
[hphnn, hpsnn, hphn, hpsn] = wfilters('bior4.4');

len = 0:length(hphnn)-1;
figure
subplot(2,2,1)
stem(len,hphnn)
ylabel('hphi(-n)')
title('Decomposition low pass filter')
subplot(2,2,2)
stem(len,hpsnn)
ylabel('hpsi(-n)')
title('Decomposition high pass filter')
subplot(2,2,3)
stem(len,hphn)
ylabel('hphi(n)')
title('Reconstruction low pass filter')
subplot(2,2,4)
stem(len,hpsn)
ylabel('hpsi(n)')
title('Reconstruction high pass filter')
suptitle('bior4.4')
%print('bior4_4 filter coefficients','-djpeg')

figure
subplot(2,2,1)
[fh0,Z] = freqz(hphnn,1,128,1);
plot(Z,abs(fh0))
xlabel('Normalized frequency')
ylabel('hphi(-n) magnitude')
subplot(2,2,2)
[fh1,Z] = freqz(hpsnn,1,128,1);
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(-n) magnitude')
subplot(2,2,3)
[fg0,Z] = freqz(hphn,1,128,1);
plot(Z,abs(fg0))
xlabel('Normalized frequency')
ylabel('hphi(n) magnitude')
subplot(2,2,4)
[fg1,Z] = freqz(hpsn,1,128,1);
plot(Z,abs(fg1))
plot(Z,abs(fh1))
xlabel('Normalized frequency')
ylabel('hpsi(n) magnitude')
suptitle('bior4.4')
%print('bior4_4 frequency response','-djpeg')

figure
subplot(2,2,1)
[ph0,Z] = phasez(hphnn,1,128,1);
ph0 = ph0*180/pi;
plot(Z,ph0)
xlabel('Normalized frequency')
ylabel('hphi(-n) phase')
subplot(2,2,2)
[ph1,Z] = phasez(hpsnn,1,128,1);
ph1 = ph1*180/pi;
plot(Z,ph1)
xlabel('Normalized frequency')
ylabel('hpsi(-n) phase')
subplot(2,2,3)
[pg0,Z] = phasez(hphn,1,128,1);
pg0 = pg0*180/pi;
plot(Z,pg0)
xlabel('Normalized frequency')
ylabel('hphi(n) phase')
subplot(2,2,4)
[pg1,Z] = phasez(hpsn,1,128,1);
pg1 = pg1*180/pi;
plot(Z,pg1)
xlabel('Normalized frequency')
ylabel('hpsi(n) phase')
suptitle('bior4.4')
%print('bior4_4 phase response','-djpeg')