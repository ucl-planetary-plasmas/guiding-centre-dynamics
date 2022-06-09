function vd0s = driftvelocities(c, a0, b0)
% equatorial instantaneous drift velocities: vd0s

V = (2.*c.distrib.E0.*c.distrib.L.^2)./...
    (c.particle(1).*c.planet(1).*c.planet(2));
% magnetic component (Curvature and Gradient)
vd0cg = V.*3.*(0.5.*sin(a0).^2 + cos(a0).^2);
% centrifugal 
vd0cf = V.*b0;
% total
vd0 = vd0cg + vd0cf;

% vd0 and vd0cg are multidimensional arrays of size nE0 x nL x na0
% vd0cf only nE0 x nL
vd0s = struct('vd0', vd0, ...
    'vd0cg', vd0cg, ...
    'vd0cf', repmat(vd0cf, [1 length(c.distrib.a0(2))]) ...
    );
end