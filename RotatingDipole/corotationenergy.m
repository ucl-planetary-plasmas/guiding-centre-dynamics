function erot = corotationenergy(c)
% Compute the kinetic energy due to (sub)corotation
vcorot = corotationvelocity(c);%in m/s
erot = 0.5.*c.particle(2).*vcorot; %in J
end