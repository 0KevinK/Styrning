clear all
close all
clc

B1 = 0.410;                     % Masscentrums läge relativit vänster hjul [m]
B2 = 0.410;                     % Masscentrums läge relativit höger hjul [m]
H1 = 0.400;                     % Masscentrums läge över marknivån [m]
m  = 120;                       % Massa hos fordon ink. förare 
mu = 0.8;                       % Friktion mellan däck och vägbana [-]
g  = 9.81;                      % Tyngdaccelation [m/s^2]
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
Ntot = m*g;
%%%
% Beräkning av lastfördelning mellan fram och bakaxel för olika körfall
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


%%%
% Bestämning av masscentrums maximala höjd över marken för att undvika tippning
Bmin = min(B1,B2);              % Avgör minsta avstånd från masscentrum till hjul [m]
H1max = Bmin/mu;                % Beräknar maximalt tillåtet värde på H1

% Bestämning av maximal kurvhastighet för att undvika sladd
R = [5:20];                     % Kurvradier [m]
v  = sqrt(mu*g*R);              % Maximal hastiget för att undvika sladd [m/s]

% Bestämning av normalkrafter i olika körfall
% Vänsterkurva på gränsen till sladd
NV(1) = m*g*(B2-mu*H1)/(B1+B2); % Normalkraft på vänster sida [N]
NH(1) = m*g -NV(1);             % Normalkraft på höger sida [N]
% Körning rakt fram
NV(2) = m*g*B2/(B1+B2);         % Normalkraft på vänster sida [N]
NH(2) = m*g -NV(2);             % Normalkraft på höger sida [N]
% Högerkurva på gränsen till sladd
NV(3) = m*g*(B2+mu*H1)/(B1+B2); % Normalkraft på vänster sida [N]
NH(3) = m*g -NV(3);             % Normalkraft på höger sida [N]

NVFvk = (NF(2)/(m*g))*(NV(1)/(m*g))*Ntot;
NVFvk*mu;
NVFkonst = (NF(2)/(m*g))*(NV(2)/(m*g))*Ntot;
NVFhk = (NF(2)/(m*g))*(NV(3)/(m*g))*Ntot;
NVFhk*mu;
NVFacc = (NF(1)/(m*g))*(NV(2)/(m*g))*Ntot;
NVFbroms = (NF(3)/(m*g))*(NV(2)/(m*g))*Ntot;
%NHFvk = NF(2)*NH(1)/Ntot

