function [fun,r2] = polyReg(sz,t,y)
%POLYREG Summary of this function goes here
%   Detailed explanation goes here
    dim = size(t);
    if(dim(1) > 1)
        disp("You gave me a dysfunctional matrix! (t)")
    end
    dim = size(y);
    if(dim(1) > 1)
        disp("You gave me a dysfunctional matrix! (y)")
    end
    
    x = zeros(length(t),sz+1);
    for i = 0:sz
        x(:,end-i) = t.^i;
    end
    
    fun = pinv(x'*x)*x'*y';
    r2 = mean((y-(x*fun)').^2);
end

