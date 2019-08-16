function [ Yr, Yi, Yc ] = freqShift( t, y, f_shift )
%FREQSHIFT shifts the spectrum of time (t) dependent signal (y) by f_shift
%   [Yr,Yi,Yc] = freqShift(t,y,f_shift) returns the frequency shifted
%   complex signal (Yc), and its real (Yr) and imgainary (Yi) components.
%
%   Uses the analytic (complex) signal of input (y) derived from the
%   Hilbert Transform to shift the spectrum by f_shift Hertz. (y) is
%   expected to be a row vector.
%
%   The spectrum of a complex signal is non-negative, and can be shifted
%   without ill effect of conventional / impractical filtering techniques,
%   then can be converted back in to the real part to yield a shifted
%   version of the desired signal.
%

%   v0.1
%   - Needs to be fully tested with FFT, various natural and spectrally
%   rich stimuli
%   - check inst freq with hilberDecomp(t,real(Xout))
%   - plot 3d complex signal plot3(t,real(Xout),imag(Xout))



%% Example

% Signal
%t = 0:.0001:.1;
%y = sin(2*pi*500*t);

% Hilbert Transform -> Analytic signal
h = hilbert(y);

% Frequency Shifter
shifter = exp(i*2*pi*f_shift*t);

Yout = h .* shifter;



% Output
Yr = real(Yout);
Yi = imag(Yout);
Yc = Yout;



%% Plot signal pre & post shift

sh1 = subplot(3,1,1);
    plot(t,y)
    title('Original Signal')
sh2 = subplot(3,1,2);
    plot(t,Yr)
    title('Shifted Real Component')
sh3 = subplot(3,1,3);
    plot(t,Yi)
    title('Shifted Imaginary Component')
    xlabel('Time (s)')
linkaxes([sh1 sh2 sh3],'xy')

    
    
   


end


