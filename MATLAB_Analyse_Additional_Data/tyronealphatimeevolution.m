%%
T = [1:length(datatyronec)]/fs; % time in seconds
figure(4);
plot(T,datatyronec)
xlabel('time [s]')
ylabel('signal [a.u.]')
%%
TWindow = 1; % recording interval
TMax = max(T); % maximum time recorded
dT = T(2)-T(1); % dT
NWindow = TWindow/dT; % number of points in Window
delay_time = TWindow; % wait the "recording interval" time
% loop and plot..
for k =1:round(TMax/TWindow)
 figure(1)
 clf
 hold all
 plot(T(1:NWindow),datatyronec(1+NWindow*(k-1):NWindow+NWindow*(k-1)))
 box on
 title('Raw Signal')
 ylim([-0.02,0.02])
 xlabel('time [s]')
 ylabel('signal [a.u.]')
 pause(delay_time)
 
 t = T(1:NWindow);
nfft = length(t);


X = fft(datatyronec(1+NWindow*(k-1):NWindow+NWindow*(k-1)),nfft);
X = fftshift(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;


X(abs(f)>15) = 0;
mx = abs(X);

 
 figure(2)
 clf
 hold all
 plot(f,mx)
 title('FFT of Signal')
 xlim([-20 20])
 xlabel('Frequency [Hz]')
 ylabel('Power Spectrum')
 box on
 
 
Y = ifft(ifftshift(X),'symmetric');

 
 figure(3)
 clf
 hold all
 plot(T(1:NWindow),Y)
 ylim([-0.02,0.02])
 title('Cleaned Signal')
 xlabel('time [s]')
 ylabel('signal [a.u.]')
 pause(delay_time)
 box on



end