function df = Dctt(fun,t)
% function df = Dctt(fun,t)

EPS = 1e-6;
EPS = 1e-1;
dt = EPS*t;
dt(t==0) = EPS;
df = (fun(t+dt)-2*fun(t)+fun(t-dt))./(dt.^2);


