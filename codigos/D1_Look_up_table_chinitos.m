%% Lookup Table
paso = 6/256;
Vin = (-3:paso:3);
m = 10;
n = 0.5;
Vout = (m/4)*sin(5*n*Vin);
data = Vout(1:end-1)';
%% Escribir a archivo de Excel CSV
csvwrite('Lookup_Table_chinitos.csv',data);
%% Ver grafica
plot(Vin,Vout);
grid on;
grid minor;