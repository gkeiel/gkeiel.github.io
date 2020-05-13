function [ x ] = kalman_filter_function( F, G, H, B, Ts )

n = length(F);
i = 1;
k = i+1;

% initialization
x = zeros( n,1 );                % initial conditions
P = diag( 10*ones( n,1 ) );     
R = var(V);                      % measure disturbance variance
Q = var(V);                      % state disturbance variance

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Kalman filter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n = Ts:Ts:100*Ts
    
    % 1. prediction
    x(:,k) = F*x(:,k-1) +B*u(k); % 'a priori' predicted state
    P      = F*P*F' +G*Q*G';     % 'a priori' predicted covariance

    % 2. update
    y(k)   = z(k) -H*x(:,k);     % measurement innovation
    S      = H'*P*H +R;          % covariance innovation
    K      = P*H'*inv(S);        % optimal gain
    
    x(:,k) = x(:,k) +K*y(k);     % 'a posteriori' estimate 
    P      = (I -K*H)*P;         % 'a posteriori' covariance
    y(k)   = z(k) -H*x(k)        % measurement residual

    k = k +1;
end