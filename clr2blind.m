function [ rgb ] = clr2blind( row )
%CLR2BLIND outputs colors discernable by a color blind person.
%   Up to 8 colors more or less distinguishable by those with protonopia or
%   deuteranopia in the following order: Black, Orange, Sky blue, Bluish
%   green, Yellow, Blue, Vermillion, Reddish purple.
%
%   CLR2BLIND(index) outputs RGB color values. Best used in order.
%   Best to avoid combinations of ONLY the following indices:
%                   (2,5)
%                   (2,7)
%                   (3,8)
%                   (1,4,8)
%                   (3,6)
%
%
%Reference:
%   Wong B (2011) Points of view: Color blindness. Nature Methods 8:441.

% DB 12/21/2015
% Modified by DB 11/17/2017 -- UPGRADED TO MATLAB R2015b -- no changes

                    %RGB (0-255)            CMYK (%)

%black            [ 0 0 0 ]                 0, 0, 0, 100
%orange           [ 230 159 0 ]             0, 50, 100, 0
%sky blue         [ 86 180 233 ]            80, 0, 0, 0
%bluish green     [ 0 158 115 ]             97, 0, 75, 0
%yellow           [ 240 228 66 ]            10, 5, 90, 0
%blue             [ 0 114 178 ]             100, 50, 0, 0
%vermillion       [ 213 94 0 ]              0, 80, 100, 0
%reddish purple   [ 204 121 167 ]           10, 70, 0, 0

% avoid combinations of only (2,5) (2,7) (3,8) (1,4,8) (3,6)

rgb = [
    0 0 0;
    230 159 0;
    86 180 233;
    0 158 115;
    240 228 66;
    0 114 178;
    213 94 0;
    204 121 167
    ]./255;

%{
cmyk = [
    0 0 0 1;
    0 .5 1 0;
    .8 0 0 0;
    .97 0 .75 0;
    .1 .5 .9 0;
    1 .5 0 0;
    0 .8 1 0;
    .1 .7 0 0
    ]*255;
%}    


rgb = rgb(row,:);
%cmyk = cmyk(row,:);




end