% simulated annealing algorithm
clc; clear all; k = 1; k_max = 40;


%%%%%%%%%%%%%%%%%%%%%%%%%%% entry of parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial solution, number of neighbors and temperature decay rate
x    = 2;
n    = 4;
beta = 0.95;

% initial temperature
T = 0.7;                 

% objective function
F = @(x) x.*sin( 10*pi.*x ) +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%% simulated annealing %%%%%%%%%%%%%%%%%%%%%%%%%%%
f(k) = F(x);                                  % evaluate objective function for x_0
fprintf('k = %-2d: x = %.3f | F(x) = %.3f | T = %.2f\n', k, x, f(k), T);

while( k<k_max )
    k = k+1;

    for aux  = 1:n
        x_j  = x +(1*rand(1,1) -0.5);     % neighbor solution x_j

        % if objective function lower else go thorught probab. acceptance
        if( F(x_j) < F(x) )
            x = x_j;                      % new solution
            fprintf('neighb: x = %.3f | F(x) = %.3f | new min\n', x, F(x));
        else
            pb = exp( (F(x)-F(x_j))/T );  % probability threshold        
            if( rand(1,1) < pb )
                x = x_j;                  % new solution (not best but accepted)
                fprintf('neighb: x = %.3f | prob. = %.2f |\n', x, pb); 
            end
        end
    end

    f(k) = F(x);        % evaluate objective function
    n    = 1*n;         % update number of neighbor (constant)
    T    = beta*T;      % update temperature
    fprintf('k = %-2d: x = %.3f | F(x) = %.3f | T = %.2f\n', k, x, f(k), T);    % show progress
end

plot(0:k-1, f, 'LineWidth',2.5, 'color','k'); grid on;
title('Objective function evolution'); xlabel('Iteration'); ylabel('F(x)');