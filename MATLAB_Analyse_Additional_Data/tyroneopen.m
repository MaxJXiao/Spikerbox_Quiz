datatyroneo = datatyrone(10000:100000);
t = linspace(1,10,length(datatyroneo));

fs = 10000;
nfft = 500000;

X = fft(datatyroneo,nfft);
X = fftshift(X);

mx = abs(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;
figure(1);
plot(t,datatyroneo);
title('Tyrone Open Eyes Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(2);
plot(f,mx);
title('Power Spectrum of Tyrone Eyes Open'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);