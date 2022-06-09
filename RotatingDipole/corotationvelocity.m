function vcorot = corotationvelocity(c)
% Compute the (sub)corotation velocity
% vcorot = Omega*Rp*L where Omega = Op*subcorotation_factor
vcorot = c.planet(3).*c.distrib.subcorot.*c.planet(1).*c.distrib.L; %Omega*Rp*L
end