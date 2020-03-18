function R = saturation_cust(k,s,beta,x)
% f(x) =        k       si x > beta
%               sx      si -beta <= x <= beta
%               -k      si x < -beta
%
    [m,n] = size(x);

    R = zeros(m,n);
    for i = 1:m*n
        if x(i) < -beta
            R(i) = -k;
        elseif -beta <= x(i) && x(i) <= beta 
            R(i) = s*x(i);
        else
            R(i) = k;
        end
    end
    
    
end