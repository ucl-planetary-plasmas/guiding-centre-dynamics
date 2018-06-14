function df = D2r(fun,r,s)
% function df = D2r(fun,r,s)

%
% $Id: D2r.m,v 1.3 2018/06/14 15:01:07 patrick Exp $
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
dr = EPS*r;
dr(r==0) = EPS;
df = (fun(r+dr,s)-fun(r-dr,s))./(2*dr);


