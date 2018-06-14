function I = OmegaOverPhia(mftype,r,beta)
% function I = OmegaOverPhia(mftype,r,beta)

%
% $Id: OmegaOverPhia.m,v 1.5 2018/06/14 14:52:31 patrick Exp $
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

switch lower(mftype),

  case {'d','dip','dipole'},
 
  % From mathematica mdintegral.nb
  %I = (0.347714+0.152138*sin(beta));

	% From 2D fit
  I = 0.35+0.14*sin(beta);

  case {'m','md','mdisc'},

  % From 2D fit
  I = 0.40-0.06*sin(beta)+0.04.*r.*sin(beta);

  otherwise

  error('magnetic field type mftype not recognised',mftype)

end


