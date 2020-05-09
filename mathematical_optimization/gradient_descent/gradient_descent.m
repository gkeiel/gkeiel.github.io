% gradient descent algorithm
clc; clear all; k = 1; k_max = 30;


%%%%%%%%%%%%%%%%%%%%%%%%%%% entry of parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
% tolerance, initial solution, size step
ep    = 1e-3;
x     = [1; 10];
alpha = 2e-1;

% objective function
F  = @(x1,x2) x1.^2 +2.*x2.^2 +x1.*x2 -6.*x1 -10.*x2;

% analytical gradient
Gr = @(x1,x2) [2*x1+x2-6; 4*x2+x1-10];


%%%%%%%%%%%%%%%%%%%%%%%%%%% gradient descent %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f(k) = F(x(1),x(2));        % evaluate objective for x_0
fprintf('k = %2d: x = %-10s| F(x) = %.4f\n', k, mat2str(x,2), f(k));

while( k<k_max && abs( max(Gr(x(1),x(2))) )>ep ) % maximum iterations or optimality stop criterion
    k = k+1;
    d = -Gr(x(1),x(2));     % descent direction
    x = x +alpha*d;         % gradient descent 

    f(k) = F(x(1),x(2));    % evaluate objective function
    fprintf('k = %2d: x = %-10s| F(x) = %.4f\n', k, mat2str(x,2), f(k));    % show progress
end

plot(0:k-1, f, 'LineWidth',2.5, 'color','k'); grid on;
title('Objective function evolution'); xlabel('Iteration'); ylabel('F(x)');