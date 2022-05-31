function s=readCAN(mdiscFile)
% function s=readMdisc(mdiscFile)

%
% $Id: readMdisc.m,v 1.2 2018/06/14 14:54:59 patrick Exp $
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

s = load(mdiscFile);

opts = {'spline', 'spline'};
opts = {'cubic', 'cubic'};
opts = {'makima', 'makima'};

r1=repmat(s.CAN.r,length(s.CAN.mu),1);
mu1=repmat(s.CAN.mu,length(s.CAN.r),1)';

a = griddedInterpolant(r1',mu1',s.CAN.alpha', opts{:});
B = griddedInterpolant(r1',mu1',s.CAN.B', opts{:});
Br = griddedInterpolant(r1',mu1',s.CAN.Br', opts{:});
Bt = griddedInterpolant(r1',mu1',s.CAN.Bt', opts{:});

s.interp = struct('a',a,'B',B,'Br',Br,'Bt',Bt,'r',r1,'mu',mu1);