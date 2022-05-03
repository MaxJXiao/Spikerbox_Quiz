datahardb = datablink(200000:291975);
t = linspace(20,29,length(datahardb));


figure(61);
plot(t,datahardb);
title('Raw Signal Hard Blinks'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 


fs = 10000;
nfft = 100000;

X = fft(datahardb,nfft);
X = fftshift(X);

mx = abs(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;


%%
figure(62);
plot(f,mx);
title('Power Spectrum of Hard Blinking'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-20 20]);

%%
%a(abs(reqs)> 1 & abs(reqs)<5) = 0

mx(abs(f)>15) = 0;

figure(101);
plot(f,mx);
title('Power Spectrum of Hard Blinking Clean'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-20 20]);

X(abs(f)>15) = 0;

iFX = ifft(X);
RFX = real(iFX);

figure(102);
t=linspace(20,29,length(RFX));
plot(t,RFX);
title('Cleaned Data Hard Blink Signal'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 


%%

%wing = 0.7*length(X)/2;
%newX = X(1:wing);

bigF = [f' X];

newF = zeros(1,100000);
for i=1:100000
    if abs(bigF(i,1)) >= 15
        newF(i) == 0;
    else
        newF(i) == bigF(i,2);   
    end
end

powF = abs(newF);
    
figure(93);
plot(f,powF);
title('Power Spectrum of with Low Pass Filter Hard Blinking'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);







FX = fix(X/20)*20;
iFX = ifft(FX);
RFX = real(iFX);

FT = abs(FX);

figure(81);
t=linspace(20,29,length(RFX));
plot(t,RFX);
title('Cleaned Data Hard Blink Signal (>20Hz)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(82);
plot(f,FT);
title('Power Spectrum of Hard Blinking Cleaned'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);



datasoftb = datablink(1:199999);
t = linspace(0,20,length(datasoftb));

figure(63);
plot(t,datasoftb);
title('Raw Signal Soft Blinks'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 


fs = 10000;
nfft = 100000;

X = fft(datasoftb,nfft);
X = fftshift(X);

mx = abs(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;



figure(64);
plot(f,mx);
title('Power Spectrum of Soft Blinking'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);

FX = fix(X/20)*20;
iFX = ifft(FX);
RFX = real(iFX);

FT = abs(FX);

figure(83);
t=linspace(0,19,length(RFX));
plot(t,RFX);
title('Cleaned Data Soft Blink Signal (>20Hz)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
figure(84);
plot(f,FT);
title('Power Spectrum of Soft Blinking Cleaned'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
xlim([-15 15]);