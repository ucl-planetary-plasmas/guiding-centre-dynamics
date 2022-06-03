clear all;
% close all; 
% Main (after the add of the b0 case)

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

% % Corotation energy vs Temperature energy
% erot = corotationenergy(c);
% figure('Name', 'Erot vs Etemp')
% hold on
% plot(L, ec86, 'DisplayName', 'Etemp')
% plot(L, j2ev(erot), 'DisplayName', 'Ecorot')
% xlabel('L')
% ylabel('E [eV]')
% set(gca, 'YScale', 'log')
% legend
% hold off

% Computation
[toms, params, mults, ints, intsnr, vd0s] = timesofmotion(c);

% v_D limits
vdeq = (3+2.*params.b0.rot).*(0.5.*c.distrib.E0.*c.distrib.L.^2)./...
    (c.particle(1).*c.planet(1).*c.planet(2));
taudvd = mults.D.*(2./(3+2.*params.b0.rot));
taudvdnr = mults.D.*(2/3);


%% Quick visu of the results obtained

% figure('Name', 'al')
% plot(L, params.al.rot, '+-');hold on;
% plot(L, params.al.norot, 'kx-'); hold on;

figure('Name', 'E0(L)')
plot(params.case.distrib.L, ...
    params.case.distrib.E0, ...
    'DisplayName', 'caudal86 cold')
xlabel('L [ ]')
ylabel('E0 [eV]')
% 
% figure('Name', 'b0')
% plot(L, params.b0.rot, '+-'); hold on;
% plot(L, params.b0.norot, 'kx-'); hold on;
% 
% figure('Name', 'tb, a0=0')
% plot(L, toms.rot.tb(1,:,1), '+-');hold on;
% plot(L, toms.norot.tb(:,1), 'kx-'); hold on;

figure('Name', 'tb, a0 fixed')
hold on
yyaxis left
plot(L, toms.rot.tb(1,:,1), 'b+-', 'DisplayName', 'tb: a0 = 0, rot')
plot(L, toms.norot.tb(1,:,1), 'bx-')% , 'DisplayName', 'tb: a0 = 0, no rot')
plot(L, toms.rot.tb(1,:,end), 'c+-', 'DisplayName', 'tb: a0mx, rot')
plot(L, toms.norot.tb(1,:,end), 'cx-')% , 'DisplayName', 'tb: a0mx, no rot')
yyaxis right
plot(params.case.distrib.L, params.case.distrib.E0, '*-',...
    'DisplayName', 'E0(L)')
plot(L, params.b0.rot, 'o-', 'DisplayName', 'b0, rot')
xlabel('L [ ]')
% legend
hold off

figure('Name', 'tb, L fixed')
hold on
% L=5
x5 = reshape(params.a0.rot(1,1,:), [10,1]);
y5 = reshape(toms.rot.tb(1,1,:), [10,1]);
plot(x5, y5, '+', 'DisplayName', 'L=5, rot')
xnr5 = reshape(params.a0.norot(1,1,:), [10,1]);
ynr5 = reshape(toms.norot.tb(1,1,:), [10,1]);
plot(xnr5, ynr5, 'x-', 'DisplayName', 'L=5,  no rot')
% L =10
x10 = reshape(params.a0.rot(1,end,:), [10,1]);
y10 = reshape(toms.rot.tb(1,end,:), [10,1]);
plot(x10, y10, '+', 'DisplayName', 'L=10, rot')
xnr10 = reshape(params.a0.norot(1,end,:), [10,1]);
ynr10 = reshape(toms.norot.tb(1,end,:), [10,1]);
plot(xnr10, ynr10, 'x-', 'DisplayName', 'L=10, no rot')
xlabel('a0 [ ]')
ylabel('tb [s]')
grid on
legend
hold off

figure('Name', 'tb(rot)-tb(norot), L fixed')
hold on
plot(x5, y5-ynr5, '+', 'DisplayName', 'L=5')
plot(x10, y10-ynr10, 'x', 'DisplayName', 'L=10')
xlabel('a0 [ ]')
ylabel('tb [s]')
grid on
legend
hold off


%% Integrations


a0 = reshape(ints.a0(1,:,:), [nL,na0]);
b0 = repmat(params.b0.rot, na0,1)';
lm = reshape(ints.lm(1, :, :), [nL,na0]);
lmnr = reshape(intsnr.lm(1, 1, :), na0,1);
phi = reshape(ints.phi(1, :, :), [nL,na0]);
phinr = reshape(intsnr.phi(1, 1, :), na0,1);

