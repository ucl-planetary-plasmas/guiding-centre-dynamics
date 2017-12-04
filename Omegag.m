function I = Omegag(s,c,beta)

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

EPS = 1e-10;
EPS = 0;

% zero at end point lm due to f1(lm) = 0
% f1(lm) can become pure imaginary
lm = getLatMP(s,c,beta)-EPS;
Bm = B(c.rt(lm),sin(lm));

% zr should be real near zero
zr = f1(lm,c,Bm);
for i=1:length(beta),
  if ~isreal(zr(i)),
    fprintf(1,'Omega-> lm=%f f1(lm,c,Bm)=(%f+i%f)\n',...
            lm,real(zr(i)),imag(zr(i)));
  end
end


I = zeros(size(beta));
for i=1:length(beta),
  %fprintf(1,'lm=%f\n', lm(i));
	t = linspace(0,lm(i),100); 
	BxdB = BxgradB(t,c,Br,Bt,B,Bm); BxdBd = BxgradBd(t,c.r0);
	clf, plot(t,BxdB,'-o',t,BxdBd), title('BxgradB'); pause
	clf, plot(t,f(t,c,Bm(i)),'-o'),title('\Omega_g'); pause
  I(i) = integral(@(t)f(t,c,Bm(i)),0,lm(i),opts{:},'Waypoints',lm(i));
end

function y=f(t,c,Bm)
r = c.rt(t);
dr = c.drt(t);
st = sin(t);
br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);
BxdB = BxgradB(t,c,Br,Bt,B,Bm);
y = BxdB./(b.^2.*Bm).*sqrt((1+(br./bt).^2)./(1-b/Bm))./cos(t)/3;
end

function y=f1(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm);

end

end
