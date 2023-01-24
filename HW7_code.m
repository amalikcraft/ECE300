%Ahmad Malik
%ECE300
%11/8/21

clc; clear; close all;

%% Question 1
fprintf('Question 1\n');
%a)  Rs = bitrate/log2(M) = 6Mbps/log2(8) = 2Mbps;
fprintf('a)Symbol Rate = 2Mbps\n');
%b) Sampling rate = Rs * 16 = 32Mbps;
fprintf('b)Sampling Rate = 32Mbps\n');
%c) W = (Rs/2)(Beta+1) =  (1Mbps/2)(0.2+1)= 1.2 Mhz
fprintf('c)Bandwidth = 1.2Mhz\n\n');

%%Question 2
%a)
fprintf('Question 2\n');
Rs = 1e6;
beta = 0.3;
L = 16;
span = 4;

p = rcosdesign(beta,span,L,'sqrt'); %coefficient vector of the FIR filter
N = length(p);
n = 0:(N - 1); 

figure;
stem(n, p);
title("Coefficient Vector of FIR Filter");
xlabel("n");
ylabel("magnitude");

n_peak = max(p);            %finding index of peak
kp_peak = find(p==n_peak);
fprintf('Index of Kp_Peak: %d\n',kp_peak);


%b) 
flip_p = fliplr(p);  %time reversal
g = conv(p,flip_p); 
N = length(g); 
n = 0:(N - 1);

figure;
stem(n, g);
title("Output Pulse for FIR Approximation");
xlabel("n");
n_peak = max(g);            %finding index of peak
kg_peak = find(g==n_peak);
fprintf('Index of Kg_Peak: %d\n\n',kg_peak);

ISI = [g(kg_peak - 4*L),g(kg_peak + 4*L), ...
       g(kg_peak - 3*L),g(kg_peak + 3*L), ...
       g(kg_peak - 2*L),g(kg_peak + 2*L), ...
       g(kg_peak - 1*L),g(kg_peak + 1*L)]; 
   
%Computing magnitude of all interferences
fprintf('Magnitude of Kg_Peak: %f\n',abs(g(kg_peak)));
fprintf('Magnitude of Kg_Peak + L: %f\n',abs(ISI(8)));
fprintf('Magnitude of Kg_Peak - L: %f\n',abs(ISI(7)));
fprintf('Magnitude of Kg_Peak + 2L: %f\n',abs(ISI(6)));
fprintf('Magnitude of Kg_Peak - 2L: %f\n',abs(ISI(5)));
fprintf('Magnitude of Kg_Peak + 3L: %f\n',abs(ISI(4)));
fprintf('Magnitude of Kg_Peak - 3L: %f\n',abs(ISI(3)));
fprintf('Magnitude of Kg_Peak + 4L: %f\n',abs(ISI(2)));
fprintf('Magnitude of Kg_Peak - 4L: %f\n\n',abs(ISI(1)));      

%SIR
I = sum(abs(ISI));
SIR = 10*log10(1/(I^2));
fprintf('SIR (db): %f\n',SIR);


%c)

%magnitude Specra of p[n]

Fs = L*Rs; 
f = linspace(0, Rs, 1000);
[P, w] = freqz(p, 1, f, Fs);

figure;
plot(f, abs(P));
title("Magnitude Specra of p[n]");
xlabel("Sample Frequency (Hz)");
ylabel("magnitude");

%magnitude Specra of g[n] Linear Magnitude

[G, w] = freqz(g, 1, f, Fs);
magG = abs(G);
flip_G = fliplr(G);
flip_magG = abs(flip_G);

%Linear
figure;
hold on;
plot(w, magG,'g-');
plot(w, flip_magG,'k-');
plot(w, magG + flip_magG,'r-');
title("Magnitude Specra of g[n]: Linear ");
xlabel("Sample Frequency (Hz)");
ylabel("magnitude");
ylim([0,25]);
legend("|G(f)|", "|G(Rs-f)|", "|G(f)|+|G(Rs-f)|");
hold off;

%Magnitude

figure;
hold on;
plot(w, 20*log10(magG),'g-');
plot(w, 20*log10(flip_magG),'k-');
plot(w, 20*log10(magG + flip_magG),'r-');
title("Magnitude Specra of g[n]: Decibels ");
xlabel("Sample Frequency (Hz)");
ylabel("magnitude (db)");
ylim([0,25]);
legend("|G(f)|", "|G(Rs-f)|", "|G(f)|+|G(Rs-f)|");
ylim([5,35]);
hold off;

