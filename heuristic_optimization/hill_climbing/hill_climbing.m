% hill climbing algorithm
clc; clear all; k = 1; k_max = 30;


%%%%%%%%%%%%%%%%%%%%%%%%%%% entry of parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial solution, number of neighbors solutions and their distance bound
x    = 1;
L    = 4;   
b    = 0.5;

% objective function
F = @(x) x.*sin( 10*pi.*x ) +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%% hill climbing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f(k) = F(x);                              % evaluate objective function for x_0
fprintf('k = %-2d: x = %.3f | F(x) = %.3f\n', k, x, f(k));

while( k<k_max )
    k = k+1;

    for aux  = 1:L
        x_j  = x +b*(1*rand(1,1) -0.5);   % random neighbor solution x_j

        if( F(x_j) < F(x) )
            x = x_j;                      % accepted solution
            fprintf('neighb: x = %.3f | F(x) = %.3f | new min\n', x, F(x));
        end
    end

    f(k) = F(x);        % evaluate objective function
    fprintf('k = %-2d: x = %.3f | F(x) = %.3f\n', k, x, f(k));    % show progress
end

plot(0:k-1, f, 'LineWidth',2.5, 'color','k'); grid on;
title('Objective function evolution'); xlabel('Iteration'); ylabel('F(x)');