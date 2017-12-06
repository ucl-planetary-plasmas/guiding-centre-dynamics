function I = Phia(mftype,r,beta)


switch lower(mftype),

  case {'d','dip','dipole'},

  %I = r*(1.30-0.56*sin(beta));
  I = r.*(1.30587-0.580526*sin(beta));

	case {'m','md','mdisc'},

  I = r.*(1.27-0.37*sin(beta)-0.05.*r.*sin(beta));

  otherwise

    error('magnetic field type mftype not recognised',mftype)

end


