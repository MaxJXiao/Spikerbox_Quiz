%%

datatyronec = datatyrone(110000:200000);
t = linspace(11,20,length(datatyronec));

fs = 10000;
nfft = length(t);

X = fft(datatyronec,nfft);
X = fftshift(X);

%mx = abs(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;

figure(8);
plot(t.',datatyronec);
title('Tyrone Closed Eyes Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 

X(abs(f)<5 | abs(f)>15) = 0;
mx = abs(X);

Y = ifft(ifftshift(X),'symmetric');
t = linspace(11,20,length(Y));

figure(9);
plot(t,Y)
title('Tyrone Closed Eyes Signal Cleaned'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 