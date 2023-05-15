function [res] = hyper_ellipse(x)

    res = 0;
    for i = 1:length(x)
        res = res + x(i)^2;
    end
end

