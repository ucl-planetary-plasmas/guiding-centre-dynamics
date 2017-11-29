function df = Dct(fun,t)
% function df = Dct(fun,t)

EPS = 1e-6;
EPS = 1e-1;
dt = EPS*t;
dt(t==0) = EPS;
df = (fun(t+dt)-fun(t-dt))./(2*dt);


