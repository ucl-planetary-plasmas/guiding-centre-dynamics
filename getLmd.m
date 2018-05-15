function Lmd = getLmd(s,L)

%opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
%opts = {'makima','extrap'};
opts = {'makima'};

%tic
% potential profile alpha for dipole at equator sampled at L
adipL = interp2(s.MD.c2d.r,s.MD.c2d.mu,s.MD.v2d.alphadip,L,zeros(size(L)));

% highly sampled equatorial distances
Li = linspace(s.MD.dims.r(1),s.MD.dims.r(end),s.MD.param.nr);
% potential profile alpha for mdisc at equator highly sampled
aLi = interp2(s.MD.c2d.r,s.MD.c2d.mu,s.MD.v2d.alpha,Li,zeros(size(Li)));

Lmd = zeros(size(L));
% inverse mapping 
% given Li(aLi) for mdisc, interpolate Lmd for value of dipole alpha at L
Lmd = interp1(aLi,Li,adipL,opts{:});
%toc

return

tic
Lmd1 = zeros(size(L));
for i=1:length(L),
  % find the corresponding potential at the surface for the dipole
  alpha0 = s.dip.a(1.0, sin(acos(sqrt(1/L(i)))));
  C = contourc(s.MD.dims.r,s.MD.dims.mu,s.MD.v2d.alpha,[alpha0,alpha0]);
  % extracts contour parameters
  level = C(1,1);
  npts = C(2,1);
  % parameterisation in r and mu of the L-shell
  r = C(1,2:end);
  mu = C(2,2:end);
  % sort mus
  [mu,I] = sort(mu);
  r = r(I);
	% interpolate at mu = 0
  Lmd1(i) = interp1(mu, r, 0);
end
toc

clf
subplot(211), plot(L,Lmd,L,Lmd)
subplot(212), plot(L,Lmd-Lmd1)
pause
