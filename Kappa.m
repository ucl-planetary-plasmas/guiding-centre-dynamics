function k = Kappa(s,c,t)


switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;
    Br = s.dip.Br;
    Bt = s.dip.Bt;

  case {'m','md','mdisc'},

    B = s.md.B;
    Br = s.md.Br;
    Bt = s.md.Bt;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

r = c.rt(t);
st = sin(t);
br = Br(r,st);
bt = Bt(r,st);
dbr = D2t(Br,r,st);
dbt = D2t(Bt,r,st);
% dr/dt = -r Br/Bt
dr = -r.*br./bt;
% d2r/dt2 = -r (-Br^2 + dBr/dt Bt - Br dBt/dt)/Bt^2
d2rr = -r.*(-br.^2+dbr.*bt-br.*dbt)./bt.^2;

k = curvature(r,dr,d2rr);

% alternative less robust
dr1 = c.drt(t);
d2rr1 = c.d2rtt(t);
k1 = curvature(r,dr1,d2rr1);

subplot(311), plot(t,dr,t,dr1)
title('dr/dt')
subplot(312), plot(t,d2rr,t,d2rr1)
title('d2r/dt2')
subplot(313), plot(t,k,t,k1);
title('Kappa')
pause

function kappa = curvature(r,dr,d2rr)

kappa = abs(r.^2+2*dr.^2-r.*d2rr)./(r.^2+dr.^2).^1.5;
