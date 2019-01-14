function [padded, nAdded] = padsignal(y,plotToggle)
%PADSIGNAL An algorithm that pads a signal to decrease end effects
%   INPUTS:
%       y - A real vector that will be extended to create a close to
%           periodic signal (Required)
%       plotToggle - Plots the original signal and its extended version if
%           plotToggle is not equal to 1 (default=0)
%   OUTPUTS:
%       padded - a version of y that has been replicated at its end in
%           an attempt o make it nearly periodic 
%       nAdded - The number of points that were added to the signal.  This
%           allows for the added points to be removed later.
% Ex:
% zeta = .4; wn = 10;
% t = 0:0.001:pi/8;
% y = exp(-zeta*wn*t).*cos(2*pi*wn*sqrt(1-zeta^2)*t);
% [padded,nAdded] = padsignal(y,1);
% eHil = hilbert(padded);
% eHil = eHil(1:end-nAdded);
% figure
% plot(t,y,t,abs(hilbert(y)),t,exp(-zeta*wn*t),t,abs(eHil),'linewidth',2);
% legend('Signal','Hilbert','Exact','Padded Hilbert')
%
% Copyright Nathanael C. Yoder 2009 (ncyoder@purdue.edu)
    error(nargchk(1,2,nargin,'struct'));
    error(nargoutchk(0,2,nargout,'struct'));
    
    if nargin < 2
        plotToggle = 0;
    elseif nargout == 0
        plotToggle = 1; % Don't let the user do nothing
    end
        
    s = size(y);
    nPoints = numel(y);
    if s(2)>s(1)
        if nPoints ~= s(2)
            error('PADSIGAL:Vector','y must be a vector');
        end
        y = y(:);
        flipBack = 1;
    else
        if nPoints ~= s(1)
            error('PADSIGAL:Vector','y must be a vector');
        end
        flipBack = 0;
    end
    
    
    
    
    endSlope = y(nPoints)-y(nPoints-1);
    % Predict the next point linearly but leave a little margin
    nextPoint = y(nPoints)+endSlope;
    endInds = FastCrossing(y,nextPoint);
    if isempty(endInds)
        nAddEnd = nPoints-1;
    else
        nAddEnd = MatchSlope(y,endInds,-endSlope);
    end
    
    startSlope = y(1)-y(2);
    % Predict the 0th point linearly but leave a little margin
    zPoint = y(1)+startSlope;
    startInds = FastCrossing(y(1:nAddEnd),zPoint);
    if isempty(startInds)
        nAddStart = 2;
    else
        nAddStart = MatchSlope(y(1:nAddEnd),startInds,startSlope)+1;
    end
    
    padded = [y;y(nAddEnd:-1:nAddStart)];
    nAdded = nAddEnd-nAddStart+1;
    % Restore orientation
    if flipBack
        padded = padded.';
    end
    
    if plotToggle
        figure;plot(1:nAdded+nPoints,padded,1:nPoints,y,'linewidth',2);
        legend('Padded Signal','Original Signal')
    end
end

% Calculate when S crosses level
function ind = FastCrossing(s,level)
    s   = s - level;
    s2  = s(1:end-1) .* s(2:end);
    ind = find(s2 < 0);
end

% Attempt to match the slope
function outInd = MatchSlope(y,inds,slope)
    inds(inds == numel(y)) = [];
    slopes = y(inds+1)-y(inds);
    [slopeDiff,ind] = min(abs(slopes-slope));
    outInd = inds(ind);
end