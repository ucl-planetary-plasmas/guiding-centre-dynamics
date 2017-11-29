function lc = getLC(s,c)
% function lc = getLC(s,c)

switch lower(c.type),

  case {'d','dip','dipole'},

	  lc = asin(sqrt(s.dip.B(c.rt(0),0)/s.dip.B(c.rt(c.tmx),c.mx)));

  case {'m','md','mdisc'},

	  lc = asin(sqrt(s.md.B(c.rt(0),0)/s.md.B(c.rt(c.tmx),c.mx)));

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end
