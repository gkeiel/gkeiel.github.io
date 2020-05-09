clc; clear;

% declare SISO system
A = [0  1  0  0;
     0  0 -1  0;
     0  0  0  1;
     0  0  5  0]; 
B = [0; 1; 0; 2];
C = [1  0  0  0];

lamb_A = eig(A);            % eigenvalues of A
lamb_T = [-10 -20 -30 -40]; % desired closed-loop eigenvalues

% Moore method
[ K, lamb_E ] = moore_method( A, B, lamb_T );

% print result
fprintf('K           = [ %s] \n', sprintf('%.2f ', K));
fprintf('eigenvalues = [ %s] \n', sprintf('%.2f ', lamb_E));