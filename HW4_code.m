%Ahmad Malik
%HW #4
%8/7/21
%ECE-300

clc; clear all; close all;

%%
%a)
fs = 100;
x = 1/fs;
t = 0:x:20;  %time vector

%b)
N = 4096;
k = -N/2:(N/2)-1;
f = k * fs/N;        %frequency vector


%c)   
M_f = pi * exp(-1j*40*pi*f).*exp(-2*pi*abs(f));  %Spectrum    
M_fdB = 20*log10(abs(M_f));

figure;
plot(f, M_fdB);
xlim([-1, 1]);
title('|M(f)|');
xlabel('|f|<=1');
ylabel('|M(f)| (db)');

%d)

%Time Domain
fc = 10;
m_t = 1./(1+(t-10).^2);
AM90 = (1+ 0.9*(m_t)).*cos(2*pi*fc*t);  %AM Signal 90% Modulation
AM10 = (1+ 0.1*(m_t)).*cos(2*pi*fc*t);  %AM Signal 10% Modulation
E_AM90 = ((1+0.9*(m_t)).^2).^.5;        %Envelope 90% Modulation
E_AM10 = ((1+0.1*(m_t)).^2).^.5;        %Envelope 10% Modulation

figure;
subplot(2, 1, 1);
plot(t, AM90,'r-', t, E_AM90,'k-',t, -E_AM90,'k-');
title('AM Signal: 90% Modulation')
xlabel('time(s)');
ylabel('m(t)');
subplot(2, 1, 2)
plot(t, AM10,'r-', t, E_AM10,'k-',t, -E_AM10,'k-');
title('AM Signal:10% Modulation');
xlabel('time(s)');
ylabel('m(t)');

%Frequency Domain

Xf_AM90 = 20*log10(abs(fftshift((fft(AM90, N)))));
Xf_AM10 = 20*log10(abs(fftshift((fft(AM10, N)))));

figure;
subplot(2, 2, 1);
plot(f, Xf_AM90);
title('AM Signal: 90% Modulation');
xlabel('Frequency (hz)');
ylabel('|M(f)| (dB)');
xlim([0, 50]);

subplot(2, 2, 2);
plot(f, Xf_AM10);
title('AM Signal: 10% Modulation');
xlabel('Frequency (hz)');
ylabel('|M(f)| (dB)');
xlim([0, 50]);

subplot(2, 2, 3);
plot(f, Xf_AM90);
title('ZOOMED: 90% Modulation');
xlabel('Frequency (hz)');
ylabel('|M(f)| (dB)');
xlim([8, 12]);

subplot(2, 2, 4);
plot(f, Xf_AM10);
title('ZOOMED: 10% Modulation');
xlabel('Frequency (hz)');
ylabel('|M(f)| (dB)');
xlim([8, 12]);

%e)
mh_t = (t - 10)./(1 + (t - 10).^2); %hilbert transform of m(t)

%Signals
DSB_SC = m_t.*cos(2*pi*fc*t);
USSB = m_t.*cos(2*pi*fc*t)- mh_t.*sin(2*pi*fc*t);
LSSB = m_t.*cos(2*pi*fc*t)+ mh_t.*sin(2*pi*fc*t);
%Envelopes
E_DSB_SC = ((m_t).^2).^.5;
E_USSB = (((m_t).^2)+ ((mh_t).^2)).^.5;
E_LSSB = (((m_t).^2)+ ((-mh_t).^2)).^.5;

figure;
subplot(3, 1, 1);
plot(t, DSB_SC,'-r', t, E_DSB_SC,'-k', t, -E_DSB_SC, '-k');
title('DSB-SC');
xlabel('time (s)');

subplot(3, 1, 2);
plot(t, USSB,'-r', t, E_USSB,'-k', t, -E_USSB, '-k');
title('USSB');
xlabel('time (s)');

subplot(3, 1, 3);
plot(t, LSSB,'-r', t, E_LSSB,'-k', t, -E_LSSB, '-k');
title('LSSB');
xlabel('time (s)');


%f)
%E_USSB = E_LSSB = sqrt(m(t))

%g)

Xf_DSB_SC = 20*log10(abs(fftshift((fft(DSB_SC, N)))));
Xf_USSB = 20*log10(abs(fftshift((fft(USSB, N)))));
Xf_LSSB = 20*log10(abs(fftshift((fft(LSSB, N)))));

figure;
subplot(3, 2, 1);
plot(f, Xf_DSB_SC);
title('DSB-SC Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');

subplot(3, 2, 2);
plot(f, Xf_DSB_SC);
title('Subrange: DSB-SC Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');
xlim([8, 12]);

subplot(3, 2, 3);
plot(f, Xf_USSB);
title('USSB Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');

subplot(3, 2, 4);
plot(f, Xf_USSB);
title('Subrange: USSB Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');
xlim([8, 12])

subplot(3, 2, 5);
plot(f, Xf_LSSB);
title('LSSB Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');

subplot(3, 2, 6);
plot(f, Xf_LSSB);
title('Subrange: LSSB Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');
xlim([8, 12]);

%h)

kf = 0.5;
A = 1;
xfm = A* cos(2*pi*fc*t + 2*pi*kf*((pi/2)+atan(t-10)));

figure;
subplot(2, 1, 1);
plot(t, xfm);
title('FM Signal');
xlabel('time (s)');
ylabel('X(t)');

subplot(2, 1, 2);
plot(t, xfm);
title('FM Signal: Subset');
xlabel('time (s)');
ylabel('X(t)');
xlim([10, 12]);

%i)

Xf_FM = 20*log10(abs(fftshift((fft(xfm, N)))));

figure;
subplot(2, 1, 1);
plot(f, Xf_FM);
title('FM Signal Spectra');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');

subplot(2, 1, 2);
plot(f, Xf_FM);
title('FM Signal Spectra: Zoomed');
xlabel('Frequency (hz)');
ylabel('Magnitude (dB)');
xlim([8, 12]);

%j)

norm_Xf_DSB = 1/max(((abs(fftshift((fft(DSB_SC, N)))))))*(abs(fftshift((fft(DSB_SC, N))))); 
norm_Xf_FM = 1/max(abs(fftshift((fft(xfm, N)))))*(abs(fftshift((fft(xfm, N)))));

figure
plot(f, norm_Xf_DSB,f, norm_Xf_FM );
legend('DSB-SC', 'FM');
title('DSB-SC and FM Linearly Scaled');
xlabel('Frequency (hz)');
ylabel('Normalized Magnitude');
xlim([8, 12]);






