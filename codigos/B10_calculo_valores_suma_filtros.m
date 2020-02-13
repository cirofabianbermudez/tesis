%% Clear subroutine
clear all;
close all;
clc;
%% 
paso = 0.05;
alpha = (0.1:paso:0.95)';           % Orden del integrador
kf = 2*pi*1000;                     % Factor de escalamiento
A = (1 - alpha)./(1 + alpha);
G1 = 1./A;                          % Ganancia de alta frecuencia
G2 = A;                             % Ganancia de baja frecuencia
f0 = (A*kf)./(2*pi*1000);           % Frecuencia de polo en kHz
T = table(alpha,G1,G2,f0);
disp(T);

%% Latex table
T_latex.data = table(alpha,G1,G2,f0);
T_latex.dataFormat = {'%1.2f',1,'%.6f',3};
% disp(T_latex.data);
latex = latexTable(T_latex);