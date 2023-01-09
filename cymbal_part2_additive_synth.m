
% Final Project Music 270A 
% Brian Tice, Fall Quarter 2022. UCSD

% Part 1, initial mallet of an Instanbul Agop 20" Crash 

% Looked at the spectrum plot and obtained the following information:
% Note, to the best of my knowledge, these frequencies are Inharmonic

% Frequecy: 367 Hz      Magnitude: 0.714
% Frequecy: 860 Hz      Magnitude: 0.386
% Frequecy: 1231 Hz      Magnitude: 0.893
% Frequecy: 1418 Hz      Magnitude: 0.576
% Frequecy: 2333 Hz      Magnitude: 0.777
% Frequecy: 2371 Hz      Magnitude: 0.698
% Frequecy: 2717 Hz      Magnitude: 0.629
% Frequecy: 2782 Hz      Magnitude: 0.697
% Frequecy: 2902 Hz      Magnitude: 0.752
% Frequecy: 2943 Hz      Magnitude: 0.460
% 



y = 0;
fs = 44100;
nT = 0:1/fs:2-1/fs; % generate a 2 second long sample

frequency = [367, 860, 1231, 1418, 2333, 2371, 2717, 2782, 2902, 2943];
amp = [0.714, 0.386, 0.893, 0.576, 0.777, 0.698, 0.629, 0.697, 0.752, 0.460];

for i = 1:10

    y = y + amp(i)*sin(2*pi*frequency(i)*nT);
end

% create pink noise
pnoise = pinknoise(length(y))';

% combine signal and pinknoise, for shimmer
y = 0.5*y + 0.6*pnoise;

            
% normalize
y = y/max(abs(y));    

plot(y);
audiowrite('cymbal_part_two.wav',y,fs);


disp('Cymbal Additive Synthesis')