% figure('Name', 'lm and phi')
% subplot(121)
% hold on
% pcolor(a0, b0,lm)
% shading flat
% colormap(jet(50))
% colorbar
% title('\lambda_m []');
% ylabel('b0 [ ]')
% xlabel('a0 []')
% set(gca, 'FontSize', 15, 'fontName','Times');
% % caxis([0,60])
% % cb=colorbar
% % cb.Label.FontSize = 15;
% hold off
% subplot(122)
% hold on
% pcolor(a0, b0,phi)
% shading flat
% colormap(jet(50))
% colorbar
% title('\Phi');
% ylabel('b0 [ ]')
% xlabel('a0 []')
% set(gca, 'FontSize', 15, 'fontName','Times');
% % caxis([0.4,1.1])
% % cb=colorbar;
% % cb.Label.FontSize = 15;
% hold off
% 
% figure('Name', 'lmnr and phinr')
% hold on
% plot(a0(1,:), lmnr, 'r+-')
% plot(a0(1,:), lm(1, :), '+-')
% plot(a0(1,end), lm(end, :), '+-')
% plot(a0(1,:), phinr, 'rx')
% plot(a0(1,:), 1.3-0.56.*sin(a0), 'm-')
% plot(a0(1,:), phi(1, :), 'x-')
% plot(a0(end,:), phi(end, :), 'x-')

% Tau_b
tb = reshape(toms.rot.tb(1, :, :), [nL,na0]);
tbnr = reshape(toms.norot.tb(1, :, :), [nL,na0]);
% figure('Name', 'tb, L fixed')
% hold on
% plot(a0(1,:), tbnr(1, :), '*', 'DisplayName', 'no rot L=5')
% plot(a0(1,:), tbnr(end, :), '*', 'DisplayName', 'no rot L=10')
% plot(a0(1,:), tb(1, :), '+-', 'DisplayName', 'rot, L=5')
% plot(a0(end,:), tb(end, :), 'x-', 'DisplayName', 'rot, L=10')
% xlabel('a0 [ ]')
% ylabel('tb [s]')
% legend
% set(gca, 'YScale', 'log')
% grid on 
% hold off
figure('Name', 'tb, a0 fixed')
hold on
yyaxis left
plot(L, tbnr(:, 2), '+-', 'DisplayName', 'no rot, a0min')
plot(L, tbnr(:, end), 'x-', 'DisplayName', 'no rot, a0max')
plot(L, mults.B, 'DisplayName', 'B')
% plot(L, 300.*params.b0.rot,'DisplayName', '300*b0(L, E0)')
set(gca, 'YScale', 'log')
yyaxis right
plot(L, tb(:, 1), '+-', 'DisplayName', 'rot, a0min')
plot(L, tb(:, end), 'x-', 'DisplayName', 'rot, a0max')
xlabel('L [ ]')
set(gca, 'YScale', 'log')
legend
grid on
hold off

% Tau_d mag
tdcg = reshape(toms.rot.tdcg(1, :, :), [nL,na0]);
tdnr = reshape(toms.norot.td(1, :, :), [nL,na0]);
% figure('Name', 'td_GC only L fixed')
% hold on
% plot(a0(1,:), tdnr(1, :), '*', 'DisplayName', 'no rot L=5')
% plot(a0(1,:), tdnr(end, :), '*', 'DisplayName', 'no rot L=10')
% % plot(a0(1,:), tdcg(1, :), '+-', 'DisplayName', 'rot, L=5')
% plot(a0(end,:), tdcg(end, :), 'x-', 'DisplayName', 'rot, L=10')
% legend
% grid on 
% hold off
figure('Name', 'tdCG only, a0 fixed')
hold on
% yyaxis left
plot(L, tdnr(:, 2), '+-', 'DisplayName', 'no rot, a0min')
plot(L, tdnr(:, end), 'x-', 'DisplayName', 'no rot, a0max')
% set(gca, 'YScale', 'log')
% yyaxis right
plot(L, tdcg(:, 1), '+-', 'DisplayName', 'rot, a0min')
plot(L, tdcg(:, end), 'x-', 'DisplayName', 'rot, a0max')
plot(L, mults.D, 'DisplayName', 'D')
% plot(L, 300.*params.b0.rot,'DisplayName', '300*b0(L, E0)')
set(gca, 'YScale', 'log')
legend
grid on
hold off

