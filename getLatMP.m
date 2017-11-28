function lmp = getLatMP(s,c,aeq)

opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
%opts = {'makima','extrap'};

t = linspace(0,c.tmx,200);
sint = sin(t);
switch lower(c.type),

  case {'d','dip','dipole'},
    sina = sqrt(s.dip.B(c.rt(0),sin(0))./s.dip.B(c.rt(t),sint));

  case {'m','md','mdisc'},
    sina = sqrt(s.md.B(c.rt(0),sin(0))./s.md.B(c.rt(t),sint));

  otherwise
    error('magnetic field type c.type not recognised',c.type)
end

lmp = asin(interp1(sina,sint,sin(aeq),opts{:}));
