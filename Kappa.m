function k = Kappa(s,c,t)
% function k = Kappa(s,c,t)

%
% $Id: Kappa.m,v 1.4 2018/06/14 15:03:53 patrick Exp $
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

switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;
    Br = s.dip.Br;
    Bt = s.dip.Bt;

  case {'m','md','mdisc'},

    B = s.md.B;
    Br = s.md.Br;
    Bt = s.md.Bt;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

r = c.rt(t);
st = sin(t);
br = Br(r,st);
bt = Bt(r,st);
dbr = D2t(Br,r,st);
dbt = D2t(Bt,r,st);
% dr/dt = -r Br/Bt
dr = -r.*br./bt;
% d2r/dt2 = -r (-Br^2 + dBr/dt Bt - Br dBt/dt)/Bt^2
d2rr = -r.*(-br.^2+dbr.*bt-br.*dbt)./bt.^2;

k = curvature(r,dr,d2rr);

return

% alternative less robust
dr1 = c.drt(t);
d2rr1 = c.d2rtt(t);
k1 = curvature(r,dr1,d2rr1);

subplot(311), plot(t,dr,t,dr1)
title('dr/dt')
subplot(312), plot(t,d2rr,t,d2rr1)
title('d2r/dt2')
subplot(313), plot(t,k,t,k1);
title('Kappa')
pause

function kappa = curvature(r,dr,d2rr)

kappa = abs(r.^2+2*dr.^2-r.*d2rr)./(r.^2+dr.^2).^1.5;
