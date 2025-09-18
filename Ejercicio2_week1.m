clc; clear; close all;

% ---------------------------
% Parámetros dados (SPICE)
% ---------------------------
TOX = 9e-9;          % m
eps0 = 8.854e-12; 
eps_ox = 3.9*eps0; 
Cox = eps_ox/TOX;    % F/m^2

% Geometría
W = 50e-6; L = 0.5e-6; % metros
WoverL = W/L;

% NMOS
UOn = 350e-4;    % m^2/Vs
VTOn = 0.7;      % V
LAMBDAn = 0.1;   % 1/V

% PMOS
UOp = 100e-4;    % m^2/Vs
VTOp = -0.8;     
LAMBDAp = 0.2;   

% Corriente de operación
ID_target = 0.5e-3; % A

% ---------------------------
% Pregunta 10: W/L
% ---------------------------
WoverL_n = W/L;
WoverL_p = W/L;

% ---------------------------
% Pregunta 11: Cox (uF/m2)
% ---------------------------
Cox_uF = Cox*1e6;

% ---------------------------
% Pregunta 12 y 13: Transconductancia gm (mA/V)
% gm = dID/dVGS = mu*Cox*W/L*(VGS-VT) (sólo saturación, sin lambda)
% ---------------------------
VGS_n = VTOn + sqrt(2*ID_target/(UOn*Cox*WoverL_n));
VGS_p = abs(VTOp) + sqrt(2*ID_target/(UOp*Cox*WoverL_p));

gm_n = UOn*Cox*WoverL_n*(VGS_n - VTOn); % A/V
gm_p = UOp*Cox*WoverL_p*(VGS_p - abs(VTOp)); % A/V

gm_n_mA = gm_n*1e3;
gm_p_mA = gm_p*1e3;

% ---------------------------
% Pregunta 14 y 15: Resistencia de salida ro (kOhms)
% ro = 1/(lambda*ID)
% ---------------------------
ro_n = 1/(LAMBDAn*ID_target); % Ohms
ro_p = 1/(LAMBDAp*ID_target); % Ohms

ro_n_k = ro_n/1e3; 
ro_p_k = ro_p/1e3;

% ---------------------------
% Pregunta 16 y 17: Ganancia intrínseca gm*ro (A*Ohms)/V
% ---------------------------
gain_n = gm_n*ro_n;
gain_p = gm_p*ro_p;

% ---------------------------
% Mostrar resultados
% ---------------------------
fprintf('Pregunta 10: W/L NMOS = %.2f, PMOS = %.2f\n', WoverL_n, WoverL_p);
fprintf('Pregunta 11: Cox = %.2f uF/m2\n', Cox_uF);
fprintf('Pregunta 12: gm NMOS = %.2f mA/V\n', gm_n_mA);
fprintf('Pregunta 13: gm PMOS = %.2f mA/V\n', gm_p_mA);
fprintf('Pregunta 14: ro NMOS = %.2f kOhms\n', ro_n_k);
fprintf('Pregunta 15: ro PMOS = %.2f kOhms\n', ro_p_k);
fprintf('Pregunta 16: Ganancia intrínseca NMOS gm*ro = %.2f (A*Ohms)/V\n', gain_n);
fprintf('Pregunta 17: Ganancia intrínseca PMOS gm*ro = %.2f (A*Ohms)/V\n', gain_p);
