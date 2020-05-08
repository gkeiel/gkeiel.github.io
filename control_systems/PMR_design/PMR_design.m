% 05/07/2020 Keiel
clc; clear; close all;

% design parameters (ex: m = 3; xi_3_5 = 0.001; sig = 200;)
m   = input('number of resonant modes: ');
xi  = input('damping factor in harmonics modes: ');
sig = input('poles minimum real part constraint: ');

% UPS parameters
V   = 127;       % reference RMS voltage
f   = 50;        % reference frequency
R_L = 6.58;      % resistor of non-linear load 

% import UPS model, PMR and build augmented model
[ ups ] = ups_model( R_L );
[ pmr ] = pmr_model( f, m, xi );
[ agm ] = agm_model( ups, pmr, m );

% compute state-feedback matrix K for pole assignment
eig_l = -sig*linspace(1,10*(m+2),2*m+2);
[ K ] = place(agm.A_a,-agm.B_a,eig_l)            % Kautsky's algorithm 
[ K,] = moore_method( agm.A_a,agm.B_a,eig_l )    % Moore's eigenstrucutre algorithm (SISO system)

% PMR controller and closed-loop transfer functions
[ pmr_tf, cl_tf, id_tf ] = get_tf( pmr, agm, K, m );

% plot simulated output and frequency responses
[ r, v_o_l, i_o_l, v_o_nl, i_o_nl, t ] = results( V, f, pmr_tf, cl_tf, id_tf, R_L  );