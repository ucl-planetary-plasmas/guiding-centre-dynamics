function df = D1t(fun,t)
% function df = D1t(fun,t)

EPS = 1e-6;
EPS = 1e-2;
EPS = 1e-1;
m = sin(t);
dm = EPS*m;
df = (fun(m+dm)-fun(m-dm))./(2*dm).*cos(t);


