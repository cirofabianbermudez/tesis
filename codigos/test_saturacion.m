%% 
clear all;
close all;
clc;

x = -5:0.01:5;
% k,s,beta,x
y =  saturation_cust(1,0.1,0.1,x);
plot(x,y)
grid on;
grid minor;
axis([-5 5 -1 1]);