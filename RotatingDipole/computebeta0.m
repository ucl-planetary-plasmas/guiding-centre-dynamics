function b0 = computebeta0(c)
p2 = (c.planet(1).*c.distrib.subcorot.*c.planet(3)).^2;
f = c.distrib.L.^2./2;
b0 = amu2kg(c.particle(2)).*f.*p2./ev2j(c.distrib.E0);
end