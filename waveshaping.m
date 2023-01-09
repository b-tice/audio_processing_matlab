% Brian Tice
% Music 270A HW 4
% 11/20/22

% Pascal's triangle for harmonics:

% DIV |   | h0  h1  h2  h3  h4  h5  h6 h7 h8 h9 h10 h11
% 0.5 |x0 | 1
% 1   |x1 | 0   1
% 2   |x2 | 2   0   1
% 4   |x3 | 0   3   0   1
% 8   |x4 | 6   0   4   0   1
% 16  |x5 | 0   10  0   5   0   1
% 32  |x6 | 20  0   15  0   6   0   1
% 64  |x7 | 0   35  0   21  0   7   0  1
% 128 |x8 | 70  0   56  0   28  0   8  0  1
% 256 |x9 | 0   126 0   84  0   36  0  9  0  1
% 512 |x10| 252 0   210 0   120 0   45 0  10 0  1
% 1024|x11| 0   462 0   330 0   165 0  55 0  11 0   1

% f(x) = x + x.^3 + x.^5 + x.^8

% Question 1a:

% h0 = (1/128)*70               = 0.5469
% h1 = 1 + (1/4)*3 + (1/16)*10  = 2.3750
% h2 = (1/128)*56               = 0.4375
% h3 = (1/4)*1 + (1/16)*5       = 0.5625
% h4 = (1/128)*28               = 0.2188
% h5 = (1/16)*1                 = 0.0625
% h6 = (1/128)*8                = 0.0625
% h7 = 0                        = 0.0000
% h8 = (1/128)*1                = 0.0078

% Question 1c. Yes, the spectra are different

% Method 1: Algebraic

fs = 44100;
dur = 1;
nT = 0:1/fs:dur-1/fs;
x = sin(2*pi*220*nT);       % input
y = x + x.^3 + x.^5 + x.^8;

N = length(y);
Nfft = 2*N;

Y = fft(y,Nfft);
faxis = fs*(0:Nfft-1)/Nfft;
figure();
plot(faxis,abs(Y)./max(abs(Y)));
set(gca,'xlim', [0 2000]);
grid on

% Method 2: Wavetable

fs = 44100;
dur = 1;
nT = 0:1/fs:dur-1/fs;
N = length(nT);

x = sin(2*pi*220*nT);               % input
xsc = (x + abs(min(x)));            % offset x
xsc = xsc/max(xsc)*(N-1) + 1;       % scale x

ind = -1:1/fs:1;
w = ind + ind.^3 + ind.^5 + ind.^8; % transfer function
%w = linspace(-1,1,N);              % thrubox test transfer function
y = lininterp(w,xsc);

Nfft = 2*N;

Y = fft(y,Nfft);
faxis = fs*(0:Nfft-1)/Nfft;
figure();
plot(faxis,abs(Y)./max(abs(Y)));
set(gca,'xlim', [0 2000]);
grid on

figure();
plot(ind,w);


