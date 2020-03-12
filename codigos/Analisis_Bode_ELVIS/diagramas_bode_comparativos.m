%% Bode pasabajas
clear all;
close all;
clc;

%% Funcion de transferencia
text = 'Frequency (Hz)';
Rf = 8.2e3;
Ri = 8.2e3;
C = 1e-9;
wo = 1/(Rf*C);
k = Rf/Ri;

%% Cargar datos simulacion
data_sim = load('pasa_bajas.txt');
wout_sim = data_sim(:,1);
mag_sim = data_sim(:,2);
phase_sim = data_sim(:,3);

%% Cargar datos experimentales
data_exp = load('elvis.txt');
wout_exp = data_exp(:,1);
mag_exp = data_exp(:,2);
phase_exp = data_exp(:,3);

num = -k*wo;
den = [1 wo];
sys = tf(num,den);
w = 2*pi*logspace(3,7,500);
[mag, phase, wout] = bode(sys,w);
wout = wout / (2*pi);

subplot(2,1,1)
semilogx(wout,20*log10(mag(:)),'DisplayName','Ideal');
hold on;
semilogx(wout_sim,mag_sim,'DisplayName','Simulaci\''on');
semilogx(wout_exp,mag_exp,'DisplayName','Experimental');
xlabel(text,'interpreter','latex');
ylabel('Magnitud (dB)','interpreter','latex');
grid on;
axis([1e3 1e7 -60 10]);
set(gca,'TickLabelInterpreter','latex');
legend('interpreter','latex');

subplot(2,1,2)
semilogx(wout,phase(:),'DisplayName','Ideal');
hold on;
semilogx(wout_sim,phase_sim,'DisplayName','Simulaci\''on');
semilogx(wout_exp,phase_exp,'DisplayName','Experimental');
xlabel(text,'interpreter','latex');
ylabel('Fase (deg)','interpreter','latex');
grid on;
set(gca,'TickLabelInterpreter','latex');
legend('interpreter','latex');
