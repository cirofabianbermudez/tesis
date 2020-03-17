function R = saturation_cust(k,x)
    
    [m,n] = size(x);

    R = zeros(m,n);
    for i = 1:m*n
        if x(i) < -1
            R(i) = -k;
        elseif -1 <= x(i) && x(i) <= 1  
            R(i) = k*x(i);
        else
            R(i) = k;
        end
    end
    
    
end