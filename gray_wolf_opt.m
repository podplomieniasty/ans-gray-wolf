function [alpha_score, alpha_position, convergence_plot] = gray_wolf_opt(f, dim, min_x, max_x,  pack_size, max_iter, optType)
    %f = @F7;
    %fun = f; % Wiem ze chujowo to napisalem ale Matlab to gowno i nie zamierzam tego poprawiac
    %dziala mi w koncu w appdesignerze, nie mam pojecia czemu i nie mam
    %zamiaru je miec xDD
    %jebac Matlaba
    %   ALGORYTM SZAREGO WILKA, v.1
    %   
    % 
    %   
    % parametry  
    %-------------------------------------------------------------
    % f          ->  funkcja celu oraz funkcja jakości wilka
    % dim        ->  liczba wymiarów oraz argumentów funkcji  celu
    % min_x      ->  dolna granica
    % max_x      ->  górna granica
    % pack_size  ->  liczebność watahy
    % max_iter   ->  maksymalna liczba iteracji
    % 
    % 
    % zwraca 
    %-------------------------------------------------------------
    % alpha_score      ->  optymalny wynik algorytmu 
    % alpha_position   ->  optymalne pozycje wilka
    % convergence_plot ->  dane do wykresu konwergencji


    % inicjalizacja pozycji startowych oraz wyników
    % ---------------------------------------------
    % inf   -> w celach optymalizacyjnych
    % zeros -> sam wilk nie został wybrany, zostanie wybrany w trakcie
    %          algorytmu

    switch optType
        case 'MIN'
            wolfRange = inf;
            optFactor = 1;
        case 'MAX'
            wolfRange = -inf;
            optFactor = -1;
        otherwise
            error('Niepoprawny typ optymalizacyjny!');
    end
    alpha_score = wolfRange;
    alpha_position = zeros(1, dim);

    beta_score = wolfRange;
    beta_position = zeros(1, dim);

    delta_score = wolfRange;
    delta_position = zeros(1, dim);

    % inicjalizacja wynikowego wykresu konwergencji
    % cokolwiek to znaczy lol
    convergence_plot = zeros(1, max_iter);

    % inicjalizacja pozycji startowych wszystkich wilkow
    bounds_count = size(max_x, 2);
    
    % jeśli jest tylko jedna granica dla wszystkich zmiennych
    % i jeśli min_x i max_x są pojedynczymi numerami
    if bounds_count == 1
        positions = rand(pack_size, dim) .* (max_x - min_x) + min_x; 
    end

    % jeśli zmienne mają różne granice
    if bounds_count > 1
        for i=1:dim
            max_i = max_x(i);
            min_i = min_x(i);
            positions = rand(pack_size, 1) .* (max_i - min_i) + min_i;
        end
    end

    % główna pętla licząca 
    iter = 0;
    while iter < max_iter

        a = 2 * (1 - (iter/max_iter)); % liniowo zmniejsza się do z 2 do 0

        % szacowanie poziomu sprawności wszystkich wilków,
        % wybór nowych wilków alfa, beta i delta
        % oraz aktualizacja ich pozycji
        for i = 1:size(positions,1)   
    
            % HUZZAH
            % MAGIC
            Flag4ub=positions(i,:)>max_x;  
            Flag4lb=positions(i,:)<min_x;
            positions(i,:)=(positions(i,:).*(~(Flag4ub+Flag4lb)))+max_x.*Flag4ub+min_x.*Flag4lb;         

            fitness = optFactor * f(positions(i, :));
            
            if fitness < alpha_score
                alpha_score = fitness;
                alpha_position = positions(i, :);
            end

            if fitness > alpha_score && fitness < beta_score
                beta_score = fitness;
                beta_position = positions(i, :);
            end

            if fitness > alpha_score && fitness > beta_score && fitness < delta_score
                delta_score = fitness;
                delta_position = positions(i, :);
            end                
        end
        

        for i=1:size(positions, 1)
            for j=1:size(positions, 2)

                [X1] = get_new_position(a, alpha_position(j), positions(i, j));
                [X2] = get_new_position(a, beta_position(j), positions(i, j));
                [X3] = get_new_position(a, delta_position(j), positions(i, j));

                positions(i, j) = (X1 + X2 + X3) / 3;
            end
        end
        iter = iter + 1;
        convergence_plot(iter) = alpha_score;

    end % while END

    alpha_position = transpose(alpha_position);

    function [X] = get_new_position(a, wolf_pos, glob_pos)
    
    % funkcja do zwrocenia pozycji jednego z glownych wilkow.
    % mozna bylo to zrobic po prostu w kodzie zamiast w funkcji.
    % nie lubie powtarzalnosci wiec trudno hehe
    %   
    % parametry
    % -----------------------------------------------------------------
    % a         ->  współczynnik liniowy podany wyżej
    % wolf_pos  ->  pozycja danego wilka z macierzy w danej iteracji, 
    %               np. alfa(j)
    % glob_pos  ->  pozycja wilka w macierzy(x, y), np. positions(i, j)

        r1 = rand();
        r2 = rand();

        A = 2 * a * r1 - a;
        C = 2 * r2;
        
        D_wolf = abs(C * wolf_pos - glob_pos);
        X = wolf_pos - A * D_wolf;
    end % get_new_position END

end % gray_wolf_opt END