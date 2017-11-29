function lmp = getLatMP(s,c,aeq)

opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
opts = {'makima','extrap'};

t = linspace(0,c.tmx,c.nrt);
st = sin(t);
switch lower(c.type),

  case {'d','dip','dipole'},

	  B = s.dip.B;

  case {'m','md','mdisc'},

	  B = s.md.B;

  otherwise
    error('magnetic field type c.type not recognised',c.type)
end

% create ratio sqrt(Beq/B) as function of latitude
sina = sqrt(B(c.rt(0),sin(0))./B(c.rt(t),st));

% inverse mapping: find the value of latitude where sqrt(Beq/B)=sin(aeq)
lmp = asin(interp1(sina,st,sin(aeq),opts{:}));

% numerically improve solution
%fun = @(t,a) B(c.rt(0),0)-sin(a).^2.*B(c.rt(t),sin(t));
fun = @(t,a) sqrt(B(c.rt(0),0))-sin(a).*sqrt(B(c.rt(t),sin(t)));
opts = optimset('fzero');
lmp1 = zeros(size(aeq));
for i=1:length(aeq),
	lmp(i) = fzero(@(x) fun(x,aeq(i)),lmp(i),opts);
end

return
lmp
lmp1
lmp-lmp1
pause
