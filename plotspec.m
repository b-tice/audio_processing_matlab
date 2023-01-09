function y = plotspec(x, fs, option)
%
% plotspec: Plot the magnitude of the fft
% y = plotspec(x,fs,'option') plots the magnitude of the fft where
% y is the resulting magnitude, x is the input signal, fs is the
% sampling rate, and 'option' determines on which scale (linear or
% dB) the magnitude should be plotted


    disp(x);
    [z,fs] = audioread(x);
   
    N = length(z);
    Nfft = 2*N;
    Y = fft(z,Nfft);

    faxis = fs*[0:Nfft-1]/Nfft;
    Ymag = abs(Y);


    disp('plotspec');
    
    switch option

        case {'linear', 'Linear', 'LINEAR'}

            disp('linear');
            stem(faxis, abs(Ymag)./max(abs(Ymag))); grid;
            set(gca,'xlim', [0 10000]);



        case {'dB', 'db', 'DB'}

            disp('dB');
            plot(faxis, 20*log10(abs(Ymag)./max(abs(Ymag)))); grid; 
            set(gca, 'xlim', [0 3000]);
            set(gca, 'ylim', [-60 0]);


        case {'printmagnitude', 'PrintMagnitude', 'PRINTMAGNITUDE'}

            disp('Print Magnitude and Frequency Pairs above 0.3')

            %disp([faxis(1000) abs(Ymag(1000))./max(abs(Ymag))])
            
            for i = 1:10000

                if( abs(Ymag(i))./max(abs(Ymag)) > 0.3)

                    %disp([faxis(i) abs(Ymag(i))./max(abs(Ymag))] )
                    %format short
                    sprintf("%0.3f,%0.3f",faxis(i),abs(Ymag(i))./max(abs(Ymag)))

                end
            end



        otherwise 

            disp('invalid option, please use linear or dB');
   
end


