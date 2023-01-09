function [frequencies, magnitudes] = spectrum_magnitudes(x, fs, threshold)
%
% spectrum_magnitude: return frequency and magnitude vectors above a threshold
% 
% x is the .wav file to be analyzed
% fs is the sampling rate
% threshold is between 0 and 1, any frequency above the threshold is
% included in the return vectors

    disp(x);
    [z,fs] = audioread(x);
   
    N = length(z);
    Nfft = 2*N;
    Y = fft(z,Nfft);

    faxis = fs*[0:Nfft-1]/Nfft;
    Ymag = abs(Y);

    disp('spectrum_magnitudes');
    disp('Print Magnitude and Frequency Pairs above Threshold')
            
    index = 1;
    
    for i = 1:10000

        if( abs(Ymag(i))./max(abs(Ymag)) > threshold)
       
            frequencies(index) = faxis(i);
            magnitudes(index) = abs(Ymag(i))./max(abs(Ymag));
            index = index + 1;
        end
    end

end