% Models of E_0(L) for Jupiter and Saturn
% Based on temperature measurment (E_0 = kbT)
% fct species, thermal/suprathermal/hot, instruments/authors

%% Jupiter 

% L: 5 to 10
L = linspace(5, 10, 50);
ec86 = caudal86cold(L);
eb81s = bagenal81spp(L);
eb81o = bagenal81op(L);
eb94ti = bagenal94thions(L);
eb94te = bagenal94thelec(L);
eb94he = bagenal94hotelec(L);
eb94hiperp = bagenal94hotionsperp(L);
eb94hipar = bagenal94hotionspar(L);

figure('Name','Jupiter L:5-10')
hold on
plot(L, ec86, 'DisplayName', 'caudal86 cold')
plot(L, eb81s, ':b', 'DisplayName', 'bagenal81 spp')
plot(L, eb81o, '--b', 'DisplayName', 'bagenal81 op')
plot(L, eb94ti, 'c', 'DisplayName', 'bagenal94 th ions')
plot(L, eb94te, '-.c', 'DisplayName', 'bagenal94 th elec')
plot(L, eb94he, '-.m', 'DisplayName', 'bagenal94 hot elec')
plot(L, eb94hiperp, 'm', 'DisplayName', 'bagenal94 hot ions perp')
plot(L, eb94hipar, 'm', 'DisplayName', 'bagenal94 hot ions par')
xlabel('L [ ]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off

% L: 5 to 20
L = linspace(5, 20, 50);
mauk96hhp = mauk96hothp(L);
mauk96hop = mauk96hotop(L);
mauk96he = mauk96hotelec(L);
% new L, compute again: 
eb94he = bagenal94hotelec(L);
eb94hiperp = bagenal94hotionsperp(L);
eb94hipar = bagenal94hotionspar(L);
% points from bagenal11
l  = [5.9, 7, 8, 10, 15, 20, 25, 30, 50];
bagjup = [20, 40, 80, 175, 500, 550, 650, 700, 750];
% colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980;0.9290 0.6940 0.1250; ...
%     0.9290 0.6940 0.1250; 0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; ...
%     0.3010 0.7450 0.9330;0.6350 0.0780 0.1840];
% styles = {'-','--','-.', ':'};
%             'LineWidth', 1.75, 'Color', c,'LineStyle', s)
figure('Name','Jupiter L:5-20')
hold on
plot(L, mauk96hhp, 'DisplayName', 'mauk1996 hot ion H+')
plot(L, mauk96hop, 'DisplayName', 'mauk1996 hot ion O+')
plot(L, mauk96he, 'DisplayName', 'mauk1996 hot elec')
% for compa
plot(L, eb94he, 'DisplayName', 'bagenal94 hot elec')
plot(L, eb94hiperp, 'DisplayName', 'bagenal94 hot ions perp')
plot(L, eb94hipar, 'DisplayName', 'bagenal94 hot ions par')
% bagenal
plot(l(1:6), bagjup(1:6), '-+', 'DisplayName', 'bagenal11 thermal ions')
xlabel('L [ ]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off

%% Saturn

L = linspace(3, 20, 50);
% L = linspace(6.5, 16.5, 50);
thomsen10w = thomsen10wp(L);
thomsen10h = thomsen10hp(L);
thomsen10h2 = thomsen10h2p(L);
% L = linspace(3, 20, 50);
bagenal11w = bagenal11satwp(L);
bagenal11h = bagenal11sathp(L);
bagenal11h2 = bagenal11sath2p(L);
% L = linspace(3.5, 10.2, 50);
sittler08e = sittler08elec(L);
% L = linspace(3.5, 10, 50);
sittler06w = sittler06wp(L);
sittler06h = sittler06hp(L);

figure('Name','Saturn')
hold on
plot(L, thomsen10w, '-', 'DisplayName', 'thomsen10 W+')
plot(L, thomsen10h, '--', 'DisplayName', 'thomsen10 H+')
plot(L, thomsen10h2, '-.', 'DisplayName', 'thomsen10 H2+')
plot(L,bagenal11w, '-', 'DisplayName', 'bagenal11 W+')
plot(L, bagenal11h, '--', 'DisplayName', 'bagenal11 H+')
plot(L, bagenal11h2, '-.', 'DisplayName', 'bagenal11 H2+')
plot(L, sittler06w, '-', 'DisplayName', 'sittler08 W+')
plot(L, sittler06h, '--', 'DisplayName', 'sittler08 H+')
plot(L, sittler08e, ':', 'DisplayName', 'sittler08 e-')
xlabel('L [ ]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off
