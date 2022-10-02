function [L, T] = dataBag11Sat(partname, Bfig)
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
L = data(3:end,1); 
if strcmp(partname, 'wp'), T = data(3:end,2); end
if strcmp(partname, 'h2p'), T = data(3:end,3); end
if strcmp(partname, 'hp'), T = data(3:end,4); end

if Bfig
    figure('Name','Bagenal11 Fig 4 Saturn (Cassini)')
    hold on
    set(gca,'DefaultLineLineWidth',2)
    set(gca, 'FontSize', 18, 'fontName','Times');
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    %title('Saturn (Cassini CAPS data)')
    temp=data(3:end,2:end);
    plot(L, temp(:,3), 'color', '#006400', 'DisplayName', 'H^+')
    plot(L, temp(:,2),'color', '#8B0000','DisplayName', 'H_2^+')
    plot(L, temp(:,1),'color', '#00008B', 'DisplayName', 'W^+')
    xlabel('L [ ]')
    ylabel('Temperature [eV]')
    legend('Location', 'SouthEast')
    grid on
    hold off
end

return