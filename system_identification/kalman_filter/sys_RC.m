function [ sys ] = sys_RC

% RC filter model
R_1 = 13.33;
C_1 = 0.0003;

A = -1/(R_1*C_1);
B = 1/(R_1*C_1);
C = 1;
D = 0;
E = B;
n = size(E);
sys = ss(A,[B E],C,[D zeros(1,n(2))]);