%%
clear all;
close all;
clc;
%% Variables
syms s x k;
n = 4;
% k = 1/2;
eqns = sym(zeros(n,1));
for i=n:-1:2
    if i == n
        eqns(i) = 1 + n_term_cfe(i,k)*x;
    else
        eqns(i) = 1 + (n_term_cfe(i,k)*x)/eqns(i+1);
    end
end
eqns(1) = 1/(1 - (k*x/eqns(2)));
derivate = simplify(subs(eqns(1),x,s-1));
integrator = collect(1/derivate);                  
pretty(integrator);
% sys = syms2tf(integrator);
%% Funciones
function R = psi_cfe(x)
    R = floor(x/2);
end 

function R = n_term_cfe(n,k)
    R = ( psi_cfe(n) * ( psi_cfe(n) + k*(-1)^n ) )/( (n-1)*(n));
end