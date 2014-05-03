function [o] = predict_class(x,W)
    v = W'*x';
    o = sign(v);
    
    %fprintf('%2.2f \t %2.2f\n\n', v, o);  
end