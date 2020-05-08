function [ K, lamb_E ] = moore_method( A, B, lamb_T )

n = length(A);
W = ones( 1,n ); % particular entry vector for SISO problem
I = eye( n );
V = [];

for i = 1:n
    V = [V ( lamb_T(i)*I-A )\B]; % for i_th eigenvalue v_i = inv(lamb_i*I-A)*B
end
    
K = W/V;
lamb_E = eig( A+B*K );