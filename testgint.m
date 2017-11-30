function testgint(u0,g)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

EPS = 1e-6;

zmax = u0^2/(2*g);

fprintf(1,'zmax=%g, f1(zmax)=%g\n', zmax, f1(zmax,u0,g))


In = integral(@(z)f(z,u0,g),0,zmax,opts{:},'Waypoints',zmax);
Ie = u0/g;

fprintf(1,'In=%g Ie=%g AbsErr=%g RelErr=%g\n', In, Ie, In-Ie, (In-Ie)/Ie)

function y=f(z,u0,g)
y = 1./sqrt(u0^2-2*g*z);

function y=f1(z,u0,g)
y = sqrt(u0^2-2*g*z);
