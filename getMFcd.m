function c = getMFcd(s,mftype,Req)

opts = {'spline', 'spline'};
%opts = {'cubic', 'cubic'}; % for regular grid only
opts = {'makima', 'makima'};

afun = s.dip.a;
As = s.MD.v2d.alphadip;

Rs = s.MD.dims.r;
Ms = s.MD.dims.mu;
% get potential value of the L-shell
alpha = afun(Req,0);
% find isocontour of alpha, i.e. L-shell
C = contourc(Rs,Ms,As,[alpha,alpha]);

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
%[c.mn,c.mx]
c.mn = -sin(acos(sqrt(1/Req)));
c.mx = sin(acos(sqrt(1/Req)));
%[c.mn,c.mx]

% length
c.nr = length(mu);

% contour function of mu
c.r = griddedInterpolant(mu,r,opts{:});
c.r = griddedInterpolant(mu, Req*sin(acos(mu)).^2,opts{:});

% regular grid in theta
c.tmn = asin(c.mn);
c.tmx = asin(c.mx);

% regular grid in latitude odd number to catch zero latitude
c.nrt = 2*fix(c.nr/16)+1;
ti = linspace(c.tmn,c.tmx,c.nrt);
%c.rt = griddedInterpolant(ti,c.r(sin(ti)),opts{:});
c.rt = griddedInterpolant(ti,Req*cos(ti).^2,opts{:});

c.drt = griddedInterpolant(ti,ds(ti,Dct(c.rt,ti)),opts{:});
%c.drt = griddedInterpolant(ti,-2*Req*cos(ti).*sin(ti),opts{:});

%c.d2rtt = griddedInterpolant(ti,Dctt(c.rt,ti),opts{:});
c.d2rtt = griddedInterpolant(ti,ds(ti,Dct(c.drt,ti)),opts{:});
%c.d2rtt = griddedInterpolant(ti,-2*Req*(cos(ti).^2-sin(ti).^2),opts{:});

% curvature
c.kappa = griddedInterpolant(ti,Kappa(ti,c),opts{:});

return

subplot(311), plot(ti,c.rt(ti),ti,c.r(sin(ti)))
subplot(312), plot(ti,c.rt(ti)-c.r(sin(ti)))
subplot(313), plot(ti,c.kappa(ti))
pause

end
