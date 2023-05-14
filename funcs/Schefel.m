function [res] = Schefel(x)

    res = 0;
    for i = 1:length(x)
        res = res + (-x(i)*sin(sqrt(abs(x(i)))));
    end
end
