function I = PhiCAN(s,c,beta)
% function I = Phi(s,c,beta)

%
% $Id: Phi.m,v 1.3 2018/06/14 14:54:03 patrick Exp $
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

B = s.interp.B;
Br = s.interp.Br;
Bt = s.interp.Bt;


lm = getLatMPCAN(s,c,beta);
Bm = B(c.rt(lm),sin(lm));

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = 1/c.r0*integral(@(t)f(t,c,Bm(i)),0,lm(i),opts{:});
end

function y=f(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = (sqrt(((Br(r,st)./Bt(r,st)).^2+1)./(1-B(r,st)/Bm)).*r);
end

end