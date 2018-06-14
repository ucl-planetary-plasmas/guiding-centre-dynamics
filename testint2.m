function [I1,I2]=testint2(s,c,beta)
% function [I1,I2]=testint2(s,c,beta)

%
% $Id: testint2.m,v 1.2 2018/06/14 15:11:06 patrick Exp $
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

opts = {'AbsTol',1e-12,'RelTol',1e-9};

switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;

  case {'m','md','mdisc'},

    B = s.md.B;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

lm = getLatMP(s,c,beta);
Bm = B(c.rt(lm),sin(lm));

I1 = zeros(size(beta));
I2 = zeros(size(beta));
for i=1:length(beta),
  I1(i) = integral(@(t)f1(t,c),0,lm(i),opts{:});
  I2(i) = integral(@(t)f2(t,c),-lm(i),lm(i),opts{:});
end

function y=f1(t,c)
r = c.rt(t);
dr = c.drt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm).*sqrt(r.^2+dr.^2);
end

function y=f2(t,c)
r = c.rt(t);
dr = c.drt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm).*r;
end

end

