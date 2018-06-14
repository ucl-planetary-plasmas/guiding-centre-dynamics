function k = Kappad(L,t)
% function k = Kappad(L,t)

%
% $Id: Kappad.m,v 1.3 2018/06/14 15:03:53 patrick Exp $
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

k = 1.5/L*abs(cos(t).^2.*(-3+cos(2*t)))./ ...
     (cos(t).^2.*(cos(t).^2+4*sin(t).^2)).^1.5;

return

r = L*cos(t).^2;
dr = -2*L*cos(t).*sin(t);
d2rr = -2*L*(cos(t).^2-sin(t).^2);

k1 = abs(r.^2+2*dr.^2-r.*d2rr)./(r.^2+dr.^2).^1.5;

plot(t,k,t,k1),
legend({'\kappa','\kappa1'})
pause

