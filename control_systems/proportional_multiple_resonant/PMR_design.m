% 05/01/2020 Keiel
clc; clear all; close all;

% design parameters (ex: m = 3; xi_3_5 = 0.001; sig = 250;)
m   = input('number of resonant modes: ');
xi  = input('damping factor in harmonics: ');
sig = input('poles minimum real part constraint: ');

% UPS nominal parameters
V   = 127;       % reference RMS voltage
f   = 50;        % reference frequency
R_L = 6.58;      % resistive load

% load UPS model, PMR structure and build augmented model
[ ups ] = ups_model( R_L );
[ pmr ] = pmr_model( f, m, xi );
[ agm ] = agm_model( ups, pmr, m );

% solve LMI problem for state-feedback gain K
[ K ] = lmi_pole( agm, sig );

% PMR controller and closed-loop system
[ pmr_tf, cl_tf ] = get_tf( pmr, agm, K );

% output voltage plot and controller bode plot
[ y ] = results( V, f, pmr_tf, cl_tf  );