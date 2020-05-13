clc; clear;

% declare system
% dx(t) = Ax(t) +Bu(t) +Ew(t)
%  y(t) = Cx(t) +v(t)
A = [-1 0;
     0  -10];
B = [1; 0];
C = [1  0];
D = 0;

% simulate measured system
Ts  = 0.01;
Tf  = 10;
t   = 0:Ts:Tf;
sys = ss(A,B,C,D);
h   = step( sys,t );
z   = h' +0.2*rand( 1,length(t) );

% discrete-time system equivalent
% x(k+1) = Fx(k) +Bu(k) +Gw(k)
%   z(k) = Hx(k) +v(k)
sysd = c2d( sys,Ts,'zoh' );
F = sysd.a;
B = sysd.b;
G = 0.1*ones( 2,1 );
H = sysd.c;

[ x ] = kalman_filter_function( F, G, H, B, Ts )

% state evolution
figure(1)
plot( x,t );
xlabel('time (s)'); ylabel('amplitude'); grid on;