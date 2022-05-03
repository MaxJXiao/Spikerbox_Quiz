% Script reads data from BackyardBrain's Arduino SpikerShield
% https://backyardbrains.com/products/heartAndBrainSpikerShieldBundle
% script produces data in "result" variable
close all
delete(instrfindall);

port_number = 4; % change this depending on what is the number in "device manager" 

%-------------------------------------------------------------------------------
% Parameters
%-------------------------------------------------------------------------------

total_time = 200; % code will stop after this amount of time in seconds [[1 s = 20000 buffer size]]

max_time = 3; % time plotted in window [s]

%-------------------------------------------------------------------------------
% Initialize import data stream
%-------------------------------------------------------------------------------

inputBufferSize = 5000;   % Bufffer Size - in the range 1000-20000
% e.g. inputBufferSize = 20000 means it waits 1 second before plotting

s = InitializePortInput(inputBufferSize,port_number);

%-------------------------------------------------------------------------------
% Record and plot data
%-------------------------------------------------------------------------------
figure('color','w');
xlabel('Time (s)')
ylabel('Input signal (arb)')
data = [];

N_loops = inputBufferSize/s.InputBufferSize*total_time;

T_acquire = s.InputBufferSize/20000;    % length of time that data is acquired for 
N_max_loops = max_time/T_acquire;       %total number of loops to cover desire time window


RTtrue = [];
reset = 0;


for i = 1:N_loops 
    % take enough data to cover the first time window
    
   

    % read and process data first
    data = fread(s)';
    data_temp = process_data(data);
    % start loops
    if i <= N_max_loops
        if i==1
            data_actual = data_temp;
        else
            data_actual = [data_temp data_actual]; % the result stream will be in data variable            
        end

    else
    % continue adding data to the time window after window is finished
    data_actual = circshift(data_actual,[0 length(data_temp)]);
    data_actual(1:length(data_temp)) = data_temp';
    
    end
    
        fs=10000;
    t = min(i,N_max_loops)*s.InputBufferSize/20000*linspace(0,1,length(data_actual));
    nfft = length(t);
 
X = fft(data_actual,nfft);
X = fftshift(X);

f = linspace(-nfft/2,nfft/2-1,length(X))*fs/nfft;


X(abs(f)>15) = 0;
mx = abs(X);


wlength= 1/20000*inputBufferSize;

Y = ifft(ifftshift(X),'symmetric')-592;
%Do one run without the -565, then find mean(Y) in command box. 
%mean(Y) is subtracted from Y in the line of code above, it just happened to be 565 in testing. 

T = linspace(0,wlength,length(Y))+wlength*(i-1);
    
    TMax = max(T);  % maximum time recorded
    TWindow = 0.05;    % observation interval
    threshold_level = 50;
    dT = T(2)-T(1); % dT
    NWindow = round(TWindow/dT);   % number of points in Window
    delay_time = TWindow;   % wait the "recording interval" time
    
    r = [];
    time = [];
    
    
    for k =1:round(wlength/TWindow)-1
    % simplest approach: the first window only is the noise


    
    window_index_beginning = 1+NWindow*(k-1);
    window_index_end = NWindow+NWindow*(k-1);
    window_index_range = window_index_beginning:window_index_end;
    
    blinkstest = max(abs(Y(window_index_range)));
    
    average_signal = mean(Y(window_index_range));
    
    if mod(reset,60) == 0
        reset = 0;
    end

    
    if reset == 0
        if blinkstest > 300
            %title('Blink')
            r = [r; 5];
            time = [time; TWindow*k+wlength*(i-1)];
            reset = 1;
        elseif average_signal>threshold_level
            %title('Left!')  
            r = [r; 1];
            time = [time; TWindow*k+wlength*(i-1)];
            reset = 1;
        elseif average_signal<-threshold_level
            %title('Right!')
            r = [r; 0];
            time = [time; TWindow*k+wlength*(i-1)];
            reset = 1;
        end
    else
        reset = reset + 1;
    end  
        
        
        
    end       
    
    RT = [r, time];
    
    RTtrue = [RTtrue; RT];
    


    %t = min(i,N_max_loops)*s.InputBufferSize/20000*linspace(0,1,length(data_actual));

    drawnow;
    plot(t,Y);
    xlabel('time (s)')
    xlim([0,max_time])
    ylim([-600,600])
end