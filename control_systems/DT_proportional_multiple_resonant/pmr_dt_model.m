function [ pmr ] = pmr_dt_model( f, m, xi, fs )

% resonant controller model
T  = 1/fs;
A_r = [];
B_r = [];
for i = 1:m
    
    w_n = 2*pi*f*(2*i -1);
    if ( i == 1 )
        A_aux = [0 w_n; -w_n 0];
    else
        A_aux = [0 w_n; -w_n -2*xi*w_n];  
    end
    B_aux = [0; 1];
   
    sys   = ss( A_aux,B_aux,[1 1],0 );
    opts  = c2dOptions('Method', 'zoh');
    sysd  = c2d(sys,T,opts);
    A_aux = sysd.a;
    B_aux = sysd.b;
    
    A_r = blkdiag( A_r,A_aux );
    B_r = [B_r; B_aux];
end

pmr = struct('A_r', A_r, 'B_r', B_r);