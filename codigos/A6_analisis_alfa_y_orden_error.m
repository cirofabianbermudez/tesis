%%
clear all;
close all;
clc;
text = 'Frequency (rad/s)';
n = 5;                                  % Orden de TF
alfa = (0.1:0.1:0.9);                   % Orden de integrador
% texttitle = strcat('Diagrama de Bode: $\alpha$=',alfa_text);
w = logspace(-1,1,500);                 % Vector de frecuencias
magnitud = zeros(max(size(w)),n+1,max(size(alfa)));     
fase = zeros(max(size(w)),n+1,max(size(alfa)));

%% Creacion de funcion de transferencia fraccionaria
for j=1:max(size(alfa))
    alfa_text = num2str(alfa(j),'%1.2f'); 
    sysideal = fotf('1',strcat('s^',alfa_text));% TF fraccionaria
    sysaprox = tf(zeros(n,1));                  % Inicializacion TF
    
    [magnitud(:,1,j),fase(:,1,j),~] = bode(sysideal,w);  
    for i = 1:n
        sysaprox(i) = cfetf(alfa(j),i*2);
        [magnitud(:,i+1,j),fase(:,i+1,j),~] = bode(sysaprox(i),w);
    end
end
magnitud = 20*log10(magnitud);
%%

%% Normalizar (Nota: solo se debe ejecutar una vez)
normmag = 20.*alfa;
normfase = 90.*alfa;
for i = 1:max(size(alfa))
   magnitud(:,:,i) = magnitud(:,:,i)./normmag(i);
   fase(:,:,i) = fase(:,:,i)./normfase(i);
end
%%

%% Calculo de errores, promedio de errores
errormag = zeros(max(size(w)),n,max(size(alfa)));
errorfase = zeros(max(size(w)),n,max(size(alfa)));
promerrormag = zeros(1,n,max(size(alfa)));
promerrorfase = zeros(1,n,max(size(alfa)));
errormagmax = zeros(1,n,max(size(alfa)));
errorfasemax = zeros(1,n,max(size(alfa)));
for i = 1:max(size(alfa))
    for j = 1:n
        errormag(:,j,i) = magnitud(:,1,i) - magnitud(:,j+1,i);
        errorfase(:,j,i) = fase(:,1,i) - fase(:,j+1,i);
    end 
    promerrormag(1,:,i) = sum(abs(errormag(:,:,i)))./max(size(errormag));
    promerrorfase(1,:,i) = sum(abs(errorfase(:,:,i)))./max(size(errorfase));
    errormagmax(1,:,i) = max(abs(errormag(:,:,i)));
    errorfasemax(1,:,i) = max(abs(errorfase(:,:,i)));
end
%%

%% Graficar magnitud
figure(1);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:n+1
        if k == 1
            if i == 1
                legendtext = 'Ideal';
            else
                legendtext = strcat(num2str(i-1,'%d'),' order');
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
    ylabel('Magnitude (dB)','interpreter','latex');
    xlabel('Frequency (rad/s)','interpreter','latex');
    grid on;
end
%%

%% Graficar fase
figure(2);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:n+1
        if k == 1
            if i == 1
                legendtext = 'Ideal';
            else
                legendtext = strcat(num2str(i-1,'%d'),' order');
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

%% Graficar error de magnitud
figure(1);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:n
        if k == 1
            legendtext = strcat(num2str(i,'%d'),' order');
            semilogx(w,errormag(:,i,k),'DisplayName',legendtext);
            legend('interpreter','latex','FontSize',7);
            set(gca,'TickLabelInterpreter','latex');
            hold on;
        else
            semilogx(w,errormag(:,i,k));
            set(gca,'TickLabelInterpreter','latex');
            hold on;  
        end
    end
    title(titletext,'interpreter','latex');
    ylabel('Magnitude (dB)','interpreter','latex');
    xlabel('Frequency (rad/s)','interpreter','latex');
    grid on;
end
%%

%% Graficar error de fase
figure(2);
for k = 1:max(size(alfa))
    subplot(3,3,k);
    titletext = strcat('$\alpha=',num2str(alfa(k),'%1.2f'),'$');
    for i = 1:n
        if k == 1
            legendtext = strcat(num2str(i,'%d'),' orden');
            semilogx(w,errorfase(:,i,k),'DisplayName',legendtext);
            legend('interpreter','latex','FontSize',7);
            set(gca,'TickLabelInterpreter','latex');
            hold on;
        else
            semilogx(w,errorfase(:,i,k));
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

%% Generar tablas de error maximo
datamag = zeros(max(size(alfa)),n);
datafase = zeros(max(size(alfa)),n);
for i = 1:max(size(alfa))
    datamag(i,:) = errormagmax(1,:,i);
    datafase(i,:) = errorfasemax(1,:,i);
end
TabMag.dataFormat =  {'%1.1f',1,'%1.4f',n};
TabFase.dataFormat =  {'%1.1f',1,'%1.4f',n};
TabMag.data = [alfa' datamag*100];
TabFase.data = [alfa' datafase*100];
% latex = latexTable(TabMag);
latex = latexTable(TabFase);
%%

%% Generar tablas de error promedio
datamag = zeros(max(size(alfa)),n);
datafase = zeros(max(size(alfa)),n);
for i = 1:max(size(alfa))
    datamag(i,:) =  promerrormag(1,:,i);
    datafase(i,:) = promerrorfase(1,:,i);
end
TabMag.dataFormat =  {'%1.1f',1,'%1.4f',n};
TabFase.dataFormat =  {'%1.1f',1,'%1.4f',n};
TabMag.data = [alfa' datamag*100];
TabFase.data = [alfa' datafase*100];
% latex = latexTable(TabMag);
latex = latexTable(TabFase);
%%

%% Guardar resultados en excel dB
for i = 1:max(size(alfa))
    xlswrite('D1_sin_normalizar_magnitud.xlsx',magnitud(:,:,i),i);
    xlswrite('D1_sin_normalizar_fase.xlsx',fase(:,:,i),i);
end
%%

%% Guardar errores y promedios de error en excel dB
for i = 1:max(size(alfa))
    xlswrite('D1_sin_normalizar_error_magnitud.xlsx',errormag(:,:,i),i);
    xlswrite('D1_sin_normalizar_error_fase.xlsx',errorfase(:,:,i),i);
    xlswrite('D1_sin_normalizar_prom_error_magnitud.xlsx',promerrormag(:,:,i),i);
    xlswrite('D1_sin_normalizar_prom_error_fase.xlsx',promerrorfase(:,:,i),i);
end
%%

%% Guardar resultados en excel normalizado
for i = 1:max(size(alfa))
    xlswrite('D2_normalizada_magnitud.xlsx',magnitud(:,:,i),i);
    xlswrite('D2_normalizada_fase.xlsx',fase(:,:,i),i);
end
%%

%% Guardar errores y promedios de error en excel normalizado
for i = 1:max(size(alfa))
    xlswrite('D2_normalizada_error_magnitud.xlsx',errormag(:,:,i),i);
    xlswrite('D2_normalizada_error_fase.xlsx',errorfase(:,:,i),i);
    xlswrite('D2_normalizada_prom_error_magnitud.xlsx',promerrormag(:,:,i),i);
    xlswrite('D2_normalizada_prom_error_fase.xlsx',promerrorfase(:,:,i),i);
end
%%

%% Guardar vector de freccuencias
    xlswrite('frecuencias.xlsx',w);
%%