function lc = getLC(s,c)
% function lc = getLC(s,c)

switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;

  case {'m','md','mdisc'},

    B = s.md.B;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

lc = asin(sqrt(B(c.rt(0),0)/B(c.rt(c.tmx),c.mx)));
