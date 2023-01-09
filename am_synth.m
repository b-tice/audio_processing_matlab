% HW A3, Question 1
% Brian Tice
% November 10th, 2022


function y = am_synth(f1,f2,A0,dur,type,fs)
% For Ring Modulation: 
%   f1 is modulator frequency
%   f2 is carrier frequency
%   A0 is unused
%   dur is duration in seconds
%   fs is sample frequency

% For Amplitude Modulation:
%   f1 is modulator frequency
%   f2 is carrier frequency
%   A0 is constant DC component
%   dur is duration in seconds
%   fs is sample frequency

% For Single Sideband Modulation:
%   f1 is modulator frequency
%   f2 is carrier frequency
%   A0 is unused
%   dur is duration in seconds
%   fs is sample frequency


% Function tested with the following inputs:

%   am_synth(10,440,1,1,'RM',44100); 
%   am_synth(10,440,5,1,'AM',44100);
%   am_synth(20,440,1,1,'SSB',44100);

    nT = 0:1/fs:dur-1/fs;

    switch type

        case {'RM', 'rm', 'Rm'}

            disp('Ring Modulation');

            y = cos(2*pi*f1*nT) .* cos(2*pi*f2*nT);

            audiowrite('ring_mod.wav',y,fs);


        case {'AM', 'am', 'Am'}

            disp('Amplitude Modulation');

            y = A0*cos(2*pi*f2*nT) + cos(2*pi*f1*nT) .* cos(2*pi*f2*nT);

            %normalize
            y = y/max(abs(y));    

             audiowrite('amp_mod.wav',y,fs);


        case {'SSB', 'ssb', 'Ssb'}

            disp('Single Side Band Modulation');

            %choosing a cosine function as our modulator
            x = cos(2*pi*f1*nT);

            y = x.*cos(2*pi*f2*nT) - hilbert(imag(x)).*sin(2*pi*f2*nT);

            %normalize
            y = y/max(abs(y));   

            y = real(y);

            audiowrite('hilb_ssb.wav',y,fs);

        otherwise

            disp("Please enter RM, AM or SSB for type.");


    end


end

