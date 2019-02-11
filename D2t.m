function df = D2t(fun,r,s)
% function df = D2t(fun,r,s)

%
% $Id: D2t.m,v 1.5 2019/02/11 17:43:27 patrick Exp $
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
EPS = 1e-3;

% if s = sin(t)
ds = EPS*s;
ds(s==0) = EPS;
df = (fun(r,s+ds)-fun(r,s-ds))./(2*ds).*sqrt(1-s.^2);

return

% if s = lat
m = sin(s);
dm = EPS*m;
dm(m==0) = EPS;
df1 = (fun(r,m+dm)-fun(r,m-dm))./(2*dm).*cos(s);


plot(s,df,s,df1),
title('D2t')
pause


