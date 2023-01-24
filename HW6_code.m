%Ahmad Malik 
%HW6
%ECE300

clc; clear;


%% Question 3f

alpha = [5/6 , 1/2, 1/3, 1/3, 1/6, 1/6];
beta = [1,2,4,5,9,10];

Pb_U = zeros(1,10000); 
snr = linspace(0,10,10000);
dbsnr = 10*log10(snr);  %snr in db

%Union Bound
for i=1:10000
    Pb_U(1,i) = sum(alpha.*qfunc(sqrt(beta*snr(1,i)))); 
end     

%Bound approx
Pb_app = (5/6)*qfunc(sqrt(snr));

%making the Probability logarithmic
dbpb = log10(Pb_U);
dbpb_app = log10(Pb_app);

%Plots
hold on;
title('Union Bound and The Approximation')
plot(dbsnr,dbpb,'color','b'); %Union Bound
plot(dbsnr,dbpb_app, 'color','r');%Bound approx
xlim([2 8]);
legend('Union Bound','Approximation');
ylabel('Error Probability');
xlabel('SNR (db)');
hold off;


%% Calculating Ratios

s1 = 10^(2/10);      %making the db linear
s2 = 10^(8/10);

pb1 = (5/6)*qfunc(sqrt(s1));
pb2 = sum(alpha.*qfunc(sqrt(beta*s1)));
db2 = 1- pb1/pb2;

fprintf('The ratio at 2db: %f\n', db2);

pb1 = (5/6)*qfunc(sqrt(s2));
pb2 = sum(alpha.*qfunc(sqrt(beta*s2)));
db8 = 1- pb1/pb2;

fprintf('The ratio at 8db: %f\n', db8);