% figure('Name', 'tdCG only, a0 fixed')
% hold on
% yyaxis left
% plot(L, tdnr(:, 1), '+:', 'DisplayName', 'no rot, a0min')
% plot(L, tdnr(:, end), '+-', 'DisplayName', 'no rot, a0max')
% plot(L, tdcg(:, 1), 'x:', 'DisplayName', 'rot, a0min')
% plot(L, tdcg(:, end), 'x-', 'DisplayName', 'rot, a0max')
% plot(L, mults.D, 'DisplayName', 'D')
% yyaxis right
% plot(L, params.b0.rot,'DisplayName', 'b0(L, E0)')
% legend
% grid on
% hold off

% figure('Name', 'tdCG/b0')
% b0 = params.b0.rot';
% hold on
% yyaxis left
% plot(L', tdnr(:, 2)./b0, '+-', 'DisplayName', 'no rot, a0min')
% plot(L, tdnr(:, end)./b0, 'x-', 'DisplayName', 'no rot, a0max')
% yyaxis right
% plot(L, tdcg(:, 1)./b0, '+-', 'DisplayName', 'rot, a0min')
% plot(L, tdcg(:, end)./b0, 'x-', 'DisplayName', 'rot, a0max')
% plot(L, mults.D'./b0, 'DisplayName', 'D')
% legend
% grid on
% hold off

% % phi/Gamma_CG
% pOgcg = reshape(ints.pOgcg(1, :, :), [nL,na0]);
% pOgcgnr = reshape(intsnr.pOgcg(1, 1, :), na0,1);
% figure('Name', 'Phi/gcg')
% hold on
% plot(a0(1,:), pOgcgnr, 'r*')
% plot(a0(1,:), 1./(3.*(0.35+0.15.*sin(a0))), 'm-')
% plot(a0(1,:), pOgcg(1, :), '+-')
% plot(a0(end,:), pOgcg(end, :), 'x-')
% grid on 
% hold off

% Tau_d tot
td = reshape(toms.rot.td(1, :, :), [nL,na0]);
figure('Name', 'td (CG+CF), a0 fixed')
hold on
% yyaxis left
plot(L, tdnr(:, 2), '+-', 'DisplayName', 'no rot, a0min')
plot(L, tdnr(:, end), 'x-', 'DisplayName', 'no rot, a0max')
% set(gca, 'YScale', 'log')
% yyaxis right
plot(L, td(:, 1), '+-', 'DisplayName', 'rot, a0min')
plot(L, td(:, end), 'x-', 'DisplayName', 'rot, a0max')
plot(L, mults.D, 'DisplayName', 'D')
set(gca, 'YScale', 'log')
legend
grid on
hold off

% tau_d for fixed L
figure('Name', 'td only L fixed')
hold on
plot(a0(1,:), tdnr(1, :), '*-', 'DisplayName', 'no rot L=5')
plot(a0(1,:), tdnr(end, :), 'o-', 'DisplayName', 'no rot L=10')
plot(pi/2, taudvdnr(1), '*', 'DisplayName', 'no rot, taudvd L=5', 'MarkerSize', 8)
plot(pi/2, taudvdnr(end), 'o', 'DisplayName', 'no rot taudvd L=10', 'MarkerSize', 8)
plot(a0(2,:), td(2, :), '+-', 'DisplayName', 'rot, L=5', 'Linewidth', 2)
plot(a0(end,:), td(end, :), 'x-', 'DisplayName', 'rot, L=10', 'LineWidth', 2)
plot(pi/2, taudvd(1), '+', 'DisplayName', 'taudvd, L=5', 'MarkerSize', 8,'Linewidth', 2)
plot(pi/2, taudvd(end), 'x', 'DisplayName', 'taudvd, L=10', 'MarkerSize', 8,'Linewidth', 2)
xlabel('\alpha_0 [ ]')
ylabel('\tau_d [s]')
set(gca, 'YScale', 'log')
legend('Location', 'NorthWest')
grid on 
hold off

%% Drift velocities at the equator (vd0s) 

vd0 = reshape(vd0s.vd0(1, :, :), [nL,na0]);
vd0cg = reshape(vd0s.vd0cg(1, :, :), [nL,na0]);
% vd0s.vd0cf
% vdeq

figure('Name', 'vdos')
hold on
plot(L, vd0(:, 2),'DisplayName', 'rot, a0min')
plot(L, vd0(:, end),'DisplayName', 'rot, a0max')
plot(L, vdeq,'DisplayName', 'rot, a0=pi/2') 
plot(L, vd0cg(:,2),'--','DisplayName', 'CG: rot, a0min')
plot(L, vd0(:, end),'--','DisplayName', 'CG: rot, a0min')
plot(L, vd0s.vd0cf,'-.','DisplayName', 'CF:rot, a0min')
% set(gca, 'YScale', 'log')
legend('location', 'northwest')
grid on
hold off
