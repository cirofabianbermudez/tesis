%%
clear all;
close all;
clc;

% x = [1 (2:2:510)];
% y = 16*x;
% 
% T = table(x',y');
% disp(T);

x = 146:2:176;
y = x./16;
T = table(x',y');
disp(T);
%%
% sys1 = (16e6/510)/(1000);
% clk3 = sys1/316;
% 
% g = sys1/(16*clk3);
% disp(clk3);
% disp(g);

