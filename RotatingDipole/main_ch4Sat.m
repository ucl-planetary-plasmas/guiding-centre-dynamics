clear all; close all; 
%%SATURN: DATA FROM Bagenal2011 Fig.4
load('planets.mat', 'Saturn');
% c.planet = [Saturn.Rp{1}, Saturn.Bp{1}, Saturn.Op{1}];
c.planet = [60268e3, 21600e-9, 2*pi/(10.54*3600)]; %R and B as in Guio2020
c.distrib.subcorot = 0.9; %=1 == rigid rotation
a0mx = 1.5; na0 = 5;
c.distrib.a0 = [a0mx, na0];
load('particles.mat')

%% H+
c.particle = hp; 
[L, T] = dataBag11Sat('hp', false);
c.distrib.L = L';
c.distrib.E0 = 3.*T';
% Computation
[toms, params, mults, ints, intsnr, vd0s] = timesofmotion(c);
%reshap for figs
[nL,~] = size(L);
tb = reshape(toms.rot.tb(1, :, :), [nL,na0]);
tbnr = reshape(toms.norot.tb(1, :, :), [nL,na0]);
td = reshape(toms.rot.td(1, :, :), [nL,na0]);
tdnr = reshape(toms.norot.td(1, :, :), [nL,na0]);

figure('Name','H+ taub')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
% patch([L, fliplr(L)], [tb(:, 2) fliplr(tb(:, end))], [0.85, 1, 0.85],'EdgeColor', 'none')
plot(L, tb(:, 2), '--', 'color', '#006400','DisplayName', '\alpha_0 min')
plot(L, tb(:, end), '-', 'color', '#006400', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.B, '.-', 'DisplayName', 'common multiplier B')
plot(L, tbnr(:, 2), '--', 'color', '#32CD32', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tbnr(:, end), '-', 'color', '#32CD32','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_b [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off

figure('Name','H+ taud')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
plot(L, td(:, 2), '--', 'color', '#006400','DisplayName', '\alpha_0 min')
plot(L, td(:, end), '-', 'color', '#006400', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.D, '.-', 'DisplayName', 'common multiplier D')
plot(L, tdnr(:, 2), '--', 'color', '#32CD32', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tdnr(:, end), '-', 'color', '#32CD32','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_d [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off
%% H2+
c.particle = h2p; 
[L, T] = dataBag11Sat('h2p', false);
c.distrib.L = L';
c.distrib.E0 = T';
% Computation
[toms, params, mults, ints, intsnr, vd0s] = timesofmotion(c);
%reshap for figs
[nL,~] = size(L);
tb = reshape(toms.rot.tb(1, :, :), [nL,na0]);
tbnr = reshape(toms.norot.tb(1, :, :), [nL,na0]);
td = reshape(toms.rot.td(1, :, :), [nL,na0]);
tdnr = reshape(toms.norot.td(1, :, :), [nL,na0]);
% %%%
% disp('B should be of order 10-100')
% disp(mults.B(1))
% disp(mults.B(end))
% disp('D should be of order 1e4-1e5')
% disp(mults.D(1))
% disp(mults.D(end))
% disp('P')
% disp(mults.P(1))
% disp(mults.P(end))
% %%%

figure('Name','H2+ taub')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
% patch([L, fliplr(L)], [tb(:, 2) fliplr(tb(:, end))], [0.85, 1, 0.85],'EdgeColor', 'none')
plot(L, tb(:, 2), '--', 'color', '#8B0000','DisplayName', '\alpha_0 min')
plot(L, tb(:, end), '-', 'color', '#8B0000', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.B, '.-', 'DisplayName', 'common multiplier B')
plot(L, tbnr(:, 2), '--', 'color', '#B22222', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tbnr(:, end), '-', 'color', '#B22222','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_b [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off

figure('Name','H2+ taud')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
plot(L, td(:, 2), '--', 'color', '#8B0000','DisplayName', '\alpha_0 min')
plot(L, td(:, end), '-', 'color', '#8B0000', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.D, '.-', 'DisplayName', 'common multiplier D')
plot(L, tdnr(:, 2), '--', 'color', '#B22222', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tdnr(:, end), '-', 'color', '#B22222','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_d [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off

%% W+
c.particle = wp; 
[L, T] = dataBag11Sat('wp', false);
c.distrib.L = L';
c.distrib.E0 = T';
% Computation
[toms, params, mults, ints, intsnr, vd0s] = timesofmotion(c);
%reshap for figs
[nL,~] = size(L);
tb = reshape(toms.rot.tb(1, :, :), [nL,na0]);
tbnr = reshape(toms.norot.tb(1, :, :), [nL,na0]);
td = reshape(toms.rot.td(1, :, :), [nL,na0]);
tdnr = reshape(toms.norot.td(1, :, :), [nL,na0]);

figure('Name','W+ taub')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
% patch([L, fliplr(L)], [tb(:, 2) fliplr(tb(:, end))], [0.85, 1, 0.85],'EdgeColor', 'none')
plot(L, tb(:, 2), '--', 'color', '#00008B','DisplayName', '\alpha_0 min')
plot(L, tb(:, end), '-', 'color', '#00008B', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.B, '.-', 'DisplayName', 'common multiplier B')
plot(L, tbnr(:, 2), '--', 'color', '#4682B4', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tbnr(:, end), '-', 'color', '#4682B4','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_b [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off

figure('Name','W+ taud')
hold on
set(gca,'DefaultLineLineWidth',2)
set(gca, 'FontSize', 18, 'fontName','Times');
set(gca, 'YScale', 'log')
plot(L, td(:, 2), '--', 'color', '#00008B','DisplayName', '\alpha_0 min')
plot(L, td(:, end), '-', 'color', '#00008B', 'DisplayName', '\alpha_0=1.5 rad')
plot(L, mults.D, '.-', 'DisplayName', 'common multiplier D')
plot(L, tdnr(:, 2), '--', 'color', '#4682B4', 'DisplayName', 'No Rotation, \alpha_0 min')
plot(L, tdnr(:, end), '-', 'color', '#4682B4','DisplayName', 'No Rotation, \alpha_0=1.5 rad')
set(gca, 'YScale', 'log')
ylabel('\tau_d [s]')
xlabel('L [ ]')
xlim([3, 20])
legend()
grid on
hold off

