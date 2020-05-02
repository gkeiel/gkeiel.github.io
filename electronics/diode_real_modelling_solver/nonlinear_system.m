function F = nonlinear_system(x, par)
E   = par(1);
R   = par(2);
I_S = par(3);
n   = par(4);
V_T = par(5);

F(1) = -x(1)/R               -x(2) +E/R;
F(2) = I_S*exp(x(1)/(n*V_T)) -x(2) -I_S;