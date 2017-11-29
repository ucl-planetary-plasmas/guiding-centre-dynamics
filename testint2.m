function [I1,I2]=testint2(s,c,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;

  case {'m','md','mdisc'},

    B = s.md.B;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

lm = getLatMP(s,c,beta);
Bm = B(c.rt(lm),sin(lm));

I1 = zeros(size(beta));
I2 = zeros(size(beta));
for i=1:length(beta),
  I1(i) = integral(@(t)f1(t,c),0,lm(i),opts{:});
  I2(i) = integral(@(t)f2(t,c),-lm(i),lm(i),opts{:});
end

function y=f1(t,c)
r = c.rt(t);
dr = c.drt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm).*sqrt(r.^2+dr.^2);
end

function y=f2(t,c)
r = c.rt(t);
dr = c.drt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm).*r;
end

end

