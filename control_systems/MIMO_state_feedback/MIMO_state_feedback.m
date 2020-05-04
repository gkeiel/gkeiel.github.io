clc; clear;

% declare MIMO system
A = [1  0 -2;
     0 -1  0;
     0 -3  3];
B = [0  1;
     1  0;
     2  0];
C = [1  0  0];

lamb_A = eig(A);     % eigenvalues of A
lamb_T = [-2 -3 -4]; % desired closed-loop eigenvalues

% Moore method
[ K, lamb_E ] = moore_method( A, B, lamb_T );

% cyclic method
[ K, lamb_E ] = moore_method( A, B, lamb_T );

% print result
fprintf('K =\n');
fprintf('%s \n', sprintf([repmat(' %.2f  ', 1,size(K,2)) '\n'],K));
fprintf('eigenvalues = [ %s] \n', sprintf('%.2f ', lamb_E));