clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% declare system
% dx(t)/dt = Ax(t) +Bu(t) +Iw(t)
%     y(t) = Cx(t) +v(t)
[ sys ] = sys_RC;
% [ sys ] = sys_RLC;
% [ sys ] = sys_motor;

% discrete-time model equivalent
% x(k+1) = Fx(k) +Gu(k) +Jw(k)
%   z(k) = Hx(k) +v(k)
T        = 1/2000;
sysd     = c2d( sys,T,'zoh' );

% define input and disturbance signals
Tf    = 0.08;
[u,t] = gensig('square',Tf/2,Tf,T);         % input and time
q     = 0.2^2;                              % variance of process
r     = 0.4^2;                              % variance of measurement
w     = q*randn(length(t),length(sys.A));   % gaussian noise with covariance Q
v     = r*randn(length(t),1);               % gaussian noise with variance R

% simulate system WITH process and measurement NOISES
[z,t,x_] = lsim( sysd, [u w], t );
z        = z +v;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% KALMAN FILTER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimal gain design
x_0 = 1*ones( length(sys.A),1 );            % initial condition
P_0 = diag( ones( length(sys.A),1 ) );      % initial covariance
[ x, y, K ] = kalman_filter( sysd, u, z, t, x_0, P_0, r, q );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation results
[y_o,t_o,x_o] = lsim( sysd, [u 0*w], t);    % real system for comparison

for k = 1:length(sys.A)
    figure(k)
    plot(t,x_o(:,k),'k','linewidth',2); hold on;
    plot(t,x_(:,k),'bo:','linewidth',2); 
    stairs(t,x(:,k),'r','linewidth',1.5);
    xlabel('Time (s)'); ylabel('Amplitude'); title(['State x_' num2str(k) '(t)']); grid on;
    legend('real','measured','estimated');
end

figure(k+1)
plot(t,y_o,'k','linewidth',2); hold on;
plot(t,z,'bo:','linewidth',2);
stairs(t,y,'r','linewidth',1.5);
xlabel('Time (s)'); ylabel('Amplitude'); title('Output y(t)'); grid on;
legend('real','measured','estimated');