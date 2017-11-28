function lc = getLC(s,mftype,c)

switch lower(mftype),
  case {'d','dip','dipole'},
	  lc = asin(sqrt(s.dip.B(c.rt(0),sin(0))/s.dip.B(c.rt(c.tmx),c.mx)));
  case {'m','md','mdisc'},
	  lc = asin(sqrt(s.md.B(c.rt(0),sin(0))/s.md.B(c.rt(c.tmx),c.mx)));
  otherwise
    error('magnetic field type mftype not recognised',mftype)
end
