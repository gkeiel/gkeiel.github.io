clc; clear; close all;

% declare system
% dx(t) = Ax(t) +Bu(t) +Iw(t)
%  y(t) = Cx(t) +v(t)
[ sys ] = sys_model;

% discrete-time model equivalent
% x(k+1) = Fx(k) +Gu(k) +Jw(k)
%   z(k) = Hx(k) +v(k)
T        = 1/10000;
sysd     = c2d( sys,T,'zoh' );

% define input and disturbance signals
Tf    = 0.02;
[u,t] = gensig('pulse',T,Tf,T);
Q     = 100;
R     = 0.5;
w     = Q*randn(length(t),length(sys.A));
v     = R*randn(length(t),1);

% simulate system with process and measurement noise
[z,t,x_] = lsim( sysd, [u w], t );
z        = z +v;
     
% optimal gain design
x_0 = ones( length(sys.A),1 );          % initial condition
P_0 = diag( ones( length(sys.A),1 ) );  % initial P
[ x, y, K ] = kalman_filter_function( sysd, u, z, t, x_0, P_0, R, Q );

% simulation results
results