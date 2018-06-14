function lmp = getLatMP(s,c,aeq)
% function lmp = getLatMP(s,c,aeq)

%
% $Id: getLatMP.m,v 1.6 2018/06/14 14:44:24 patrick Exp $
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

opts = {'linear','extrap'};
%opts = {'spline','extrap'};
%opts = {'cubic','extrap'};
opts = {'makima','extrap'};

t = linspace(0,c.tmx,c.nrt);
st = sin(t);
switch lower(c.type),

  case {'d','dip','dipole'},

	  B = s.dip.B;

  case {'m','md','mdisc'},

	  B = s.md.B;

  otherwise
    error('magnetic field type c.type not recognised',c.type)
end

% create ratio sqrt(Beq/B) as function of latitude
sina = sqrt(B(c.rt(0),sin(0))./B(c.rt(t),st));

% inverse mapping: find the value of latitude where sqrt(Beq/B)=sin(aeq)
lmp = asin(interp1(sina,st,sin(aeq),opts{:}));

% numerically improve solution
%fun = @(t,a) B(c.rt(0),0)-sin(a).^2.*B(c.rt(t),sin(t));
fun = @(t,a) sqrt(B(c.rt(0),0))-sin(a).*sqrt(B(c.rt(t),sin(t)));
opts = optimset('fzero');
lmp1 = zeros(size(aeq));
for i=1:length(aeq),
	lmp(i) = fzero(@(x) fun(x,aeq(i)),lmp(i),opts);
end

return
lmp
lmp1
lmp-lmp1
pause
