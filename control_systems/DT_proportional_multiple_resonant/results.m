function [ r, v_o, i_o, t ] = results( V, f, pmr_tf, cl_tf, id_tf, R_L, fs ) 

dt = 1/fs;         % seconds per sample
Tf = 0.10;         % simulation time
t  = 0:dt:Tf-dt;   % time vector

% discrete-time response to sine wave input
r      = V*sqrt(2)*sin( 2*pi*f*t );
[y1,t] = lsim( cl_tf,r,t );

% disturbance current (non-linear load current MAGNITUDE and PHASE harmonics)
% note: obtained from open-loop response to reference voltage.
I_1  = V/R_L;
I_3  = 0.86*(V/R_L);
I_5  = 0.62*(V/R_L);
I_7  = 0.35*(V/R_L);
I_9  = 0.12*(V/R_L);
I_11 = 0.04*(V/R_L);
i1  =  I_1*sqrt(2)*sin( 2*pi*f*t );
i3  = -I_3*sqrt(2)*sin( 3*2*pi*f*t );
i5  =  I_5*sqrt(2)*sin( 5*2*pi*f*t );
i7  = -I_7*sqrt(2)*sin( 7*2*pi*f*t );
i9  =  I_9*sqrt(2)*sin( 9*2*pi*f*t );
i11 = -I_11*sqrt(2)*sin( 11*2*pi*f*t );

% discrete-time response to disturbance input
[y3,t]  = lsim( id_tf,i3,t );
[y5,t]  = lsim( id_tf,i5,t );
[y7,t]  = lsim( id_tf,i7,t );
[y9,t]  = lsim( id_tf,i9,t );
[y11,t] = lsim( id_tf,i11,t );

% output voltage and current
v_o     = y1 +y3 +y5 +y7 +y9 +y11;
i_o     = i1 +i3 +i5 +i7 +i9 +i11;

% plot reference and output
figure(1)
stairs(t,r,'b');
hold on;
stairs(t,v_o,'r');
stairs(t,i_o,'g');
legend('r(kT) [V]','v_o(kT) [V]','i_o(kT) [A]');
xlabel('Time (s)'); ylabel('Amplitude');

% PMR controller frequency response
figure(2)
opts = bodeoptions('cstprefs');
opts.PhaseWrapping = 'on';          % needed for old versions
bodeplot(pmr_tf,opts)
title('C(z)');

% closed-loop frequency response
figure(3)
bodeplot(cl_tf,opts)
title('T_r(z)');

% disturbance-output frequency response
figure(4)
bodeplot(id_tf,opts)
title('T_{id}(z)');

% closed-loop transfer function poles
figure(5)
pzmap(cl_tf)
title('T_r(z) poles and zeros');