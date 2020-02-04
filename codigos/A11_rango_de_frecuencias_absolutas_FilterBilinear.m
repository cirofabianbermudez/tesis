%% Clean subroutine
clear all;
close all;
clc;
format short;
%%
sys1 = 16e6;                    % 16 MHz     
n = [1,( 2:2:510)];            
freq = ((sys1./n)/1000)';       % en kHz
freq_min = freq/1000;           
freq_max = freq/10;
T = table(freq, n', freq_min, freq_max);
disp(T);