function [ agm ] = agm_model( ups, pmr, m )

% extract UPS model
A = ups.A;
B = ups.B;
C = ups.C;

% extract PMR model
A_r = pmr.A_r;
B_r = pmr.B_r;

% augmented model
A_a = [];
B_k = [];
B_a = [ B; zeros(2*m,1) ];
C_a = [ C  zeros(1,2*m) ]; 
D_a = 0;

for i = 1:m 
    
    n = 2*i-1;
    if i == 1
        A_a = [ A zeros(2,2*m) ];
        B_k = B;
    end
    aux = [ -[ 0; 1 ]*C  zeros(2,n-1)  A_r(n:n+1,n:n+1) zeros(2,2*(m-i)) ];
    A_a = [ A_a; aux];
    aux = [ 0; 1 ];
    B_k = [ B_k; aux];
end

agm = struct('A_a', A_a, 'B_a',B_a, 'C_a',C_a, 'D_a',D_a, 'B_k',B_k);