function df = D2t(fun,r,t)
% function df = D2t(fun,r,t)

EPS = 1e-6;
EPS = 1e-1;
m = sin(t);
dm = EPS*m;
dm(m==0) = EPS;
df = (fun(r,m+dm)-fun(r,m+dm))./(2*dm).*cos(t);


