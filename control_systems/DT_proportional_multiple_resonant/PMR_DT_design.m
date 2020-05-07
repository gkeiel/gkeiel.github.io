% 05/04/2020 Keiel
clc; clear; close all;

% design parameters (ex: m = 3; xi_3_5 = 0.001; sig = 200;)
m   = input('number of resonant modes: ');
xi  = input('damping factor in harmonics modes: ');
sig = input('poles minimum real part constraint: ');

% UPS parameters
V   = 127;       % reference RMS voltage
f   = 50;        % reference frequency
fs  = 20000;     % sampling frequency
R_L = 6.58;      % resistor of non-linear load 

% import discrete-time UPS model, PMR and build augmented model
[ ups ] = ups_dt_model( R_L, fs );
[ pmr ] = pmr_dt_model( f, m, xi, fs );
[ agm ] = agm_dt_model( ups, pmr, m );

% solve LMI problem for state-feedback gains
[ K ] = lmi_dt_pole( agm, sig, fs );

% PMR controller and closed-loop discrete-time transfer functions
[ pmr_tf, cl_tf, id_tf ] = get_dt_tf( pmr, agm, K, m, fs );

% plot simulated output and frequency responses
[ r, v_o, i_o, t ] = results( V, f, pmr_tf, cl_tf, id_tf, R_L, fs  );