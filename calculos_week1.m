clc; clear; close all;

% ---------------------------
% Parámetros dados
% ---------------------------

% NMOS
LD_n = 0.08e-6;     % m
VTOn = 0.7;         % V
UOn = 350;          % cm^2/Vs
LAMBDAn = 0.1;      % 1/V
TOX = 9e-9;         % m

% PMOS
LD_p = 0.09e-6;     % m
VTOp = -0.8;        % V
UOp = 100;          % cm^2/Vs
LAMBDAp = 0.2;      % 1/V

% Comunes
L = 0.5e-6;         % m
W = 50;             % μm
Vds = 3;            % V
Vgs = 3;            % V

% ---------------------------
% Pregunta 1 y 2: Longitud efectiva
% ---------------------------
Leff_n = (L - 2*LD_n)*1e6; % μm
Leff_p = (L - 2*LD_p)*1e6; % μm

% ---------------------------
% Pregunta 3 y 4: W/Leff
% ---------------------------
W_m = W*1e-6; % pasar ancho a metros
Leff_n_m = (L - 2*LD_n); % en metros
Leff_p_m = (L - 2*LD_p); % en metros

WoverL_n = W_m/Leff_n_m;
WoverL_p = W_m/Leff_p_m;

% ---------------------------
% Pregunta 5: Cox
% Cox = εox / TOX
% εox = εr * ε0
% ---------------------------
eps0 = 8.854e-12; 
eps_ox = 3.9*eps0;
Cox = eps_ox/TOX; % F/m^2
Cox_uF = Cox*1e6; % uF/m^2

% ---------------------------
% Pregunta 6 y 7: Factor μ*Cox*W/Leff*(1+λVds)
% ---------------------------

% Convertir movilidades a m^2/Vs
Un = UOn*1e-4; % m^2/Vs
Up = UOp*1e-4; % m^2/Vs

Kn = 0.5*Un*Cox*WoverL_n*(1+LAMBDAn*Vds); % A/V^2
Kp = 0.5*Up*Cox*WoverL_p*(1+LAMBDAp*Vds); % A/V^2

Kn_mA = Kn*1e3; % mA/V^2
Kp_mA = Kp*1e3; % mA/V^2

% ---------------------------
% Pregunta 8 y 9: Corriente de drenaje en saturación
% Id = K*(Vgs - Vto)^2
% ---------------------------
Id_n = Kn*(Vgs - VTOn)^2; % A
Id_p = Kp*(abs(Vgs) - abs(VTOp))^2; % A

Id_n_mA = Id_n*1e3; % mA
Id_p_mA = Id_p*1e3; % mA

% ---------------------------
% Mostrar resultados
% ---------------------------
fprintf('Pregunta 1: Leff NMOS = %.3f um\n', Leff_n);
fprintf('Pregunta 2: Leff PMOS = %.3f um\n', Leff_p);
fprintf('Pregunta 3: W/Leff NMOS = %.2f\n', WoverL_n);
fprintf('Pregunta 4: W/Leff PMOS = %.2f\n', WoverL_p);
fprintf('Pregunta 5: Cox = %.2f uF/m2\n', Cox_uF);
fprintf('Pregunta 6: Factor NMOS = %.2f mA/V2\n', Kn_mA);
fprintf('Pregunta 7: Factor PMOS = %.2f mA/V2\n', Kp_mA);
fprintf('Pregunta 8: Id NMOS = %.2f mA\n', Id_n_mA);
fprintf('Pregunta 9: Id PMOS = %.2f mA\n', Id_p_mA);
