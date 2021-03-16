clc; clear;

% declare unstable SISO system
A = [5  1;
     1 -2];
B = [1; 0];
C = [1  0];
D = 0;

lamb_A = eig(A);      % eigenvalues of A

% stabilizing output feedback gain matrix
[ K, lamb_T ] = output_feedback_solver( A, B, C );

% print result
fprintf('open-loop eigenvalues   = [ %s] \n', sprintf('%.2f ', lamb_A));
fprintf('closed-loop eigenvalues = [ %s] \n', sprintf('%.2f ', lamb_T));
fprintf('K                       = [ %s] \n', sprintf('%.2f ', K));