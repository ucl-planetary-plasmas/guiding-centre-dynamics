function k = Kappad(L,t)

k = 1.5/L*abs(cos(t).^2.*(-3+cos(2*t)))./ ...
     (cos(t).^2.*(cos(t).^2+4*sin(t).^2)).^1.5;

return

r = L*cos(t).^2;
dr = -2*L*cos(t).*sin(t);
d2rr = -2*L*(cos(t).^2-sin(t).^2);

k1 = abs(r.^2+2*dr.^2-r.*d2rr)./(r.^2+dr.^2).^1.5;

plot(t,k,t,k1),
legend({'\kappa','\kappa1'})
pause

