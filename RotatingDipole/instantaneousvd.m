% Study of the instantaneous drift velocities (latitude, pitch angle, beta)

%% Same initialisation as in main_test
% Initialisation
load('planets.mat', 'Jupiter');
c.planet = [Jupiter.Rp{1}, Jupiter.Bp{1}, Jupiter.Op{1}];
load('particles.mat')
c.particle = wp;
% c.particle = en;
nL =50;
L = linspace(5, 10, nL);
c.distrib.L = L;
c.distrib.subcorot = 0.8; %=1 == rigid rotation
ec86 = caudal86cold(L);
c.distrib.E0 = ec86;
% eb94te = bagenal94thelec(L);
% c.distrib.E0 = eb94te;
a0mx = pi/2-1e-1;
na0 = 10;
c.distrib.a0 = [a0mx, na0];

% Computation without passing by timesofmotion >> c, alpha0, b0, lm
mults = multipliers(c);
b0 = computebeta0(c);
al = computealphaloss(b0, c.distrib.L);
[ints, alpha0] = integrals(al, b0,c.distrib.a0(1), c.distrib.a0(2));

nl = 60; l = linspace(0, pi/2, nl);% latitude \lambda

% instantaneaous velocities at the equator
vd0s = driftvelocities(c, alpha0, b0);
% latitude dependancies
cgl = cos(l).^5.*(1+sin(l).^2)./(1+3.*sin(l).^2);
cfl = cos(l).^7.*(1-3.*sin(l).^2)./(1+3.*sin(l).^2);

% Visualisation
figure('Name', 'Lat dep')
hold on
plot(l, cgl, 'displayname', 'CG')
plot(l, cfl, 'displayname', 'CF')
xlabel('Latitude \lambda [ ]')
legend
grid on
hold off

% here E0(L) so reshape in nL x na0:
a0 = reshape(alpha0(1,:,:), [nL,na0]);
vd0 = reshape(vd0s.vd0(1, :, :), [nL,na0]);
vd0cg = reshape(vd0s.vd0cg(1, :, :), [nL,na0]);
%% Intantaneous drift velocities 



