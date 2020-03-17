%% Clean up subroutine
clear all;
close all;
clc;
Hz = 1;

%% Cargar datos experimentales
data_exp = load('M2_Bilineal_sum_05.dat');
freq_exp = data_exp(:,1); 
mag_exp = data_exp(:,2);
fase_exp = data_exp(:,3);

%% Funcion de transferencia escalada
alfa = 0.5;
D = (alfa^2 - 3*alfa + 2)/(alfa^2 + 3*alfa + 2);
C = (8 - 2*alfa^2)/(alfa^2 + 3*alfa + 2);
kf = 2*pi*1000;                       % Factor de escalamiento
num_esc = [D C*kf kf^2];
den_esc = [1 C*kf D*kf^2];
sys_esc = tf(num_esc,den_esc);

%% Analisis a entrada senoidal
t = linspace(0, 0.01*3, 1000);                         % Time Vector
u = 0.25*sin(100*2*pi*t);                                     % Forcing Function
y = lsim(sys_esc, u, t);                                % Calculate System Response
figure(1)
plot(t, y, 'DisplayName','Salida');
hold on;
plot(t, u, 'DisplayName','Entrada');
grid on;
grid minor;
title('An\''alisis transitorio','interpreter','latex');
xlabel('Tiempo (s)' ,'interpreter','latex');
ylabel('Voltaje (V)','interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');

%%
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
semilogx(w,20*log10(magesc(:)),'DisplayName','Te\''orica');
hold on;
semilogx(freq_exp,mag_exp,'DisplayName','Experimental');
grid on;
title('Diagrama de Bode','interpreter','latex');
ylabel('Magnitude (dB)','interpreter','latex');
xlabel(labelx ,'interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
% axis([min(w) max(w) -60 30]);

subplot(2,1,2);
semilogx(w,faseesc(:),'DisplayName','Te\''orica');
hold on;
semilogx(freq_exp,fase_exp,'DisplayName','Experimental');
grid on;
ylabel('Phase (deg)','interpreter','latex');
xlabel(labelx ,'interpreter','latex');
legend('interpreter','latex','FontSize',7);
set(gca,'TickLabelInterpreter','latex');
% axis([min(w) max(w) -100 100]);