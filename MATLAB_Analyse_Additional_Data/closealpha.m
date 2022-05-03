t_1c = linspace(5,15,100001);
nfft = 10000;

fs = 10000;
nfft = 100000;

data1close = data(50000:150000);

X_1c = fft(data1close,nfft);
X_1c = fftshift(X_1c);

mx_1c = abs(X_1c);

f_1c = linspace(-nfft/2,nfft/2-1,length(X_1c))*fs/nfft;
figure(1);
plot(t_1c,data1close);
title('Raw Data First Closed Eyes (Alpha)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(2);
plot(f_1c,mx_1c);
title('Power Spectrum of First Eyes Closed'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15])