function [ K, lamb_T ] = output_feedback_solver( A, B, C )

[m,n] = size(B);

% declare variable matrices
X     = sdpvar(m,m,'symmetric');
Y     = sdpvar(n,n);              
M     = sdpvar(n,n);              

% declare LMI
LMIS = X>0;
LMIS = [LMIS, (X*A' +A*X +C'*Y'*B' +B*Y*C)<0];
LMIS = [LMIS, C*X==M*C];

% solver settings 
options                   = sdpsettings('solver','lmilab','verbose',2);
options.lmilab.maxiter    = 100;
options.lmilab.feasradius = 1e5;

% solve feasibility problem
solution = solvesdp(LMIS,[],options);
K        = double(Y)*double(M)^-1;
lamb_T   = eig( A+B*K*C );