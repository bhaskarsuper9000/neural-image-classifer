function [o] = predict_class_raw(x,W)
    v = W'*x';
    o = sign(v);
    %o = v;
    %fprintf('%2.2f \t %2.2f\n\n', v, o)
end