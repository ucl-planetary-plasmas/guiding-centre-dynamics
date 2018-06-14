function BxdB = BxgradB(t,c,Br,Bt,B)
% function BxdB = BxgradB(t,c,Br,Bt,B)

%
% $Id: BxgradB.m,v 1.5 2018/06/14 15:06:00 patrick Exp $
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

st = sin(t);
r = c.rt(t);
dr = c.drt(t);

br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);

gradBr = D2r(B,r,st);
% - sign due to orientation of mu
gradBt = -1./r.*D2t(B,r,st);

% B x grad B 
BxdB = br.*gradBt - bt.*gradBr;

return

subplot(311), plot(t,BxdB), title('BxdB components');
subplot(312), plot(t,br.*gradBt),
subplot(313), plot(t,-bt.*gradBr),
pause
