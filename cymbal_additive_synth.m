
% Final Project Music 270A 
% Brian Tice, Fall Quarter 2022. UCSD

% Part 1, initial mallet of an Instanbul Agop 20" Crash 

y = 0;
fs = 44100;
nT = 0:1/fs:2-1/fs; % generate a 2 second long sample


[frequency amp] = spectrum_magnitudes('crash_mono_p2.wav',44100,0.5);


for i = 1:length(frequency)

    y = y + amp(i)*sin(2*pi*frequency(i)*nT);
end

% create pink noise
pnoise = pinknoise(length(y))';

% combine signal and pinknoise, for shimmer
y = 0.4*y + 0.7*pnoise;

% normalize
y = y/max(abs(y));    

plot(y);
audiowrite('cymbal_part_two.wav',y,fs);


disp('Cymbal Additive Synthesis')