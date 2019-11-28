%% 
clear all;
close all;
clc;

x = (-pi:0.01:pi);
y = sin(x);
plot(x,y,'DisplayName','Simulacion');
grid on;
grid minor;
xlabel('Tiempo (s)','interpreter','latex');
ylabel('Voltae (V)','interpreter','latex');
title('Funci\''on seno','interpreter','latex')
legend('interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
