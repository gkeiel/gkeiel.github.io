function [ pmr_tf, cl_tf ] = get_tf( pmr, agm, K ) 

% PMR controller and closed-loop system
[num,den] = ss2tf( pmr.A_r,pmr.B_r,K(3:end),-K(2) );
pmr_tf    = tf(num,den);
[num,den] = ss2tf( agm.A_a +agm.B_a*K, agm.B_k, agm.C_a, agm.D_a );
cl_tf     = tf(num,den);
