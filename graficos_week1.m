clc; clear; close all;

% ---------------------------
% Parámetros
% ---------------------------
TOX = 9e-9;         % m
eps0 = 8.854e-12;
eps_ox = 3.9*eps0;
Cox = eps_ox/TOX;   % F/m^2

% Geometría
W = 50e-6; % m
L = 0.5e-6; % m
WoverL = W/L;

% Voltajes
Vds = 3;  % V
Vgs = linspace(0,3,200); % vector de 0 a 3 V

% Parámetros NMOS
VTOn = 0.7;
Un = 350e-4;    % movilidad en m^2/Vs
lambda_n = 0.1;

% Parámetros PMOS
VTOp = -0.8;
Up = 100e-4;    % movilidad en m^2/Vs
lambda_p = 0.2;

% ---------------------------
% Factores de conducción
% ---------------------------
Kn = 0.5*Un*Cox*WoverL*(1+lambda_n*Vds);
Kp = 0.5*Up*Cox*WoverL*(1+lambda_p*Vds);

% ---------------------------
% Corriente de drenaje
% ---------------------------
Id_n = zeros(size(Vgs));
Id_p = zeros(size(Vgs));

for k=1:length(Vgs)
    if Vgs(k) > VTOn
        Id_n(k) = Kn*(Vgs(k)-VTOn)^2;
    end
    if Vgs(k) > abs(VTOp)
        Id_p(k) = Kp*(Vgs(k)-abs(VTOp))^2;
    end
end

% Convertir a mA
Id_n = Id_n*1e3;
Id_p = Id_p*1e3;

% ---------------------------
% Graficar
% ---------------------------
figure;
plot(Vgs, Id_n,'b','LineWidth',2); hold on;
plot(Vgs, Id_p,'r','LineWidth',2);
xlabel('|V_{GS}| [V]');
ylabel('I_D [mA]');
title('Curva de Id vs |VGS| para NMOS y PMOS, W/L = 100, VDS=3V');
legend('NMOS','PMOS','Location','NorthWest');
grid on;
