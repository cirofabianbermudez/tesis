%% 
clear all;
close all;
clc;
tic                             %Medir tiempo de ejecucion
%% Variables 
ini_cond = [-9 -5 14]';         % Condiciones iniciales
tn = 50;                        % Tiempo 
h = 0.001;                      % Paso de integracion
k = round(tn/h);                % Numero de iteraciones
alpha = 0.83;                   % Orden fraccionario
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
    if i < M
        v = i;
    else
        v = M;
    end
    %% Sin memoria corta
    % v = i;
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
    R = 35*(y - x);
end

function R = y_state(x,y,z)
    R = -7*x -x*z + 28*y;
end

function R = z_state(x,y,z)
    R = x*y - 3*z;
end