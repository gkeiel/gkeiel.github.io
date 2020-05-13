function [ ups ] = ups_dt_model( R_L, fs ) 

% UPS parameters
Kpwm = 1;
Rlf  = 0.2;
Lf   = 0.001;
Cf   = 0.00002;

% UPS model
Ac = [-(Rlf/Lf) -1/Lf;
      1/Cf     -1/(R_L*Cf)];
Bc = [Kpwm/Lf; 0];
Cc = [0 1];
Dc = 0;
Ec = [0;  -1/Cf];

% UPS discrete-time model (Euler-forward discretization)
T = 1/fs;
I = eye(2);
A = I +T*Ac;
B = T*Bc;
C = Cc;
D = Dc;
E = T*Ec;

ups = struct('A',A, 'B',B, 'C',C, 'D',D, 'E',E);