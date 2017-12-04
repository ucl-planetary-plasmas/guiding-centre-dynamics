function k = Kappa(t,c)

r = c.rt(t);
dr = c.drt(t);
d2rr = c.d2rtt(t);

k = abs(r.^2+2*dr.^2-r.*d2rr)./(r.^2+dr.^2).^1.5;

