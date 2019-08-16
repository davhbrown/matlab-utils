function [output] = fftSuite(t,y,fs);
%FFTSUITE calculates & displays various frequency domain transforms
% FFTSUITE(t,y,fs) performs a Fast Fourier Transform, spectrogram, and
% instantaneous frequency decomposition (via Hilbert Transform) of input
% signal (y). Input must include time (t) and sampling frequency (fs).

% v0.1
% - include power density switch in future versions
% - compare FFT with other methods
% - add output vars

set(groot,'defaultAxesTickDir','out')
set(groot,'defaultAxesTickDirMode','manual')



%% Original Signal
h1 = figure;
    h1.Position = [96.2 101.0 888 661.6];
subplot(2,2,1);
    plot(t,y,'k')
        xlabel('Time (sec)')
        ylabel('Amplitude')
        title('Original Signal')
        ylim([ min(y)*1.5 max(y)*1.5 ])
        box off

        
        
        
        
%% FFT
nfft = length(y); %length of time domain signal, but >= 2x for Nyquist
nfft2 = 2^nextpow2(nfft); % length of signal in power of 2

F1 = fft(y,nfft2);  % results in complex, magnitude & phase...
F2 = F1(1:nfft2/2);
xfft = fs*(0:nfft2/2-1)/nfft2;

subplot(2,2,2);
    plot(xfft/1000,abs(F2)); % only absolute/real..
        xlabel('Frequency (kHz)')
        ylabel('Normalized Amplitude')
        title('FFT')
        
        box off
        


               
        
%% Spectrogram
windur = .04;                                  % window duration 40ms
w = windur/(1/fs);                             % windur in samples

subplot(2,2,3);
try
    spectrogram(y,hann(w),w/2,4096,fs,'yaxis');  % Hanning window reasonable
    % adjust 4096 (freq res) depending on sampling freq
catch
    try
        spectrogram(y,hann(w),floor(w/2),[],fs,'yaxis');
    end
end
    title('Spectrogram')
    box off

% Spectrogram output vars
%[S F T] = spectrogram(y,hann(w),w/2,4096,fs,'yaxis');
% S = freq x time matrix of amplitude
% F = frequencies
% T = time
    
    

% Params to tweak (will depend on signal, tone vs. noise vs. speech etc.):
%   1. window legnth (windur)
%   2. window type (hann, hamming, etc.)
%   3. window overlap (but 50% (w/2) seems good)
%
% see also https://stackoverflow.com/questions/5887366/matlab-spectrogram-params




%% Pwelch
%figure;
%pwelch(y,hann(w),w/2,4096,fs)



%% Instantaneous Freq. via Hilbert Decomp

[~,~,freq,dt] = hilbertDecomp(t,y,'noplot'); %close

subplot(2,2,4);
    plot(dt,freq,'color',clr2blind(4))
        ylim([-1.5*abs(min(freq)) 2*max(freq)])
        xlabel('Time (sec)')
        ylabel('Frequency (Hz)')
        title('Inst. Freq. (Analytic Signal)')
        box off




end