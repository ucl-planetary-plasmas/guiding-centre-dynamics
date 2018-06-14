function lm = getLatMPd(L,aeq)
% function lm = getLatMPd(L,aeq)

%
% $Id: getLatMPd.m,v 1.4 2018/06/14 14:44:24 patrick Exp $
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

% numerically
%tic
opts = optimset('fzero');

lm = zeros(size(aeq));

f = @(x,a) cos(x).^6-sin(a)^2.*sqrt(1+3*sin(x).^2);
for i = 1:length(aeq),
  lm(i) = fzero(@(x) f(x,aeq(i)),pi/4,opts);
end
%toc

return

% symbolically takes longer time and requires symbolic toolbox
%tic
M = sym('M','positive');
eqn = M.^6 + 3*M*(sin(aeq)).^4 == 4*(sin(aeq)).^4;
COS2M = vpasolve(eqn,M,0.5);
COSM = double(sqrt(COS2M(2)));
lm1 = acos(COSM);
%toc

lm,lm1,lm-lm1
