filename = 'D:\saboc\Documents\EPFL\PDM-UiT\Bagenal_DataBoulder\privateCommunication\bagenal2011_data.xlsx';
numVars = 4;
varNames = {'Radial distance at the equator',...
    'Temperature W+   Thomsen >6 Sittler <6',...
    'Temperature H2+   Average T(W+) T(H+)', ...
    'Temperature H+   Thomsen >6 Sittler <6'};
dataStartLoc = 'A2';
varTypes = {'double', 'double', 'double', 'double'};
opts = spreadsheetImportOptions('NumVariables',numVars,...
                                'VariableNames',varNames,...
                                'VariableTypes', varTypes, ...
                                'DataRange', dataStartLoc, ...
                                'Sheet','Bagenal2011'); 
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

%% With T10 and S8 data
thomsen10w = thomsen10wp(L);
thomsen10h = thomsen10hp(L);
thomsen10h2 = thomsen10h2p(L);
sittler06w = sittler06wp(L);
sittler06h = sittler06hp(L);
sittler08e = sittler08elec(L);

figure('Name','Saturn (Cassini)')
hold on
title('Saturn (Cassini CAPS data)')
plot(L, temp(:,1), 'DisplayName', 'W+')
plot(L, temp(:,2), 'DisplayName', 'H2+')
plot(L, temp(:,3), 'DisplayName', 'H+')
%Thomson
plot(L, thomsen10w, '-- b', 'DisplayName', 'thomsen10 W+')
plot(L, thomsen10h, '-- y', 'DisplayName', 'thomsen10 H+')
plot(L, thomsen10h2, '-- r', 'DisplayName', 'thomsen10 H2+')
%Sittler
plot(L, sittler06w, '.-b','DisplayName', 'sittler06 W+')
plot(L, sittler06h, '.-y','DisplayName', 'sittler06 H+')
plot(L, sittler08e, '-g','DisplayName', 'sittler08 e-')

xlabel('R [Rs]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off
