%% LastfordelningAxlar
% Program för bestämning av lastfördelning mellan fram och bakaxel på
% gokarten under olika körfall
%
% Anders Söderberg, KTH-Maskinkonstruktion, 2019-08-13
%

%% Städar
clear all
close all
clc

%% Givna in data
% Massa och masscentrum för gokart inkl. förare
L1   = 0.658; % [m]
L2   = 0.600; % [m] L1 och L2 stämde inte med mall
H1   = 0.400;
m    = 120;     % Massa inkl. förare [kg]
r    = 0.135;   % Hjulradie [mm]
% Data för drivlinan
u    = 2;       % Utväxling [-]
eta  = 0.95;    % Verkningsgrad [-]
Mmax = 11.2;      % Maximalt motormoment enligt datablad [Nm] stämde inte med mall
% Fysikaliska parametrar
mu  = 0.8;      % Friktionstal mellan däck och vägbana [ - ]
g   = 9.81;     % Tyngdacceleration [m/s^2]

%% Beräkning av lastfördelning mellan fram och bakaxel för olika körfall
% Acceleration med maximalt motormoment
F(1) = u*eta*Mmax/r;                % Drivande kraft [N]
a(1) = F(1)/m;                      % Acceleration [m/s^2]
NF(1)= (m*g*L2 -F(1)*H1)/(L1+L2);
NB(1)= m*g -NF(1);
% Konstant hastighet
F(2) = 0;
a(2) = F(2)/m;
NF(2)= (m*g*L2 -F(2)*H1)/(L1+L2);
NB(2)= m*g -NF(2);
% Bromsning
NB(3)= m*g*L1/(L1+L2+mu*H1) ;
NF(3)= m*g -NB(3);
F(3) = -mu*NB(3);
a(3) = F(3)/m;
% Tabell med lastfördelning
Fall ={'Acceleration        ' 'Konstant hastighet  ' 'Inbromsning         '};
disp(['                    ' 'Fram   ' 'Bak'])
for i =1:3
    disp([Fall{i} num2str(round(NF(i)/(m*g)*100)) '%      ' num2str(round(NB(i)/(m*g)*100)) '% '])
end


