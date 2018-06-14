function s=readMdisc(mdiscFile)
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

a = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.alphadip', opts{:});
B = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.Bdip', opts{:});
Br = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.Brdip', opts{:});
Bt = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.Bthdip', opts{:});

s.dip = struct('a',a,'B',B,'Br',Br,'Bt',Bt);

a = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.alpha', opts{:});
B = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.B', opts{:});
Br = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.Br', opts{:});
Bt = griddedInterpolant(s.MD.c2d.r',s.MD.c2d.mu',s.MD.v2d.Bth', opts{:});

s.md = struct('a',a,'B',B,'Br',Br,'Bt',Bt);
