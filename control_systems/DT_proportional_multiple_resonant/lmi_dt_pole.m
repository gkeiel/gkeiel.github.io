function [ K ] = lmi_dt_pole( agm, sig, fs )

% extract augmented model
A_a = agm.A_a;
B_a = agm.B_a;
C_a = agm.C_a; 

% regional pole placement LMI
[n,p] = size(B_a);
Q     = sdpvar(n,n, 'symmetric');   % n x n symmetric variable
W     = sdpvar(p,n);                % n x n variable

T     = 1/fs;
Sigma = A_a*Q +B_a*W;
r     = exp( -sig*T );


LMIS = Q>0;

LMIS = [ LMIS, ...
         ([-Q,     Sigma';...
           Sigma,  -Q]) <0 ];
     
LMIS = [ LMIS, ...
         ([-r*Q    Sigma';...
           Sigma   -r*Q]) <0 ];
     
% settings and solve
opt                   = sdpsettings('solver','lmilab','verbose',2);
opt.lmilab.maxiter    = 1000;
opt.lmilab.feasradius = 1e20;
solution              = solvesdp(LMIS,[],opt);

K = double(W)/double(Q);