% Convertir sym a funcion de transferencia
function R = syms2tf(G)
    [symNum,symDen] = numden(G); % Obtener num y den funcion simbolica
    TFnum = sym2poly(symNum);    % Convertir num sym a polinomio
    TFden = sym2poly(symDen);    % Convertir den sym a polinomio
    R = tf(TFnum,TFden);         % Generar funcion de transferencia
end
