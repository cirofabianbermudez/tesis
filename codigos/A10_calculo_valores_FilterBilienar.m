%% Clear subroutine
clear all;
close all;
clc;
%% 
paso = 0.05;
alpha = (0.1:paso:0.95)';           % Orden del integrador
kf = 1250;                     % Factor de escalamiento
A = (1 - alpha)./(1 + alpha);
Gh = A;                             % Ganancia de alta frecuencia
Gl = 1./A;                          % Ganancia de baja frecuencia
fp = (A*kf)./(2*pi*1000);           % Frecuencia de polo en kHz
fz = (kf)./(A*2*pi*1000);           % Frecuencia de zero en kHz
T = table(alpha,fp,fz,Gl,Gh);
disp(T);

%% Latex table
T_latex.data = table(alpha,fp,fz,Gl,Gh);
T_latex.dataFormat = {'%1.2f',1,'%.6f',4};
% disp(T_latex.data);
latex = latexTable(T_latex);