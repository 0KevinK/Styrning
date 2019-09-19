clear all
close all
clc

B1 = 0.410;                     % Masscentrums l�ge relativit v�nster hjul [m]
B2 = 0.410;                     % Masscentrums l�ge relativit h�ger hjul [m]
H1 = 0.400;                     % Masscentrums l�ge �ver markniv�n [m]
m  = 120;                       % Massa hos fordon ink. f�rare 
mu = 0.8;                       % Friktion mellan d�ck och v�gbana [-]
g  = 9.81;                      % Tyngdaccelation [m/s^2]
L1   = 0.658; % [m]
L2   = 0.600; % [m] L1 och L2 st�mde inte med mall
H1   = 0.400;
m    = 120;     % Massa inkl. f�rare [kg]
r    = 0.135;   % Hjulradie [mm]
% Data f�r drivlinan
u    = 2;       % Utv�xling [-]
eta  = 0.95;    % Verkningsgrad [-]
Mmax = 11.2;      % Maximalt motormoment enligt datablad [Nm] st�mde inte med mall
% Fysikaliska parametrar
mu  = 0.8;      % Friktionstal mellan d�ck och v�gbana [ - ]
g   = 9.81;     % Tyngdacceleration [m/s^2]
Ntot = m*g;
%%%
% Ber�kning av lastf�rdelning mellan fram och bakaxel f�r olika k�rfall
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
% Best�mning av masscentrums maximala h�jd �ver marken f�r att undvika tippning
Bmin = min(B1,B2);              % Avg�r minsta avst�nd fr�n masscentrum till hjul [m]
H1max = Bmin/mu;                % Ber�knar maximalt till�tet v�rde p� H1

% Best�mning av maximal kurvhastighet f�r att undvika sladd
R = [5:20];                     % Kurvradier [m]
v  = sqrt(mu*g*R);              % Maximal hastiget f�r att undvika sladd [m/s]

% Best�mning av normalkrafter i olika k�rfall
% V�nsterkurva p� gr�nsen till sladd
NV(1) = m*g*(B2-mu*H1)/(B1+B2); % Normalkraft p� v�nster sida [N]
NH(1) = m*g -NV(1);             % Normalkraft p� h�ger sida [N]
% K�rning rakt fram
NV(2) = m*g*B2/(B1+B2);         % Normalkraft p� v�nster sida [N]
NH(2) = m*g -NV(2);             % Normalkraft p� h�ger sida [N]
% H�gerkurva p� gr�nsen till sladd
NV(3) = m*g*(B2+mu*H1)/(B1+B2); % Normalkraft p� v�nster sida [N]
NH(3) = m*g -NV(3);             % Normalkraft p� h�ger sida [N]

NVFvk = (NF(2)/(m*g))*(NV(1)/(m*g))*Ntot;
NVFvk*mu;
NVFkonst = (NF(2)/(m*g))*(NV(2)/(m*g))*Ntot;
NVFhk = (NF(2)/(m*g))*(NV(3)/(m*g))*Ntot;
NVFhk*mu;
NVFacc = (NF(1)/(m*g))*(NV(2)/(m*g))*Ntot;
NVFbroms = (NF(3)/(m*g))*(NV(2)/(m*g))*Ntot;
%NHFvk = NF(2)*NH(1)/Ntot

