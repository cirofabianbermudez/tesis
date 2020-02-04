%% Clean subroutine
clear all;
close all;
clc;
format short;
%% Calcular fp y fz
paso = 0.01;
alpha = (paso:paso:0.99)';          % Orden fraccionario
kf = 2*pi*1000;                     % Factor de escalamiento
A = (1 - alpha)./(1 + alpha);
fp = (A*kf)./(2*pi*1000);           % Frecuencia de polo en kHz 
fz = (kf)./(A*2*pi*1000);           % Frecuencia de cero en kHz

%% Rango de frecuencias absolutas
sys1 = 16e6;                        % 16 MHz
n = [1,( 2:2:510)];             	% n
freqs = ((sys1./n)/1000)';          % in kHz 
freq_min = freqs/1000;
freq_max = freqs/10;
%%
vv = zeros(size(freqs,1),9);        % Matriz binaria de verdad
for i=1:size(freqs,1)               % Frecuencias 
    for j=1:size(alpha,1)           % Ordenes 
        cond1 = fp(j) >= freq_min(i)  && fp(j) <= freq_max(i);
        cond2 = fz(j) >= freq_min(i)  && fz(j) <= freq_max(i);
        if cond1 && cond2
            vv(i,j) = 1;
        else
            vv(i,j) = 0;
        end
    end
end
R = [freqs freq_min freq_max vv];
% csvwrite('Analisis.csv',R);
%%
T = sum(vv,2);      % Suma horizantal
Tp = T*paso;        % Conversion 
%% Graficar
bar(n,Tp,'DisplayName','Orden');
title('An\''alisis de frecuencias FilterBilinear (16 MHz/n)','interpreter','latex');
xlabel('Divisi\''on $n$ ','interpreter','latex');
ylabel('Orden fraccionario $\alpha$','interpreter','latex');
% legend('interpreter','latex','FontSize',10);
grid on;
grid minor;
set(gca,'TickLabelInterpreter','latex');