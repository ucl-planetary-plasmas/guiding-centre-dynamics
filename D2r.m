function df = D2r(fun,r,s)
% function df = D2r(fun,r,s)

EPS = 1e-6;
dr = EPS*r;
df = (fun(r+dr,s)-fun(r-dr,s))./(2*dr);


