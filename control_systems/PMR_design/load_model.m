function [ nld ] = load_model( V,R_L ) 

% fundamental and disturbance current (non-linear load normalized current harmonics)
I_1  = V/R_L;
I_3  = 0.86*(V/R_L);
I_5  = 0.62*(V/R_L);
I_7  = 0.35*(V/R_L);
I_9  = 0.12*(V/R_L);
I_11 = 0.04*(V/R_L);

nld = struct('I_1',I_1, 'I_3',I_3, 'I_5',I_5, 'I_7',I_7, 'I_9',I_9, 'I_11',I_11);
% note: for DIFFERENT load one shall change MAGNITUDE and PHASE values to ones
% obtained from a LOAD CURRENT open-loop response to reference voltage.