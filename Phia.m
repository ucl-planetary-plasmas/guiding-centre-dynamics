function I = Phia(mftype,r,beta)


switch lower(mftype),

  case {'d','dip','dipole'},

  % From mathematica mdintegral.nb
  %I = 1.30587-0.580526*sin(beta);

	% From 2D fit 
  I = 1.28-0.55*sin(beta);

	case {'m','md','mdisc'},

  % From 2D fit
  I = 1.27-0.37*sin(beta)-0.05.*r.*sin(beta);

  otherwise

    error('magnetic field type mftype not recognised',mftype)

end


