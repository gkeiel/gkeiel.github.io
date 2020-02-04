% gradient descent
clc; clear all; k = 0; i = 1; k_max = 20;
f = []; g = []; % to store F(x) and Gr(x) 

%%%%%%%%%%%%%%%%%%%%%%%%%%% entry of parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
ep = 1e-3;    % tolerance
x  = [1; 2];  % initial guess
alpha = 2e-1; % fixed step
F  = @(x1,x2) x1.^2 +2.*x2.^2 +x1.*x2 -6.*x1 -10.*x2; % objective function
Gr = @(x1,x2) [2*x1+x2-6; 4*x2+x1-10];                % analytical gradient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

show = @(k,x) fprintf('k = %2d: x = %-10s, F(x) = %.4f\n', k, mat2str(x,2), F(x(1),x(2)));
f(i)   = F(x(1),x(2));      % calculate objective for x_0
g(:,i) = Gr(x(1),x(2));     % calculate gradient for x_0
show(k,x);                  % show initial values

while ( k < k_max && abs(g(end)) > ep)
    k = k+1;
    i = k+1;
    d = -Gr(x(1),x(2));     % descent direction
    x = x +alpha*d;         % gradient descent 

    f(i) = F(x(1),x(2));    % calculate objective for x
    g(:,i) = Gr(x(1),x(2)); % calculate gradient for x
    show(k,x);              % show progress
end

plot(0:k, f, 'LineWidth',2.5, 'color','k'); grid on;
title('Objective Function'); xlabel('Iteration'); ylabel('F(x)');