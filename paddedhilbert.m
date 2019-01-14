function [hil] = paddedhilbert(y)
%PADDEDHILBERT Calculates the analytic signal with reduced end effects
%   INPUTS:
%       y - A real vector for which the hilbert transform will be 
%           calculated (Required)
%   OUTPUTS:
%       hil - The Hilbert transform of the signal y.  Note that this is NOT
%       the analytic signal which matlab returns from their hilbert
%       function.  To obtain the analytic function simply do x = y+1i*hil.
%
% NOTE: This function requires the function padsignal which can be found on
%   the web at https://engineering.purdue.edu/~ncyoder/projects.html or on
%   FileExchange http://www.mathworks.com/matlabcentral/fileexchange/25500
%
% Ex:
% zeta = .4; wn = 10;
% t = 0:0.001:pi/8;
% y = exp(-zeta*wn*t).*cos(2*pi*wn*sqrt(1-zeta^2)*t);
% hil = paddedhilbert(y);
% analyticFunc = y+1i*hil;
% figure
% plot(t,y,t,abs(hilbert(y)),t,exp(-zeta*wn*t),t,abs(analyticFunc),'linewidth',2);
% legend('Signal','Hilbert','Exact','Padded Hilbert')
    s = size(y);
    if s(2)>s(1)
        y = y(:);
        flipBack = 1;
    else
        flipBack = 0;
    end
    [extended, nAdded] = padsignal(y);
    eHil = MyHil(extended);
    hil = eHil(1:end-nAdded); 
    if flipBack
        hil = hil.';
    end
    
    
end

function hil = MyHil(s)
    s = s(:);
    S = fft(s);
    n = numel(s);
    nyq = floor(n/2+1);
    if 2*fix(n/2) == n
        S = [0;-1i*S(2:nyq-1);0;1i*S(nyq+1:end)];
    else
        S = [0;-1i*S(2:nyq);1i*S(nyq+1:end)];
    end
        
    hil = ifft(S);
end
    
    