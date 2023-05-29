function [output] = test_func(x)

    % Testowa funkcja licząca funkcję celu 
    % systemu kolejkowego M/M/m/FIFO/m+N
    % L -> Lambda
    % M -> Mi
    % c_1, c_2 -> ograniczenia zysku
    % r -> zysk monetarny
    % mNArr -> krotka wartości (m,N)
    % argumentami (x,y) są (m,N)
    %
    % funkcja celu f(m,N) = L(1 - p_odm) * r - c_1 * N - c_2 * m;
    
    L = 40;
    M = 20;
    r = 5;
    c_1 = 1;
    c_2 = 10;

    % x = [x1, x2] = [m, N]

    x = round(x);
    x = abs(x);

    ro = L/M;
    q = ro / x(1);

    % obliczanie p0
    if q == 1
        sum = 0;
        for i = 0 : length(x) - 1
            sum = sum + (ro^i)/(factorial(i)) + ((ro^x(1))/(factorial(x(1)))) * (x(2) + 1);
        end
        sum = sum^(-1);
        p0 = sum;
    else
        sum = 0;
        for i = 0 : x(1) - 1
            up = 1 - (ro / x(1))^(x(2)+1);
            down = 1 - (ro/x(1));
            sum = sum + (ro^i)/(factorial(i)) + ((ro^x(1))/(ro^x(1))) * (up / down);
        end
        sum = sum^(-1);
        p0 = sum;
    end

    p_odm = (ro^(x(1) + x(2)))/(x(1)*factorial(x(1))) * p0;
            

    output = L * (1 - p_odm) * r - c_1 * x(2) - c_2 * x(1);
end