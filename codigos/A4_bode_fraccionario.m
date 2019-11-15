%%
clear all;
close all;
clc;
Hz = 0;                 % Activar conversion a Hz
%% Creacion de funcion de transferencia fraccionaria
sys = fotf('1','s^0.5');
w = logspace(-2,2,500);
[mag, phase, wout] = bode(sys,w);
%% Convertir a Hz
if Hz == 1
    wout = wout / (2*pi);
    text = 'Frequency (Hz)';
else
    text = 'Frequency (rad/s)';
end
%% Mostrar diagrama de Bode
figure;
subplot(2,1,1);
semilogx(wout,20*log10(mag(:))); 
title('Diagrama de Bode','interpreter','latex');
ylabel('Magnitud (dB)','interpreter','latex');
xlabel(text,'interpreter','latex');
grid on;
set(gca,'TickLabelInterpreter','latex');
subplot(2,1,2);
semilogx(wout,phase(:)); 
ylabel('Phase (deg)','interpreter','latex')
xlabel(text,'interpreter','latex');
grid on;
set(gca,'TickLabelInterpreter','latex');
% axis tight;