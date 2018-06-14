function lc = getLC(s,c)
% function lc = getLC(s,c)

%
% $Id: getLC.m,v 1.5 2018/06/14 14:46:42 patrick Exp $
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

  case {'m','md','mdisc'},

    B = s.md.B;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

lc = asin(sqrt(B(c.rt(0),0)/B(c.rt(c.tmx),c.mx)));
