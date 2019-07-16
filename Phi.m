function I = Phi(s,c,beta)
% function I = Phi(s,c,beta)

%
% $Id: Phi.m,v 1.4 2019/07/16 16:05:01 patrick Exp $
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

I = zeros(size(beta));

% code for pitch angle around 90 deg
%ii = find(abs(beta-pi/2)<=1e-3);
%if ~isempty(ii),
%  I(ii) = pi/sqrt(2)./c.r0./c.kappa(0);
%end

lm = getLatMP(s,c,beta);
Bm = B(c.rt(lm),sin(lm));
%ii = find(abs(beta-pi/2)>1e-3);
%for i=ii,
for i=1:length(beta),
  I(i) = 1/c.r0*integral(@(t)f(t,c,Bm(i)),0,lm(i),opts{:});
end

function y=f(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = (sqrt(((Br(r,st)./Bt(r,st)).^2+1)./(1-B(r,st)/Bm)).*r);
end

end

