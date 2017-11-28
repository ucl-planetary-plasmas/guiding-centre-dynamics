function varargout = polarplot(varargin)

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
