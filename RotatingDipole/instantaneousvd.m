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
c.distrib.E0 = (3/2).*ec86;
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

nl = 1e2; l = linspace(0, pi/2, nl);% latitude \lambda

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
vd0cf = vd0s.vd0cf;
lm = reshape(ints.lm(1,:,:), [nL,na0]);
%% Intantaneous drift velocities 
% 2D plots
vdscgL5 = vd0cg(1, :)'*cgl;
vdscgL10 = vd0cg(end, :)'*cgl;
figure('name', 'vdscg wrt lat and a0; L=5')
hold on
pcolor(vdscgL5)
pcolor(vdscgL10)
shading flat
colormap(jet(50));
cb=colorbar;
hold off

vdscfl = vd0cf'*cfl;
figure('name', 'vdscf wrt lat and L(or b0)')
hold on
pcolor(vdscfl)
shading flat
colormap(jet(50));
cb=colorbar;
hold off

vdla00 = vd0cg(:, 1)*cgl+vdscfl;
vdla0pi2 = vd0cg(:, end)*cgl+vdscfl;
figure('name', 'vds wrt lat and L')
hold on
% pcolor(vdla00)
pcolor(vdla0pi2)
shading flat
colormap(jet(50));
cb=colorbar;
hold off

% CF term seems to heavily dominate
%% 1D plots
vcorot = corotationvelocity(c);
% case a0=0, L=5;
figure('name', 'a0=0, L=5')
hold on
plot(l, vd0cg(1, 1).*cgl+vd0cf(1).*cfl, 'displayname', 'tot')
plot(l, vd0cg(1, 1).*cgl, 'displayname', 'CG')
plot(l, vd0cf(1).*cfl, 'displayname', 'CF')
plot(l, vcorot(1).*ones(nl, 1), 'displayname', 'v_corot')
ylabel('instantaneous vd [m/s]')
xlabel('Latitude \lambda [ ]')
legend
grid on
hold off
% Negative velocity ! CounterRotating (smaller than) VS SubRotating (less than vcorot but greater than 0)
figure('name', 'a0=0, L=5 and 10')
hold on
% L=5 (Lmin)
plot(l, vcorot(1)+vd0cg(1, 1).*cgl+vd0cf(1).*cfl, 'displayname', 'L= 5 : tot')
plot(l, vcorot(1)+vd0cg(1, 1).*cgl, 'displayname', 'L= 5 : CG')
plot(l, vcorot(1)+vd0cf(1).*cfl, 'displayname', 'L= 5 : CF')
% L=10 (Lmax)
plot(l, vcorot(end)+vd0cg(end, 1).*cgl+vd0cf(1).*cfl, 'displayname', 'L= 10 : tot')
plot(l, vcorot(end)+vd0cg(end, 1).*cgl, 'displayname', 'L= 10 : CG')
plot(l, vcorot(end)+vd0cf(end).*cfl, 'displayname', 'L= 10 : CF')
ylabel('vd +vcorot [m/s]')
xlabel('Latitude \lambda [ ]')
% set(gca, 'YScale', 'log')
legend
grid on
hold off

% CF vs CG term (dimensionless)
figure('name','CF vs CG term)')
hold on
plot(l, (3/2).*cgl, 'displayname', 'CG min : (3/2)cgl')
plot(l, 3.*cgl, 'displayname', 'CG max : 3 cgl')
plot(l, min(b0).*cfl, 'displayname', ['CF min : ', num2str(min(b0)), ' cfl'])
plot(l, max(b0).*cfl, 'displayname', ['CF max : ', num2str(max(b0)), ' cfl'])
plot([min(lm(:, 1)) min(lm(:,1))], [-5 160], 'displayname', 'min lm, a0 = 0')
plot([min(lm(:, end)) min(lm(:,end))],[-5 160], 'displayname', 'min lm, a0 = pi/2')
plot([max(lm(:, 1)) max(lm(:,1))], [-5 160], 'displayname', 'max lm, a0 = 0')
plot([max(lm(:, end)) max(lm(:,end))],[-5 160], 'displayname', 'max lm, a0 = pi/2')
hold off
xlabel('Latitude \lambda [ ]')
ylim([-5, 160])
legend
grid on
hold off

