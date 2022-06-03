function erot = corotationenergy(c)
vrot = c.planet(3).*c.distrib.subcorot.*c.planet(1).*c.distrib.L; %Omega*Rp*L
erot = 0.5.*c.particle(2).*vrot; %in J
end