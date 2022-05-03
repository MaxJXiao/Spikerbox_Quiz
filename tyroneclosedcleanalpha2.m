datatyronec = datatyrone(110000:200000);
t = linspace(11,20,length(datatyronec));

fs = 10000;
nfft = 500000;

X = fft(datatyronec,nfft);
X = fftshift(X);
figure(69);
plot(t,datatyronec)

mx = abs(X);

%%



f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;


mx(abs(f)>15) = 0;


figure(23);
plot(t.',datatyronec);
title('Tyrone Closed Eyes Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(24);
plot(f,mx);
title('Power Spectrum of Tyrone Eyes Closed'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-20 20]);

hold on

Fs = 150; % sampling frequency
t = 1:1/Fs:10-1/Fs;  % Time vector of 1 second
f = 12; % Create a sine wave of f Hz 
x=sin(2*pi*t*f);
nfft = 1024; % Length of FFT
X = fft(x,nfft); % Take fft and pad with zeros 
X = fftshift(X);
mx = abs(X); % Take the magnitude of fft 
f = linspace(-nfft/2,nfft/2-1,length(X))*Fs/nfft; % Frequency vector

% Generate the plot, title and labels

%figure(1);
%plot(t,x);
%title('Sine Wave Signal'); 
%xlabel('Time (s)'); 
%ylabel('Amplitude'); 
figure(24);
plot(f,mx/10); 
xlim([-20 20]);

%%%%%%%%%%%%%%%%
Fs = 150; % sampling frequency
t = 1:1/Fs:10-1/Fs;  % Time vector of 1 second
f = 11; % Create a sine wave of f Hz 
x=sin(2*pi*t*f);
nfft = 1024; % Length of FFT
X = fft(x,nfft); % Take fft and pad with zeros 
X = fftshift(X);
mx = abs(X); % Take the magnitude of fft 
f = linspace(-nfft/2,nfft/2-1,length(X))*Fs/nfft; % Frequency vector

% Generate the plot, title and labels

%figure(1);
%plot(t,x);
%title('Sine Wave Signal'); 
%xlabel('Time (s)'); 
%ylabel('Amplitude'); 
figure(24);
plot(f,mx/10); 
xlim([-20 20]);
legend('Tyrone','12Hz','11Hz')

hold off


%%
X(abs(f)>15) = 0;

iFX = ifft(X);
RFX = real(iFX);

figure(25);
t=linspace(11,20,length(RFX));
plot(t,RFX);
title('Tyrone: Cleaned Alpha Waves Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 