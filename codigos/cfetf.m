function R = cfetf(alfa,n)
% Calcula la aproximacion utilizando CFE de un integrador fraccional
% 1/s^(alfa)
%       alfa: es el orden del integrador
%       n   : es el numero de terminos de la aproximacion
    syms s x;
    eqns = sym(zeros(n,1));
    for i=n:-1:2
        if i == n
            eqns(i) = 1 + n_term_cfe(i,alfa)*x;
        else
            eqns(i) = 1 + (n_term_cfe(i,alfa)*x)/eqns(i+1);
        end
    end
    eqns(1) = 1/(1 - (alfa*x/eqns(2)));
    derivate = simplify(subs(eqns(1),x,s-1));
    integrator = collect(1/derivate);
    sys = syms2tf(integrator);
%     pretty(integrator);
    R = sys;
end
%% Funciones
function R = psi_cfe(x)
    R = floor(x/2);
end 

function R = n_term_cfe(n,k)
    R = ( psi_cfe(n) * ( psi_cfe(n) + k*(-1)^n ) )/( (n-1)*(n));
end