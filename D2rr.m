function df = D2rr(fun,r,s)
% function df = D2rr(fun,r,s)

EPS = 1e-6;
EPS = 1e-2;
dr = EPS*r;
df = (fun(r+dr,s)-2*fun(r,s)+fun(r-dr,s))./(dr.^2);

