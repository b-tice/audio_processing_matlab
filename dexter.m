
% Assigment #3, Question 2
% Dexter Morrill
% Brian Tice
% November 10th, 2022

function y = dexter(freq,dur,fs)


    fc1 = freq;         % carrier frequency 1
    fc2 = freq;         % carrier frequency 2
    fm =  freq;         % modulation frequency

    N = fs*dur;         % number of total samples
    nT = [0:N-1]'/fs;   

    % angular frequencies 
    wm = 2*pi*fm;
    wc1 = 2*pi*fc1;
    wc2 = 2*pi*fc2;

    % Index of modulation hard coded to 5
    d = 5 * wm;
    I = d/wm;


    % adsr envelope calculations for index of modulation

    A = linspace(0, 0.9, (length(nT*dur)*0.35));
    D = linspace(0.9, 0.7, (length(nT*dur)*0.05));
    S = linspace(0.7, 0.7, (length(nT*dur)*0.40));
    R = linspace (0.7, 0, (length(nT*dur)*0.20));

    env = [A D S R];

    % correct for off by one array mismatch
    env(end+1) = 0;
    

    theta1 = wc1*nT + (I*env)'.*sin(wm*nT);
    theta2 = wc2*nT + (I*env)'.*sin(wm*nT);

    x1 = cos(theta1);

    % hardcoded 0.2 amplitude scalaing from diagram
    x2 = 0.2*cos(theta2);

    % adsr envelopes for both carriers
    
    A1 = linspace(0, 0.9, (length(x1)*0.35));
    D1 = linspace(0.9, 0.7, (length(x1)*0.05));
    S1 = linspace(0.7, 0.7, (length(x1)*0.40));
    R1 = linspace (0.7, 0, (length(x1)*0.20));

    A2 = linspace(0, 0.9, (length(x1)*0.45));
    D2 = linspace(0.9, 0.7, (length(x1)*0.05));
    S2 = linspace(0.7, 0.7, (length(x1)*0.30));
    R2 = linspace (0.7, 0, (length(x1)*0.20));


    env1 = [A1 D1 S1 R1];
    env2 = [A2 D2 S2 R2];
    
    
    % correct for off by one array mismatch
    x1(end) = [];
    x2(end) = [];
    env2(end) = [];

    % debug outputs
    %disp(length(x1));
    %disp(length(x2));
    %disp(length(env1));
    %disp(length(env2));

    y = x1'.*env1 + x2'.*env2;

    % normalize between -1 and 1
    y = y/max(abs(y));

    % debug plots to check ADSR envelopes
    %plot(env);
    %plot(env1);
    %plot(env2);

    % correct for off by one array mismatch
    y(end) = [];
    
    audiowrite('dextermorrill.wav',y,fs);
    

end
