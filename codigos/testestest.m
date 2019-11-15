%%
clear all;
close all;
clc;

alfa = 0.1;
alfa_text = num2str(alfa(1),'%1.2f'); 
H = fotf('1',strcat('s^',alfa_text));% TF fraccionaria
A = (1-alfa)/(1+alfa);
G = tf([A 1],[1 A]);
w = logspace(-1,1,500);                 % Vector de frecuencias
sys = H/G;
[mag,phase,wout] = bode(sys,w);

result = 20*log10(mag(:))/(20*alfa);
semilogx(w,result);
