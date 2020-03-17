%% Clean subroutine
clear all;
close all;
clc;
format short;
%% Calcular fp y fz
paso = 0.01;
alpha = (paso:paso:0.99)';          % Orden fraccionario
kf = 2*pi*1000;                     % Factor de escalamiento

D = (alpha.^2 - 3*alpha + 2)./(alpha.^2 + 3*alpha + 2);
C = (8 - 2*alpha.^2)./(alpha.^2 + 3*alpha + 2);

Gh = D;
fz = (kf)./(1000*2*pi*D.^(1/2));
fp = (D.^(1/2)*kf)./(2*pi*1000);
Qz = (D.^(1/2))./(C);
Qp = (D.^(1/2))./(C);
Gl = 1./D;

%% Rango de frecuencias absolutas
sys1 = 16e6;                        % 16 MHz
n = [1,( 2:2:510)];             	% n
freqs = ((sys1./n)/1000)';          % in kHz 
freq_min = freqs/500;
freq_max = freqs/10;
Gl_min = 0.01;
Gl_max = 100;
Gh_min = 0.01;
Gh_max = 15.9;
Qz_min = 0.05;
Qz_max = 60;
Qp_min = 0.05;
Qp_max = 70;
%%
vv = zeros(size(freqs,1),9);        % Matriz binaria de verdad
for i=1:size(freqs,1)               % Frecuencias 
    for j=1:size(alpha,1)           % Ordenes 
        cond1 = fz(j) >= freq_min(i)  && fz(j) <= freq_max(i);
        cond2 = fp(j) >= freq_min(i)  && fp(j) <= freq_max(i);
        
%         cond3 = Gl(j) >= Gl_min  && Gl(j) <= Gl_max;
%         cond4 = Gh(j) >= Gh_min  && Gh(j) <= Gh_max;
%         
%         cond5 = Qz(j) >= Qz_min  && Qz(j) <= Qz_max;
%         cond6 = Qp(j) >= Qp_min  && Qp(j) <= Qp_max;
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
title('An\''alisis de frecuencias suma de filtros (16 MHz/n)','interpreter','latex');
xlabel('Divisi\''on $n$ ','interpreter','latex');
ylabel('Orden fraccionario $\alpha$','interpreter','latex');
% legend('interpreter','latex','FontSize',10);
grid on;
grid minor;
set(gca,'TickLabelInterpreter','latex');