function varargout = polarplot(varargin)
% function varargout = polarplot(varargin)

%
% $Id: polarplot.m,v 1.2 2018/06/14 15:11:06 patrick Exp $
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

xy = cell(nargin,1);
for i=1:nargin/2;
	t = varargin{2*i-1};
  r = varargin{2*i};
  xy{2*i-1} = r.*cos(t);
  xy{2*i} = r.*sin(t);
end
h = plot(xy{:});

if nargout>0,
  varargout{1} = h;
end
