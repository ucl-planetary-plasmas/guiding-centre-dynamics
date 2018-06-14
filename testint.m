function I = testint(s,c,beta)
% function I = testint(s,c,beta)

%
% $Id: testint.m,v 1.4 2018/06/14 15:11:06 patrick Exp $
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

lm = getLatMP(s,c,beta);

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = integral(@(t)fun(t,c),-lm(i),lm(i),opts{:});
end

function y=fun(t,c)
%y = sqrt(c.rt(t).^2+Dct(c.rt,t).^2);
y = sqrt(c.rt(t).^2+c.drt(t).^2);
end

end
