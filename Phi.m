function I = Phi(s,c,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};
%opts = {'AbsTol',1e-6,'RelTol',1e-3};

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

lm = getLatMP(s,c,beta);
Bm = B(c.rt(lm),sin(lm));

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = integral(@(t)f(t,c,Bm(i)),0,lm(i),opts{:});
end

function y=f(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = (sqrt(((Br(r,st)./Bt(r,st)).^2+1)./(1-B(r,st)/Bm)).*r);
end

end

