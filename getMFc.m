function c = getMFc(s,mftype,Req)

opts = {'spline', 'spline'};
%opts = {'cubic', 'cubic'}; % for regular grid only
opts = {'makima', 'makima'};

% find potential value of the L-shell
switch lower(mftype),
  case {'d','dip','dipole'},
    alpha = s.dip.a(Req,0);
    % find isocontour of alpha, i.e. L-shell
    C = contourc(s.MD.dims.r,s.MD.dims.mu,s.MD.v2d.alphadip,[alpha,alpha]);
	case {'m','md','mdisc'},
	  alpha = s.md.a(Req,0);
    % find isocontour of alpha, i.e. L-shell
    C = contourc(s.MD.dims.r,s.MD.dims.mu,s.MD.v2d.alpha,[alpha,alpha]);
  otherwise
    error('magnetic field type mftype not recognised',mftype)
end

% extracts contour parameters
level = C(1,1);
npts = C(2,1);

% parameterisation in r and mu of the L-shell
r = C(1,2:end);
mu = C(2,2:end);

% sort mus
[mu,I] = sort(mu);
r = r(I);

% save Req and mftype
c.r0 = Req;
c.type = mftype;

% min and max values in mu
c.mn = min(mu);
c.mx = max(mu);

% contour function of mu
c.r = griddedInterpolant(mu,r,opts{:});

% regular grid in theta
c.tmn = asin(c.mn);
c.tmx = asin(c.mx);

% regular grid in latitude
ti = linspace(c.tmn,c.tmx,length(mu)/4);
c.rt = griddedInterpolant(ti,c.r(sin(ti)),opts{:});

return

subplot(211), plot(ti,c.rt(ti),ti,c.r(sin(ti)))
subplot(212), plot(ti,c.rt(ti)-c.r(sin(ti)))
pause
