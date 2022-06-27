filename = 'D:\saboc\Documents\EPFL\PDM-UiT\Bagenal_DataBoulder\privateCommunication\bagenal2011_data.xlsx';
opts = detectImportOptions(filename);
opts.Sheet = 'Bagenal2011';
opts.DataRange = 'A4:D47';
data = readmatrix(filename,opts);
%A: R; B: W+; C: H2+; D: H+;
L = data(:,1); temp=data(:,2:end);

figure('Name','Bagenal11 Fig 4 Saturn (Cassini)')
hold on
title('Saturn (Cassini CAPS data)')
plot(L, temp(:,1), 'DisplayName', 'W+')
plot(L, temp(:,2), 'DisplayName', 'H2+')
plot(L, temp(:,3), 'DisplayName', 'H+')
xlabel('R [Rs]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off