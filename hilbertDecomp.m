function [ env,phase,freq,dt ] = hilbertDecomp( t, y )
%HILBERTDECOMP decomposes a signal into its envelope and fine structure
%components (phase & frequency)
%
%[ENV, PHASE, FREQ, DT] = HILBERTDECOMP(t, y) returns the amplitude
%envelope, phase, and frequency of signal y with timesteps t.
%
% See also paddedhilbert, padsignal

%   Smith, Delgutte, Oxenham (2002) Chimaeric sounds reveal dichotomies in
%   auditory perception. Letters to Nature. 416:87-90.
%
%   Code author not affiliated with this research paper.





%% Example Input
%t = 0:1/44100:1.75285;
%y = data2;
%t = 0:.0001:.1;
%y = [1+cos(2*pi*100*t)].*cos(2*pi*1000*t);
%t = .035:.0001:.16;
%y = [1+cos(2*pi*50*t)] .* cos(2*pi*500*t) + cos(2*pi*489*t);


% Sinudoidal Frequency Modulation
%{
t = 0:.0001:1;
fc = 75;
fm = 5;
f_delta = 50;
y = sin((2*pi*t*fc) - (f_delta/fm)*cos(2*pi*t*fm));
%}


%%
Fs = 1 / (t(end) - t(end-1));

h = hilbert(y);





%% Decompose

% Envelope
%op1
%env1 = sqrt( (real(h).^2) + (imag(h).^2) );

%op2
hil = paddedhilbert(y);
analyticFunc = y + 1i*hil;
env = abs(analyticFunc);



% Inst. Phase
phase = rad2deg(angle(h));

    
    
% Inst. Frequency       = d/dt [phase(t)];
%1st derivative
    dt = (t(1:end-1) + t(2:end))/2;
    dphase = diff(unwrap(angle(h)));
freq = Fs/(2*pi) * dphase;



hilbertPlot(t, y, env, phase, dt, freq);



end





function [ h66, sh1, sh2, sh3, sh4 ] = hilbertPlot( t, y, env, phase, dt, freq )


h66 = figure(66); clf; set(gcf,'position',[520 99 722 699]);
sh1 = subplot(4,1,1);
    plot(t,y,'color',clr2blind(1)); hold on
    plot(t,env,'color',clr2blind(2),'LineWidth',2);
        ylim([min(y)*1.5 max(env)*1.5])
        ylabel('Amplitude [arbitrary]')
        legend('signal','envelope')
    
sh2 = subplot(4,1,2);
    plot(t,env,'color',clr2blind(2),'LineWidth',2)
        ylim([0 max(env)*1.5])
        ylabel('Envelope [units]')
        
sh3 = subplot(4,1,3);
    plot(t,phase,'color',clr2blind(3));
        ylim([-200 200])
        set(gca,'ytick',[-180 -90 0 90 180])
        ylabel('Phase (deg)')
    
sh4 = subplot(4,1,4);
    plot(dt,freq,'color',clr2blind(4));
        ylim([-1.5*abs(min(freq)) 2*max(freq)])
        xlabel('Time (s)')
        ylabel('Frequency (Hz)')

linkaxes([sh1 sh2 sh3 sh4],'x')


end