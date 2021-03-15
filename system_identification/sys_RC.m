function [ sys ] = sys_RC

% RC filter model
R_1 = 13.33;
C_1 = 0.0003;

A = -1/(R_1*C_1);
B = 1/(R_1*C_1);
C = 1;
D = 0;
I = 1/(R_1*C_1)*eye(length(B));
sys = ss(A,[B I],C,[D zeros(1,length(B))]);