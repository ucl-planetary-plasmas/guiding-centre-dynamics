function Lmd = getLmd(s,L)
% function Lmd = getLmd(s,L)

%
% $Id: getLmd.m,v 1.6 2019/07/16 14:30:02 patrick Exp $
%
% Copyright (c) 2019 Patrick Guio <patrick.guio@gmail.com>
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

%opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
%opts = {'makima','extrap'};
opts = {'makima',NaN};

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
ii = find(adipL < min(aLi) | adipL > max(aLi));
if ~isempty(ii),
  warning('L larger than allowed');
end
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

%Lmd=Lmd1;
%return

clf
subplot(211), plot(L,Lmd,L,Lmd1)
subplot(212), plot(L,Lmd-Lmd1)
pause
