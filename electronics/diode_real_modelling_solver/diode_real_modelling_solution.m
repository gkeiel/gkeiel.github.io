clc; clear all;

% constants of circuit with KVL: E -V_D -IR = 0
E = 10;
R = 100;

% diode parameters
I_S = 10*10^-12;
k   = 1.38*10^-23;
q   = 1.6*10^-19;
T_K = 273 +25;
n   = 1;
V_T = k*T_K/q;
par = [E; R; I_S; n; V_T];

% simplified model solution
V_D = 0.7;
I_D = (E -V_D)/R;

% real solution of both I_D = I_S*( exp(V_D/(n*V_T)) -1 ) and I_D = (E -V_D)/R;
f   = @(x) nonlinear_system(x, par);   % one can define another circuit equation inside function
x_0 = [.1, .1];                        % initial guess
options = optimset('Display','iter');
[x, fval] = fsolve(f, x_0, options);

% result comparison
fprintf('V_D using simplified model = %.3f V\n', V_D)
fprintf('I_D using simplified model = %.3f A\n', I_D)
fprintf('V_D using real model = %.3f V\n', x(1))
fprintf('I_D using real model = %.3f A\n', x(2))