%%
clear all;
close all;
clc;
text = 'Frequency (rad/s)';
n = 5;                                  % Orden de TF
alfa = 0.5;                             % Orden de integrador
alfa_text = num2str(alfa,'%1.2f');

texttitle = strcat('Bode plot: $\alpha=',alfa_text,'$');
%% Creacion de funcion de transferencia fraccionaria
sys1 = fotf('1',strcat('s^',alfa_text));% TF fraccionaria
sys2 = tf(zeros(n,1));                  % Inicializacion TF        
for i = 1:5
    sys2(i) = cfetf(alfa,i*2);
end
w = logspace(-2,2,500);                 % Vector de frecuencias

%% Mostrar diagrama de Bode
figure;
for i=1:n
    legenda = strcat(num2str(i,'%d'),' order') ;
    [mag2, phase2, wout2] = bode(sys2(i),w);
    
    subplot(2,1,1);
    semilogx(wout2,20*log10(mag2(:)),'DisplayName',legenda);
    hold on;
    legend('interpreter','latex');
    
    subplot(2,1,2);
    semilogx(wout2,phase2(:),'DisplayName',legenda); 
    hold on;
    legend('interpreter','latex');
end

[mag, phase, wout] = bode(sys1,w);  
subplot(2,1,1);
semilogx(wout,20*log10(mag(:)),'DisplayName','Ideal','LineWidth',1.4); 
title(texttitle,'interpreter','latex');
ylabel('Magnitude (dB)','interpreter','latex');
xlabel(text,'interpreter','latex');
grid on;
legend('interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

subplot(2,1,2);
semilogx(wout,phase(:),'DisplayName','Ideal','LineWidth',1.4); 
ylabel('Phase (deg)','interpreter','latex')
xlabel(text,'interpreter','latex');
grid on;
set(gca,'TickLabelInterpreter','latex');
legend('interpreter','latex');
% axis tight;