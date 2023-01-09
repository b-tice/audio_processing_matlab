
% Assignment 2, part c

% this was an aha! moment for me. It actually sounds like a clarinet
% using only math!

% looked at the spectrum plot and obtained the following information:

% fundamental frequency: 146 Hz, Magnitude 1.0
% 2nd harmonic: 292 Hz,  0.04 Magnitude
% 3rd harmonic: 439 Hz,  0.46 Magnitude
% 4th harmonic: 585 Hz,  0.09 Magnitude
% 5th harmonic: 731 Hz,  0.37 Magnitude
% 6th harmonic: 877 Hz,  0.14 Magnitude
% 7th harmonic: 1023 Hz, 0.16 Magnitude
% 8th harmonic: 1169 Hz, 0.31 Magnitude 
% 9th harmonic: 1315 Hz, 0.12 Magnitude
% 10th harmonic: 1462 Hz, 0.12 Magnitude
% 11th harmonic: 1608 Hz, 0.12 Magnitude
% 12th harmonic: 1754 Hz, 0.05 Magnitude


y = 0;
fs = 44100;
nT = 0:1/fs:2-1/fs; % generate a 2 second long sample

harmonic = [146, 292, 439, 585, 731, 877, 1023, 1169, 1315, 1462, 1608, 1754];
amp = [1.0, 0.04, 0.46, 0.09, 0.37, 0.14, 0.16, 0.31, 0.12, 0.12, 0.12, 0.05];

for i = 1:12

    y = y + amp(i)*sin(2*pi*harmonic(i)*nT);
end

            
% normalize
y = y/max(abs(y));    

plot(y);
audiowrite('clar.wav',y,fs);


disp('Clarinet Additive Synthesis')