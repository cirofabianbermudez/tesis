%% Lookup Table
paso = 6/256;
Vin = (-3:paso:3);
w = 10;
Vout = 2*sinc((w/pi)*Vin);
data = Vout(1:end-1)';
%% Escribir a archivo de Excel CSV
csvwrite('Lookup_Table.csv',data);
%% Ver grafica
plot(Vin,Vout);
grid on;
grid minor;
ylabel('$\mathrm{Vout}$ (V)','interpreter','latex');
xlabel('$\mathrm{Vin}$ (V)' ,'interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
title('Lookup table','interpreter','latex');