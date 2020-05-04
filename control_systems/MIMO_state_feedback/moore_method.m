function [ K, lamb_E ] = moore_method( A, B, lamb_T )

n = length( B );
w_i = ones( size(B,2),1 ); % chosen entry direction vector
I = eye( n );
V = [];
W = [];

for i = 1:n
    V = [V ( lamb_T(i)*I-A )\B*w_i]; % for each i_th eigenvalue v_i = inv(lamb_i*I-A)*B*w_i
    W = [W w_i];                     % for each i_th eigenvalue a direction w_i
end

% since w_i could be different then v_i are not unique, impacting on system dynamics
K = W/V;    % calculate (not-unique) gain matrix
lamb_E = eig( A+B*K );