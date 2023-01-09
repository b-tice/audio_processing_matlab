
% Final Project Music 270A 
% Brian Tice, Fall Quarter 2022. UCSD

% Part 1, initial mallet of an Instanbul Agop 20" Crash 

% Looked at the spectrum plot and obtained the following information:
% Note, to the best of my knowledge, these frequencies are Inharmonic

% Frequecy: 367 Hz      Magnitude: 1.00
% Frequecy: 452 Hz      Magnitude: 0.898
% Frequecy: 600 Hz      Magnitude: 0.324
% Frequecy: 856 Hz      Magnitude: 0.297
% Frequecy: 1232 Hz      Magnitude: 0.689
% Frequecy: 1296 Hz      Magnitude: 0.495
% Frequecy: 1418 Hz      Magnitude: 0.620
% Frequecy: 1698 Hz      Magnitude: 0.467
% Frequecy: 1752 Hz      Magnitude: 0.971
% Frequecy: 2372 Hz      Magnitude: 0.718
% Frequecy: 2717 Hz      Magnitude: 0.568
% Frequecy: 2819 Hz      Magnitude: 0.658



y = 0;
fs = 44100;
nT = 0:1/fs:2-1/fs; % generate a 2 second long sample


[frequency amp] = spectrum_magnitudes('crash_mono_p2.wav',44100,0.5);




%frequency = [367, 452, 600, 856, 1232, 1296, 1418, 1698, 1752, 2372, 2717, 2819];
%amp = [1.0, 0.898, 0.324, 0.297, 0.689, 0.495, 0.620, 0.467, 0.971, 0.718, 0.568, 0.658];

for i = 1:12

    y = y + amp(i)*sin(2*pi*frequency(i)*nT);
end

% create pink noise
pnoise = pinknoise(length(y))';

% combine signal and pinknoise, for shimmer
y = 0.5*y + 0.7*pnoise;

% normalize
y = y/max(abs(y));    

plot(y);
audiowrite('cymbal_part_two.wav',y,fs);


disp('Cymbal Additive Synthesis')