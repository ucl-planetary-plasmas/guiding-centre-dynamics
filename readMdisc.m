function s=readMdisc(mdiscFile)

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
