%%
clear all;
close all;
clc;

Rf = 8.1e3;
Ri = 8.06e3;
C = 1e-9;
wo = 1/(Rf*C);
k = Rf/Ri;
num = -k*wo;
den = [1 wo];
sys = tf(num,den);

                                   % Define LTI System
t = linspace(0, 5*1e-4, 1000);                         % Time Vector
u = 1*sin(2*pi*19.9e3*t);                                     % Forcing Function
y = lsim(sys, u, t);                                % Calculate System Response
figure(1)
plot(t, y)
grid