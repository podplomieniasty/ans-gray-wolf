%
%   Aktualnie w tej funkcji znajduje sie wszystko
%   żeby zobaczyć jak kod działa i czy działa tak
%   jak autor zamierzył
%   status: działa
%

clc; clear;

% uruchomienie aplikacji
run("app.mlapp");


% clc
% clear
% 
% % DANE OD TWORCY
% fun = @F7; % funkcja celu do optymalizacji
% agents_num = 30;
% iterations = 1000;
% lb=-600; 
% ub=600;
% dim=100;
% [best_score, best_pos, convergence_plot] = gray_wolf_opt(fun, dim, lb, ub, agents_num, iterations);
% display(['best score:', num2str(best_score)]);
% display(['best pos:', num2str(best_pos)]);
% 
% % od tworcow
% % zgadza sie, ukradlem
% % ale tylko glupi by nie skorzystal
% % trzeba bylo pilnowac 
% 
% %Draw objective space
% figure('Position',[500 500 660 290])
% %Draw search space
% subplot(1,2,1);
% x = -10:0.1:10
% y = x;
% l = length(x)
% for i = 1:l
%     for j=1:l
%         z(i,j) = fun([x(i), y(j)]);
%     end
% end
% surfc(x,y,z, 'LineStyle', 'none');
% title('Parameter space')
% xlabel('x_1');
% ylabel('x_2');
% zlabel(['Funkszjon','( x_1 , x_2 )'])
% 
% subplot(1,2,2);
% semilogy(convergence_plot,'Color','r')
% title('Objective space')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
% 
% axis tight
% grid on
% box on
% legend('GWO')
% 
% 
% % TESTOWA FUNKCJA Z PRZYKLADU OD TWORCOW
% function o = F7(x)
%     F2 = 1;
%     one = 0;
%     two = 1;
%     for i = 1:length(x)
%         one = one + (x(i)^2/4000);
%         two = two * (cos(x(i)/sqrt(i)));
%     end
%     o = F2 + one + two;
% end

