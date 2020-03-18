%% 
clear all;
close all;
clc;
tic                             %Medir tiempo de ejecucion
%% Variables 
ini_cond = [0 0 0]';            % Condiciones iniciales
tn = 3;                        % Tiempo 
h = 0.001;                      % Paso de integracion
k = round(tn/h);                % Numero de iteraciones
alpha = 0.8;                   % Orden fraccionario
lm = (tn/10);                   % Tamanio de memoria
M =  lm/h;                      % Ventana de memoria
%% Inicializacion de vectores
x = zeros(k + 1, 1);
y = zeros(k + 1, 1);
z = zeros(k + 1, 1);
Cj = zeros(k + 1, 1);
A = zeros(3,1);
%% Primer elemento de los vectores
x(1) = ini_cond(1);
y(1) = ini_cond(2);
z(1) = ini_cond(3);
Cj(1) = 1;
%% Calculo coeficientes Cj
for j=1:M
    Cj(j+1) = ( 1 - (alpha+1)/(j) ) * Cj(j);
end
for i=1:k
    A(:) = 0;
    %% Principio de memoria corta
%     if i < M
%         v = i;
%     else
%         v = M;
%     end
    %% Sin memoria corta
     v = i;
    for j=1:v
        A(1) = A(1) + Cj(j+1)*x(i+1-j);
        A(2) = A(2) + Cj(j+1)*y(i+1-j);
        A(3) = A(3) + Cj(j+1)*z(i+1-j);
    end
    x(i+1) = x_state(x(i),y(i),z(i))*h^(alpha) - A(1);
    y(i+1) = y_state(x(i),y(i),z(i))*h^(alpha) - A(2);
    z(i+1) = z_state(x(i),y(i),z(i))*h^(alpha) - A(3);
end

plot3(x,y,z);
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
grid on;
toc             % Mostrar tiempo de ejecucion
%% Funciones oscilador caotico de Chen de orden fraccionario
function R = x_state(x,y,z)
    R = y;
end

function R = y_state(x,y,z)
    R = z;
end

function R = z_state(x,y,z)
    a = 4;
    b = 0.7;
    c = 0.7;
    d = 4;
    R = -a*x - b*y - c*z + d*saturation_cust(1,0.1,0.1,x);
end