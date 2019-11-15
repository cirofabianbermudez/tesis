%%
clear all;
close all;
clc;

%% Norbres de archivos
% Normal
filename = ["D1_sin_normalizar_magnitud.xlsx","D1_sin_normalizar_fase.xlsx"];                               % Normal
% filename = ["D1_sin_normalizar_error_magnitud.xlsx","D1_sin_normalizar_error_fase.xlsx"];                 % Error
% filename = ["D1_sin_normalizar_prom_error_magnitud.xlsx","D1_sin_normalizar_prom_error_fase.xlsx"];       % Error promedio

% Normalizado
% filename = ["D2_normalizada_magnitud.xlsx","D2_normalizada_fase.xlsx"]                                      % Normalizado
% filename = ["D2_normalizada_error_magnitud.xlsx","D2_normalizada_error_fase.xlsx"]                          % Error normalizado
% filename = ["D2_normalizada_prom_error_magnitud.xlsx","D2_normalizada_prom_error_fase.xlsx"];               % Error promedio normalizado
%% 

%% Cargar datos
alfa = (0.1:0.1:0.9);
% Cargar vector de frecuencias
w = xlsread('frecuencias.xlsx');
for j = 1:2
    [~, sheets] = xlsfinfo( string( filename(j) ) );                % Informacion de Excel
    test = xlsread( string( filename(j) ) );                        % Calcular numero de renglones y columnas
    n_sheets = max(size(sheets));                                   % Calcular numero de hojas
    if j == 1 
        magnitud = zeros([ size(test) n_sheets]);  
        for i=1:n_sheets
            magnitud(:,:,i) = xlsread(string(filename(j)),i);
        end
    else
        fase = zeros([ size(test) n_sheets]);
        for i=1:n_sheets
            fase(:,:,i) = xlsread(string(filename(j)),i);
        end
    end
        
end
%%

%% Graficar magnitud
figure(1);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:size(magnitud,2)
        if k == 1
            if i == 1
                legendtext = 'Ideal';
            else
                legendtext = strcat(num2str(i-1,'%d'),' orden');
            end
            semilogx(w,magnitud(:,i,k),'DisplayName',legendtext);
            legend('interpreter','latex','FontSize',7);
            set(gca,'TickLabelInterpreter','latex');
            hold on;
        else
            semilogx(w,magnitud(:,i,k));
            set(gca,'TickLabelInterpreter','latex');
            hold on;  
        end
    end
    title(titletext,'interpreter','latex');
    ylabel('Magnitud (dB)','interpreter','latex');
    xlabel('Frequency (rad/s)','interpreter','latex');
    grid on;
end
%%

%% Graficar fase
figure(2);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:size(fase,2)
        if k == 1
            if i == 1
                legendtext = 'Ideal';
            else
                legendtext = strcat(num2str(i-1,'%d'),' orden');
            end
            semilogx(w,fase(:,i,k),'DisplayName',legendtext);
            legend('interpreter','latex','FontSize',7);
            set(gca,'TickLabelInterpreter','latex');
            hold on;
        else
            semilogx(w,fase(:,i,k));
            set(gca,'TickLabelInterpreter','latex');
            hold on;  
        end
    end
    title(titletext,'interpreter','latex');
    ylabel('Phase (deg)','interpreter','latex');
    xlabel('Frequency (rad/s)','interpreter','latex');
    grid on;
end
%%
