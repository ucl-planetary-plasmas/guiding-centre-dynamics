function I = OmegaOverPhia(mftype,r,beta)

switch lower(mftype),

  case {'d','dip','dipole'},
 
  %I = (0.35+0.15*sin(beta));
  I = (0.347714+0.152138*sin(beta));

  case {'m','md','mdisc'},

  I = r.*(0.40-0.06*sin(beta)+0.04.*r.*sin(beta));

  otherwise

    error('magnetic field type mftype not recognised',mftype)

end


