%%
clear all;
close all;
clc;

%%
h = 0.01; %2.5e-04
k_max = 10000;
alpha = 0.93;

x = zeros(k_max + 1, 1);
y = zeros(k_max + 1, 1);
z = zeros(k_max + 1, 1);
Cj = zeros(k_max + 1, 1);

ini_cond = [0 0 0]';

%%
x(1) = ini_cond(1);
y(1) = ini_cond(2);
z(1) = ini_cond(3);
Cj(1) = 1;

%% Calculo coeficientes Cj
for j=1:k_max 
    Cj(j+1) = ( 1 - (alpha+1)/(j) ) * Cj(j);
end

for k=1:k_max
    tx = 0;
    ty = 0;
    tz = 0;
    for j=1:k
        tx = tx + Cj(j+1)*x(k+1-j);
        ty = ty + Cj(j+1)*y(k+1-j);
        tz = tz + Cj(j+1)*z(k+1-j);
    end
    x(k+1) = x_state(x(k),y(k),z(k))*h^(alpha) - tx;
    y(k+1) = y_state(x(k),y(k),z(k))*h^(alpha) - ty;
    z(k+1) = z_state(x(k),y(k),z(k))*h^(alpha) - tz;
end

plot3(x,y,z);
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
% axis([-40 40 -40 40 10 70])
grid on;

%%
function R = x_state(x,y,z)
    m = 3;
    n = 1;
    R = (-m/4)*sin(5*n*z);
end

function R = y_state(x,y,z)
    R = -8*x^2 - y;
end

function R = z_state(x,y,z)
    a = 8/5;
    b = 7/5;
    R = a/5 + (4*b*x)/(5) + (2*y)/(5);
end

