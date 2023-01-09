% Brian Tice
% November 30th, 2022
% HW#4, Question 2

% Synthesize an instrument of your choice using waveshaping synthesis and
% spectral matching with Chebyshev Polynomial 

% The wavefile selected was Horn.ff.C3.stereo.wav from
% http://theremin.music.uiowa.edu/MIS.html

% Running the plotspec function, I obtained the following spectral
% harmonic information:

% Harmonic      Frequency           Amplitude
% ---------------------------------------------
% h0            131.6  Hz           0.366
% h1            263.6  Hz           0.877
% h2            394.9  Hz           1.000
% h3            528.3  Hz           0.976
% h4            655.9  Hz           0.674
% h5            787.4  Hz           0.419
% h6            918.0  Hz           0.276
% h7            1056.7 Hz           0.274 

h = [0.366, 0.877, 1.000, 0.976, 0.674, 0.419, 0.276, 0.274];

% Global Variables:

Hmax = 7;               % number of chebyshev polynomials to calculate
fs = 44100;             % sampling frequency

% Unit amplitude sinusoid 

dur = 1;
nT = 0:1/fs:dur-1/fs;
x = sin(2*pi*131.6*nT);      

% Chebyshev Polynomials of the first kind:

% Calculate the transfer function from -1 to 1
xs = -1:1/fs:1;

T0 = (ones(length(xs),1))';
T1 = xs;
T2 = 2*xs.^2 - 1;
T3 = 4*xs.^3 - 3*xs;
T4 = 8*xs.^4 - 8*xs.^2 + 1;
T5 = 16*xs.^5 - 20*xs.^3 + 5*xs;
T6 = 32*xs.^6 - 48*xs.^4 + 18*xs.^2 - 1;
T7 = 64*xs.^7 - 112*xs.^5 + 56*xs.^3 - 7*xs;

% Generate Spectrum Matching using observed amplitudes and Chebyshev
% Polynomials

% General form of the transfer function: 
% F(x) = h0*T0(x)+h1*T1(x)+...+hn*Tn(x)

% Calculate our transfer function
F = h(1).*T0 + h(2).*T1 + h(3).*T2 + h(4).*T3 + h(5).*T4 + ...
    h(6).*T5 + h(7).*T6 + h(8).*T7;

fs = 44100;
dur = 1;
nT = 0:1/fs:dur-1/fs;
N = length(nT);

%x = sin(2*pi*220*nT);               % input
xsc = (x + abs(min(x)));             % offset x
xsc = xsc/max(xsc)*(N-1) + 1;        % scale x

%ind = -1:1/fs:1;
%w = ind + ind.^3 + ind.^5 + ind.^8; % transfer function
%w = linspace(-1,1,N);               % thrubox test transfer function
y = lininterp(F,xsc);

plot(y);
figure();
plot(xs,F);

audiowrite('horn_chebyshev.wav',y,fs);

