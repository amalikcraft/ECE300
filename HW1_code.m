%Ahmad Malik
%HW #1
%9/13/21
%ECE-300 

clc; clear;


%Question #3

f = -3:0.01:3;
A = 1;
W = 1;

%Rectangular Pulse
width = f .*(1/(2*W));
x = rectpuls(width,1);

%Raised Cosine Spectrum
X_f = (A/(2*W))*(1+cos((pi*f)/W)).*x;


figure;

plot(f,X_f);
title('Raised Cosine Spectrum X(f)');
xlim([-3,3]);
ylim([0,2]);


x_t = ifft(X_f);

figure;
plot(f,abs(x_t));
title('Inverse Fourier X(f)->x(t)');
xlim([-3,3]);
ylim([-1,2]);


%I'm pretty sure I am applying the inverse fourier incorrectly. Atleast the 
%first graph matches my expectation.



