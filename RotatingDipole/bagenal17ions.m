folder = 'D:\saboc\Documents\EPFL\PDM-UiT\Bagenal_DataBoulder\Voyager\';

%% V1
numVars = 9;
varNames = {'R_J','H+ Temperature','O+ Temperature','O++ Temperature',...
    'S+ Temperature','S++ Temperature', 'S+++ Temperature', ...
    'Na+ Temperature', 'SO2+ Temperature'};
dataStartLoc = 'F2';
varTypes = {'double', 'double', 'double', 'double', 'double', ...
    'double', 'double', 'double', 'double'};
opts = spreadsheetImportOptions('NumVariables',numVars,...
                                'VariableNames',varNames,...
                                'VariableTypes', varTypes, ...
                                'DataRange', dataStartLoc); 
filename = [folder,'V1_Data_CSV.xlsx'];
% preview(filename,opts)
data = readmatrix(filename,opts);
L = data(:,1); temp = data(:,2:end);


figure('Name','Bagenal17 Jupiter (Voyager 1)')
hold on
plot(L, temp(:,1), 'DisplayName', 'H+')
plot(L, temp(:,2), 'DisplayName', 'O+')
plot(L, temp(:,3), 'DisplayName', 'O++')
plot(L, temp(:,4), 'DisplayName', 'S+')
plot(L, temp(:,5), 'DisplayName', 'S++')
plot(L, temp(:,6), 'DisplayName', 'S+++')
plot(L, temp(:,7), 'DisplayName', 'Na+')
plot(L, temp(:,8), 'DisplayName', 'SO2+')
xlabel('R [Rs]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off


%% V2
numVars = 10;
varNames = {'R_J','H+ Temperature','O+ Temperature','O++ Temperature',...
    'S+ Temperature','S++ Temperature', 'S+++ Temperature', ...
    'Na+ Temperature', 'SO2+ Temperature', 'Hot O+ Temperature'} ;
dataStartLoc = 'F2';
varTypes = {'double', 'double', 'double', 'double', 'double', ...
    'double', 'double', 'double', 'double', 'double'};
opts = spreadsheetImportOptions('NumVariables',numVars,...
                                'VariableNames',varNames,...
                                'VariableTypes', varTypes, ...
                                'DataRange', dataStartLoc); 
filename = [folder,'V2_Data_CSV.xlsx'];
% preview(filename,opts)
data = readmatrix(filename,opts);
L = data(:,1); temp = data(:,2:end);


figure('Name','Bagenal17 Jupiter (Voyager 2)')
hold on
plot(L, temp(:,1), 'DisplayName', 'H+')
plot(L, temp(:,2), 'DisplayName', 'O+')
plot(L, temp(:,3), 'DisplayName', 'O++')
plot(L, temp(:,4), 'DisplayName', 'S+')
plot(L, temp(:,5), 'DisplayName', 'S++')
plot(L, temp(:,6), 'DisplayName', 'S+++')
plot(L, temp(:,7), 'DisplayName', 'Na+')
plot(L, temp(:,8), 'DisplayName', 'SO2+')
plot(L, temp(:,9), 'DisplayName', 'HOT O+')
xlabel('R [Rs]')
ylabel('Temperature [eV]')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Location', 'SouthEast')
grid on
hold off