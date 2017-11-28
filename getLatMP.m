function lmp = getLatMP(s,c,aeq)

opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
opts = {'makima','extrap'};

t = linspace(0,c.tmx,400);
sint = sin(t);
switch lower(c.type),

  case {'d','dip','dipole'},
    sina = sqrt(s.dip.B(c.rt(0),sin(0))./s.dip.B(c.rt(t),sint));
    myfun = @(t,a) s.dip.B(c.rt(0),0)-sin(a).^2.*s.dip.B(c.rt(t),sin(t));

  case {'m','md','mdisc'},
    sina = sqrt(s.md.B(c.rt(0),sin(0))./s.md.B(c.rt(t),sint));
    myfun = @(t,a) s.md.B(c.rt(0),0)-sin(a).^2.*s.md.B(c.rt(t),sin(t));

  otherwise
    error('magnetic field type c.type not recognised',c.type)
end

lmp = asin(interp1(sina,sint,sin(aeq),opts{:}));

% numerically
opts = optimset('fzero');
%opts = optimset('fminbnd'); opts.TolX=1e-12;
lmp1 = zeros(size(aeq));
for i=1:length(aeq),
  tmax = getLC(s,c)+eps;
	lmp1(i) = fzero(@(x) myfun(x,aeq(i)),0.8*tmax,opts);
	%lmp1(i) = fminbnd(@(x) myfun(x,aeq(i)),0,tmax,opts);
end
lmp
lmp1
pause
