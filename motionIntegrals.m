function [I,Sb,K] = motionIntegrals(s,c,beta)
% function [I,Sb,K] = motionIntegrals(s,c,beta)

%
% $Id: motionIntegrals.m,v 1.1 2019/06/10 12:00:12 patrick Exp $
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
%opts = {'AbsTol',1e-6,'RelTol',1e-3};

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

lm = getLatMP(s,c,beta);
Bm = B(c.rt(lm),sin(lm));

I = zeros(size(beta));
Sb = zeros(size(beta));
K = zeros(size(beta));
for i=1:length(beta),
  I(i) = 1/c.r0*integral(@(t)fI(t,c,Bm(i)),0,lm(i),opts{:});
  Sb(i) = 1/c.r0*integral(@(t)fSb(t,c,Bm(i)),0,lm(i),opts{:});
  K(i) = 1/c.r0*integral(@(t)fK(t,c,Bm(i)),0,lm(i),opts{:});
end

% Eq 3 in Roussos, 2013
function y=fI(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = sqrt(1-B(r,st)/Bm).*r;
end

% Eq 4 in Roussos, 2013
function y=fSb(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = 1./sqrt(1-B(r,st)/Bm).*r;
end

% Eq A.1
function y=fK(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = sqrt(Bm-B(r,st)).*r;
end
end

