%% Clean up subroutine
clear all;
close all;
clc;

%% Funcion de transferencia normal
num = [200 0];
den = [1 12 20];
sys = tf(num,den);

%% Funcion de transferencia escalada 
kf = 100;                       % Factor de escalamiento
num_esc = [200*(kf) 0];
den_esc = [1 12*kf 20*(kf^2)];
sys_esc = tf(num_esc,den_esc);

w = logspace(-2,5,500);         % Vector de frecuencias 
[mag, fase, ~] = bode(sys,w);
[magesc, faseesc, ~] = bode(sys_esc,w);

figure(1);
subplot(2,1,1);
semilogx(w,20*log10(mag(:)),'DisplayName','Normal');
hold on;
semilogx(w,20*log10(magesc(:)),'DisplayName','Escalada');
grid on;
title('Diagrama de Bode','interpreter','latex');
ylabel('Magnitud (dB)','interpreter','latex');
xlabel('Frequency (rad/s)','interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
axis([min(w) max(w) -60 30]);

subplot(2,1,2);
semilogx(w,fase(:),'DisplayName','Normal');
hold on;
semilogx(w,faseesc(:),'DisplayName','Escalada');
grid on;
ylabel('Phase (deg)','interpreter','latex');
xlabel('Frequency (rad/s)','interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
axis([min(w) max(w) -100 100]);