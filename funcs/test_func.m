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
    
    m = x(1);
    N = x(2);

    L = 40;
    M = 20;
    r = 5;
    c_1 = 1;
    c_2 = 10;

    ro = L/M;
    q1 = ro / m;

    if q1 == 1
        sum = 0;
        for k = 0 : m - 1
            a = (ro^k)/(factorial(k));
            b = (ro^m)/(factorial(m));
            b = b * (N+1);
            sum = sum + a + b;
        end
        p0 = sum^(-1);
    else
        sum = 0;
        for k = 0 : m - 1
            a = (ro^k)/(factorial(k));
            b = (ro^m)/(factorial(m));
            up = 1 - (ro / m)^(N+1);
            down = 1 - (ro/m);
            c = (up/down);
            sum = sum + a + b*c;
        end
        p0 = sum^(-1);
    end

    up = ro^(N+m);
    down = (m^(N))*factorial(m);
    p_odm = (up/down)*p0;
    
    output = L * (1 - p_odm) * r - c_1 * N - c_2 * m;
end