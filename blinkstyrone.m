t = linspace(0,29,291975);

figure(51);
plot(t,datablink);
title('No Large Blinks until 20s'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 


fs = 10000;
nfft = 100000;

X = fft(datablink,nfft);
X = fftshift(X);

mx = abs(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;



figure(52);
plot(f,mx);
title('Power Spectrum of Blinking'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);


FX = fix(X/20)*20;
iFX = ifft(FX);
RFX = real(iFX);

FT = abs(FX);

figure(53);
t=linspace(0,29,length(RFX));
plot(t,RFX);
title('Cleaned Data Signal (>20Hz)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(54);
plot(f,FT);
title('Power Spectrum of Blinking Cleaned'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);

