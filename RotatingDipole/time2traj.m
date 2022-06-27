older = 'D:\saboc\Documents\EPFL\PDM-UiT\Bagenal_DataBoulder\Voyager\';

%% V1
numVars = 7;
varNames = {'Day', 'Hour', 'Minute', 'Second', ...
    'R_J', 'R_Theta', 'R_phi'};
dataStartLoc = 'B2';
varTypes = {'double', 'double', 'double', 'double', ...
    'double', 'double', 'double'};
opts = spreadsheetImportOptions('NumVariables',numVars,...
                                'VariableNames',varNames,...
                                'VariableTypes', varTypes, ...
                                'DataRange', dataStartLoc); 
filename = [folder,'V1_Data_CSV.xlsx'];

data = readmatrix(filename,opts);
dd = data(:,1); 
% convert hours, minutes, seconds, to hours
hh = data(:,2)+ data(:,3)./60 + data(:,4)./3600;

% Position:
rj = data(:, 5); %in R_J
rt = data(:, 6); % in degree
rhospin = rj.*cosd(rt);

%Select day 64 only:
i64 = find(dd==64);
hh64 = hh(i64);
rho64 = rhospin(i64);
% plot(hh64, rho64)
% plot(rho64, hh64)

%% Time points of electrons properties
filename = [folder,'electron_properties.xlsx'];
time = readmatrix(filename, 'Range','A2:A242');

%Interpolation
rho = interp1(hh64,rho64,time);
plot(rho, time, '+-');