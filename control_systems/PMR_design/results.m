function [ r, v_o_l, i_o_l, v_o_nl, i_o_nl, t ] = results( V, f, pmr_tf, cl_tf, id_tf, nld ) 

fs = 10000;        % sampling frequency
dt = 1/fs;         % seconds per sample
Tf = 0.10;         % simulation time
t  = 0:dt:Tf-dt;   % time vector

% response to sine wave input
r      = V*sqrt(2)*sin( 2*pi*f*t );
[y1,t] = lsim( cl_tf,r,t );

% response to disturbance input
i1  =  nld.I_1*sqrt(2)*sin( 2*pi*f*t );
i3  = -nld.I_3*sqrt(2)*sin( 3*2*pi*f*t );
i5  =  nld.I_5*sqrt(2)*sin( 5*2*pi*f*t );
i7  = -nld.I_7*sqrt(2)*sin( 7*2*pi*f*t );
i9  =  nld.I_9*sqrt(2)*sin( 9*2*pi*f*t );
i11 = -nld.I_11*sqrt(2)*sin( 11*2*pi*f*t );
[y3,t]  = lsim( id_tf,i3,t );
[y5,t]  = lsim( id_tf,i5,t );
[y7,t]  = lsim( id_tf,i7,t );
[y9,t]  = lsim( id_tf,i9,t );
[y11,t] = lsim( id_tf,i11,t );

% output voltage and current for linear load
v_o_l  = y1;
i_o_l  = i1;

% output voltage and current for non-linear load
v_o_nl = y1 +y3 +y5 +y7 +y9 +y11;
i_o_nl = i1 +i3 +i5 +i7 +i9 +i11;

% plot reference and output for linear load
figure(1)
plot(t,r,t,v_o_l,t,i_o_l)
legend('r(t) [V]','v_o(t) [V]','i_o(t) [A]');
xlabel('Time (s)'); ylabel('Amplitude');
title('Linear load');

% plot reference and output for non-linear load
figure(2)
plot(t,r,t,v_o_nl,t,i_o_nl)
legend('r(t) [V]','v_o(t) [V]','i_o(t) [A]');
xlabel('Time (s)'); ylabel('Amplitude');
title('Non-linear load');

% PMR controller frequency response
figure(3)
opts = bodeoptions('cstprefs');
opts.PhaseWrapping = 'on';
bodeplot(pmr_tf,opts)
title('C(s)');

% closed-loop frequency response
figure(4)
bodeplot(cl_tf,opts)
title('T_r(s)');

% disturbance-output frequency response
figure(5)
bodeplot(id_tf,opts)
title('T_{id}(s)');