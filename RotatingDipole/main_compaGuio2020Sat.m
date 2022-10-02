clear all; close all; 
%%WARNING: Gammas_Guio==Gammas/3
%%SATURN: 
% DATA FROM Bagenal2011 Fig.4 (For E_0)
load('planets.mat', 'Saturn');
c.planet = [60268e3, 21600e-9, 2*pi/(10.54*3600)]; %R and B as in Guio2020
c.distrib.subcorot = 0.9; %=1 == rigid rotation
a0mx = 1.5; na0 = 50;
c.distrib.a0 = [a0mx, na0];
load('particles.mat')

%%W+
c.particle = wp; 
[L, T] = dataBag11Sat('wp', false);
c.distrib.L = L';
c.distrib.E0 = T';
% Computation
[toms, params, mults, ints, intsnr, vd0s] = timesofmotion(c);

%% Non Rotating dipole, compa dimensionless integrals intsnr(\alpha_0) with Guio2020
r2d = 180/pi;
%reshap for figs
a0 = reshape(intsnr.a0(1, 1, :), [1, na0]);
lm = reshape(intsnr.lm(1, 1, :), [1, na0]);
phinrd = reshape(intsnr.phi(1, 1, :), [1, na0]);
gammanrd = reshape(intsnr.gamma(1, 1, :), [1, na0]);
gcnrd = reshape(intsnr.gc(1, 1, :), [1, na0]);
gcgnrd = reshape(intsnr.gcg(1, 1, :), [1, na0]);
gcgdir = reshape(intsnr.gcg_direct(1, 1, :), [1, na0]);
max(abs(gcgnrd-gcgdir))%4e-16
max(abs(gcgnrd-gammanrd))%0

%lm dipole (Fig.6)
figure('name','lm non rotating dipole')
plot(a0.*r2d, lm.*r2d);
xlabel('\alpha_0 [°]')
ylabel('\lambda_m [°]')
grid on

%Phi dipole (Fig.7)
figure('name','Phi non rotating dipole')
plot(a0.*r2d, phinrd);
xlabel('\alpha_0 [°]')
ylabel('\Phi^d')
grid on

%Gamma/Phi (Fig.8)
figure('name','Gamma/Phi non rotating dipole')
plot(a0.*r2d, gammanrd./(3.*phinrd));%%WARNING: Gammas_Guio==Gammas/3
xlabel('\alpha_0 [°]')
ylabel('\Gamma^d/\Phi^d')
grid on

%Gamma_c/Gamma_cg (Fig.10)
figure('name','Gamma_c/Gamma_cg non rotating dipole')
plot(a0.*r2d, (gcnrd./gcgnrd).*100);
xlabel('\alpha_0 [°]')
ylabel('$\Gamma_C/\Gamma_{CG}$ [%]', 'Interpreter', 'latex')
grid on

% %% Rotating dipole: compa evolution of ints(\alpha_0, L(\beta_0)) with magnetodisc Guio2020
% r2d = 180/pi;
% [nL,~] = size(L);
% %reshap for figs
% alpha0 = reshape(ints.a0(1, :, :), [nL, na0]);
% lm = reshape(ints.lm(1, :, :), [nL, na0]);
% phi = reshape(ints.phi(1, :, :), [nL, na0]);
% gamma = reshape(ints.gamma(1, :, :), [nL, na0]);
% gc = reshape(ints.gc(1, :, :), [nL, na0]);
% gcg = reshape(ints.gcg(1, :, :), [nL, na0]);
% gcgdir = reshape(ints.gcg_direct(1, :, :), [nL, na0]);
% % max(abs(gcg-gcgdir)) %4.4e-16

