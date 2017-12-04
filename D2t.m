function df = D2t(fun,r,s)
% function df = D2t(fun,r,s)

EPS = 1e-6;
EPS = 1e-1;

% if s = sin(t)
ds = EPS*s;
ds(s==0) = EPS;
df = (fun(r,s+ds)-fun(r,s-ds))./(2*ds).*sqrt(1-s.^2);

return

% if s = lat
m = sin(s);
dm = EPS*m;
dm(m==0) = EPS;
df1 = (fun(r,m+dm)-fun(r,m-dm))./(2*dm).*cos(s);


plot(s,df,s,df1),
title('D2t')
pause


