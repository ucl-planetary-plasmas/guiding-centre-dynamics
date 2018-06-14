function c = getMFc(s,mftype,Req)
% function c = getMFc(s,mftype,Req)

%
% $Id: getMFc.m,v 1.12 2018/06/14 14:48:22 patrick Exp $
%
% Copyright (c) 2018 Patrick Guio <patrick.guio@gmail.com>
% All Rights Reserved.
%
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by the
% Free Software Foundation; either version 3 of the License, or (at your
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
% Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.

opts = {'spline', 'spline'};
%opts = {'cubic', 'cubic'}; % for regular grid only
opts = {'makima', 'makima'};

switch lower(mftype),

  case {'d','dip','dipole'},

    afun = s.dip.a;
    As = s.MD.v2d.alphadip;
    Br = s.dip.Br;
    Bt = s.dip.Bt;

	case {'m','md','mdisc'},

    afun = s.md.a;
    As = s.MD.v2d.alpha;
    Br = s.md.Br;
    Bt = s.md.Bt;

  otherwise

    error('magnetic field type mftype not recognised',mftype)

end
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

% length
c.nr = length(mu);

% contour function of mu
c.r = griddedInterpolant(mu,r,opts{:});

% regular grid in theta
c.tmn = asin(c.mn);
c.tmx = asin(c.mx);

% regular grid in latitude odd number to catch zero latitude
c.nrt = 2*fix(c.nr/16)+1;
ti = linspace(c.tmn,c.tmx,c.nrt);
si = sin(ti);
ri = c.r(si);
%c.rt = griddedInterpolant(ti,rsi,opts{:});
c.rt = griddedInterpolant(ti,ds(ti,ri),opts{:});

%c.drt = griddedInterpolant(ti,Dct(c.rt,ti),opts{:});
%c.drt = griddedInterpolant(ti,ds(ti,Dct(c.rt,ti)),opts{:});
% dr/dt = -r Br/Bt more robust
ri = c.rt(ti);
bri = Br(ri,si);
bti = Bt(ri,si);
dri = -ri.*bri./bti;
c.drt = griddedInterpolant(ti,dri,opts{:});

%c.d2rtt = griddedInterpolant(ti,Dctt(c.rt,ti),opts{:});
%c.d2rtt = griddedInterpolant(ti,Dct(c.drt,ti),opts{:});
%c.d2rtt = griddedInterpolant(ti,ds(ti,Dct(c.drt,ti)),opts{:});
% d2r/dt2 = -r (-Br^2 + dBr/dt Bt - Br dBt/dt)/Bt^2
dbri = D2t(Br,ri,si);
dbti = D2t(Bt,ri,si);
d2rri = -ri.*(-bri.^2+dbri.*bti-bri.*dbti)./bti.^2;
c.d2rtt = griddedInterpolant(ti,d2rri,opts{:});


% curvature
c.kappa = griddedInterpolant(ti,Kappa(s,c,ti),opts{:});

return

subplot(311), plot(ti,c.rt(ti),ti,c.r(sin(ti)))
subplot(312), plot(ti,c.rt(ti)-c.r(sin(ti)))
subplot(313), plot(ti,c.kappa(ti))
pause

end
