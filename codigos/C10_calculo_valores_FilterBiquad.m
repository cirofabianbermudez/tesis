%% Clear subroutine
clear all;
close all;
clc;
%%
paso = 0.05;
alpha = (0.1:paso:0.95)';           % Orden del integrador
kf = 2*pi*1000;                     % Factor de escalamiento
D = (alpha.^2 - 3*alpha + 2)./(alpha.^2 + 3*alpha + 2);
C = (8 - 2*alpha.^2)./(alpha.^2 + 3*alpha + 2);

Gh = D;
fz = (kf)./(1000*2*pi*D.^(1/2));
fp = (D.^(1/2)*kf)./(2*pi*1000);
Qz = (D.^(1/2))./(C);
Qp = (D.^(1/2))./(C);
Gl = 1./D;

T = table(alpha,Gh,Gl,fz,fp,Qz,Qp);
disp(T);

%% Latex table
T_latex.data = table(alpha,Gh,Gl,fz,fp,Qp);
T_latex.dataFormat = {'%1.2f',1,'%.6f',5};
% disp(T_latex.data);
latex = latexTable(T_latex);