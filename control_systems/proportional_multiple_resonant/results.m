function [y] = results( V, f, pmr_tf, cl_tf ) 

fs = 10000;        % sampling frequency
dt = 1/fs;         % seconds per sample
Tf = 0.06;         % simulation time
t  = 0:dt:Tf-dt;   % time vector

% response to sine wave input
r     = V*sqrt(2)*sin( 2*pi*f*t );
[y,t] = lsim( cl_tf,r,t );

% plot reference and output
figure(1)
plot(t,r,t,y)
legend('r(t)','y(t)');
xlabel('Time (s)'); ylabel('Amplitude (V)');

% PMR frequency response
figure(2)
opts = bodeoptions('cstprefs');
opts.PhaseWrapping = 'on';          % needed for old versions
bodeplot(pmr_tf,opts)