% Read wav file generated by BYB Spike recorder - live emulation

clear all
close all

file_nam = 'calibration run 2.wav';
[R,Fs] = audioread(file_nam);

T = [1:length(R)]/Fs;

nffte = length(T);
 
X = fft(R,nffte);
X = fftshift(X);

f = linspace(-nffte/2,nffte/2-1,length(X))*Fs/nffte;


X(abs(f)>15) = 0;
mx = abs(X);

R = ifft(ifftshift(X),'symmetric');


file_name = 'left right blink2.wav';
[Y,Fs] = audioread(file_name);
%Y = Y(40000:end);
T = [1:length(Y)]/Fs;   % time in seconds

nfft = length(T);
 
X = fft(Y,nfft);
X = fftshift(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*Fs/nfft;


X(abs(f)>15) = 0;
mx = abs(X);

Y = ifft(ifftshift(X),'symmetric');
 



TWindow = 0.05;    % observation interval
threshold_level = 0.3;

TMax = max(T);  % maximum time recorded
dT = T(2)-T(1); % dT
NWindow = TWindow/dT;   % number of points in Window
delay_time = TWindow;   % wait the "recording interval" time
Y = Y/max(R);
% loop and plot..
r = [];
time = [];
reset = 0;
plot(T,Y);


for k =1:round(TMax/TWindow)-1
    % simplest approach: the first window only is the noise


    
    window_index_beginning = 1+NWindow*(k-1);
    window_index_end = NWindow+NWindow*(k-1);
    window_index_range = window_index_beginning:window_index_end;
    %figure(1)
    %clf
    %subplot(3,1,1)
    %hold all
    %plot(T,Y)
    %title(['threshold =' num2str(threshold_level)])
    
     %plot the window you are looking at
    
    %plot([T(window_index_beginning),T(window_index_beginning)],[min(Y),max(Y)],'k')   
    %plot([T(window_index_end),T(window_index_end)],[min(Y),max(Y)],'k')   
    %xlabel('time [s]')
    %ylabel('signal [a.u.]')
    %box on

    
    % plot the reduced window
    
    %subplot(3,1,2)
    %plot(T(window_index_range),Y(window_index_range))
    %box on
    %xlabel('time [s]')
    %ylabel('signal [a.u.]')
    
    %identify blinks
    blinkstest = max(abs(Y(window_index_range)));
    

    % plot the average of this window, identify event
    average_signal = mean(Y(window_index_range));
    %max and min
    MaxY = max(average_signal);
    MinY = min(average_signal);
    
    %subplot(3,1,3)
    %plot(average_signal ,'o')
    %box on
    %ylim([-0.1,0.1])
    %set(gca,'XTick',[])
    %ylabel('signal [a.u.]')
    %legend('average signal in window')
    
    
    if mod(reset,25) == 0
        reset = 0;
    end
    
    if reset == 0
        if blinkstest > 1.3
            title('Blink')
            r = [r; 5];
            time = [time; TWindow*k];
            reset = 1;
        elseif average_signal>threshold_level
            title('Left!')  
            r = [r; 1];
            time = [time; TWindow*k];
            reset = 1;
        elseif average_signal<-threshold_level
            title('Right!')
            r = [r; 0];
            time = [time; TWindow*k];
            reset = 1;
        end
    else
        reset = reset + 1;        
    end  
        
        
        
end       

RT = [r, time];