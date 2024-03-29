%% Clean up subroutine
clear all;
close all;
clc;
Hz = 1;

%% Funcion de transferencia escalada
alfa = 0.5;
A = (1-alfa)/(1+alfa);
kf = 2*pi*1000;                       % Factor de escalamiento
num_esc = [A kf];
den_esc = [1 A*kf];
sys_esc = tf(num_esc,den_esc);


w = kf*logspace(-1,1,500);         % Vector de frecuencias en rad/s
[magesc, faseesc, ~] = bode(sys_esc,w);

if Hz == 1
    w = w/(2*pi);
    labelx = 'Frequency (Hz)';
else
    w = w;
    labelx = 'Frequency (rad/s)';
end
figure(1);
subplot(2,1,1);
semilogx(w,20*log10(magesc(:)),'DisplayName','Escalada');
grid on;
title('Bode plot','interpreter','latex');
ylabel('Magnitude (dB)','interpreter','latex');
xlabel(labelx ,'interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
% axis([min(w) max(w) -60 30]);

subplot(2,1,2);
semilogx(w,faseesc(:),'DisplayName','Escalada');
grid on;
ylabel('Phase (deg)','interpreter','latex');
xlabel(labelx ,'interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
% axis([min(w) max(w) -100 100]);