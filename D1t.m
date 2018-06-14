function df = D1t(fun,t)
% function df = D1t(fun,t)

%
% $Id: D1t.m,v 1.2 2018/06/14 15:01:07 patrick Exp $
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

EPS = 1e-6;
EPS = 1e-2;
EPS = 1e-1;
m = sin(t);
dm = EPS*m;
df = (fun(m+dm)-fun(m-dm))./(2*dm).*cos(t);


