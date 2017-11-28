function df = D1tt(fun,t)
% function df = D1tt(fun,t)

EPS = 1e-6;
EPS = 1e-1;
m = sin(t);
dm = EPS*m;
df = (fun(m+dm)-2*fun(m)+fun(m-dm))./(dm.^2).*cos(t).^2 - ...
     (fun(m+dm)-fun(m-dm))./(2*dm).*cos(t).*m;


