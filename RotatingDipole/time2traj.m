folder = 'D:\saboc\Documents\EPFL\PDM-UiT\Bagenal_DataBoulder\Voyager\';

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

% %% Position from VIP4_CAN %%%PBMs
% filename = [folder,'Spacecraft_trajectory_vip4_can.xlsx'];
% 
% numVars = 7;
% varNames = {'Time', 'Radius_sc', 'Theta_sc', ...
%     'Radius_mag', 'Theta_mag', 'Radius_Cent, Theta_cent'};
% dataStartLoc = 'A2';
% varTypes = {'double', 'double', 'double', 'double', ...
%     'double', 'double'};%%, 'double'};
% opt = spreadsheetImportOptions('NumVariables',numVars,...
%                                 'VariableNames',varNames,...
%                                 'VariableTypes', varTypes, ...
%                                 'DataRange', dataStartLoc); 
% data = readmatrix(filename,opt);
% day = fix(data(:,1));
% hours = (data(:,1) -day).*24;
% 
% rho_sc = data(:, 2).*cosd(data(:,3));
% rho_mag = data(:, 4).*cosd(data(:,5));
% % rho_cent = data(:,6).*cosd(data(:,7));
% 
% j64 = find(day==64);
% 
% %Compa %%STRANGE !
% figure
% hold on
% plot(hh64, rho64, 'k-')
% plot(hours(j64), rho_sc(j64))
% plot(hours(j64), rho_mag(j64))
% plot(hours(j64), rho_cent(j64))
% xlabel('time')
% ylabel('r')
% grid on
% hold off

%% Time points of electrons properties
filename = [folder,'electron_properties.xlsx'];
time = readmatrix(filename, 'Range','A2:A242');

%Interpolation
rho = interp1(hh64,rho64,time);

figure
hold on
plot(rho64, hh64, 'k-')
plot(rho, time, '+')