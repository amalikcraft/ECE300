%Ahmad Malik
%HW #3
%9/27/21
%ECE-300

clc; clear all; close all;

%%

N1 = 10^5;
R1 = 2;
B1 = 7;
R2 = 3;
B2 = 7;

fprintf('Problem#1:\n')
Prob(R1,B1,R2,B2,N1);

N2 = 10^5;
R1 = 4;
B1 = 5;
R2 = 3;
B2 = 7;
fprintf('\n-----------------------------------------------\n\nProblem#2:\n')
Prob(R1,B1,R2,B2,N2);



function Prob(R1,B1,R2,B2,N)

%Summarizing Paramters
fprintf('Given Urn#1 with %d Redballs and %d Blueballs and \nGiven Urn#2 with %d Redballs and %d Blueballs \n\n' ,R1,B1,R2,B2);  

%%Computed Probabilities

P_R1 = R1/(R1 + B1); %Probability or Red ball in Urn 1
P_B1 = B1/(R1 + B1); %Probability or Blue ball in Urn 1

P_R2_R1 = ((R2+1)/(B2+R2+1)); %Probability of Redball in Urn 2 given Redball in Urn 1
P_R2_B1 = ((R2)/(B2+R2+1)); %Probability of Redblall in Urn 2 given Blueball in Urn 1
P_B2_R1 = ((B2)/(B2+R2+1)); %Probability of Blueball in Urn 2 given Redball in Urn 1
P_B2_B1 = ((B2+1)/(B2+R2+1)); %Probability of Blueball in Urn 2 given Blueball in Urn 1

P_R1_R2 = P_R2_R1 * P_R1; %Probability of Redball Picked from Urn1 given Redball Picked from Urn2
P_R1_B2 = P_B2_R1 * P_R1; %Probability of Redball Picked from Urn1 given BlueBall Picked from Urn2
P_B1_R2 = P_R2_B1 * P_B1; %Probability of Blueball Picked from Urn1 given Redball Picked from Urn2
P_B1_B2 = P_B2_B1 * P_B1; %Probability of Blueball Picked from Urn1 given Blueball Picked from Urn2


%MAP Decision Rules
fprintf('MAP Decision Rules\n')

if P_R1_R2 > P_B1_R2  
    fprintf('Given Red is picked from Urn2, Guess Red was picked from Urn1\n');
else
    fprintf('Given Red is picked from Urn2, Guess Blue was picked from Urn1\n');
end
if P_B1_B2 > P_R1_B2
    fprintf('Given Blue is picked from Urn2, Guess Blue was picked from Urn1\n');
else
    fprintf('Given Blue is picked from Urn2, Guess Red was picked from Urn1\n');
end

%ML Decision Rules
fprintf('ML Decision Rules\n')

if P_B2_R1 > P_B2_B1  
    fprintf('Given Blue is picked from Urn2, Guess Red was picked from Urn1\n');
else
    fprintf('Given Blue is picked from Urn2, Guess Blue was picked from Urn1\n');
end
if P_R2_R1 > P_R2_B1
    fprintf('Given Red is picked from Urn2, Guess Red was picked from Urn1\n');
else
    fprintf('Given Red is picked from Urn2, Guess Blue was picked from Urn1\n');
end


%Computing Theoretical Error for MAP

MAP_Error = 1 - (max(P_R1_B2, P_B1_B2)+ max(P_R1_R2, P_B1_R2));        
fprintf('\nTheoretical MAP Error: %f\n', MAP_Error);    

    
%Computing Theoretical Error for ML
%Not Sure how to this...
fprintf('Theoretical MAP Error: N/A\n\n');

%Estimating The Error of ML and MAP:

%2 = represents blue   ...yeah I should have used logical arrays...
%1 = represents red

urn_1 = [1,R1+B1];   %Setting Up Urn 1 array
urn_1(1:R1) = 1;
urn_1(R1+1:R1+B1)=2;

urn_2 = [1,R2+B2];   %Setting Up Urn 2 array
urn_2(1:B2) = 1;
urn_2(R2+1:R2+B2)= 2;

temp = zeros(1,length(urn_2)+1); %Setting up Temp Array for when ball is added to Urn 2
temp(1:length(urn_2)) = urn_2;

MAP_Correct = 0;
ML_Correct = 0;

for i=1:N   
    randomIndex = randi(length(urn_1), 1);  
    value1 = urn_1(randomIndex);    %pick random ball from Urn1
    
    temp(length(urn_2)+1) = value1;  %add randomly picked ball (value 1) to Urn2 (temp)
    randomIndex = randi(length(temp), 1); 
    value2 = temp(randomIndex); %randomly pick ball from Urn2
    
    if value1==2 && value2==1 %blueball picked in Urn1 and redball in Urn2
        MAP_Correct = MAP_Correct + 1;
        
    elseif value2==2 &&value1==2 %blueball picked in Urn2 and blueball picked in Urn 1
        MAP_Correct = MAP_Correct+1;
        ML_Correct = ML_Correct + 1; 
    
    elseif value1==1 && value2==1 %redball picked in Urn1 and redball in Urn2
        ML_Correct = ML_Correct + 1;
    end

end


Estimated_Correct_MAP = 1 - (MAP_Correct/N);
fprintf('Estimated Error for MAP after %d Trials: %f \n',N,Estimated_Correct_MAP);
Estimated_Correct_ML = 1 - (ML_Correct/N);
fprintf('Estimated Error for ML after %d Trials: %f  \n',N,Estimated_Correct_ML);

end
