function testcentrip

nE = 25;

Ep = logspace(log10(.001),log10(1),nE);
lm1 = zeros(size(Ep));
lmc1 = zeros(size(Ep));
lmcv1 = zeros(size(Ep));
lm2 = zeros(size(Ep));
lmc2 = zeros(size(Ep));
lmcv2 = zeros(size(Ep));

Req = 20;
aeq = 20;
theta = 10;
for i=1:length(Ep),
[lm1(i),lmc1(i),lmcv1(i)] = mirrorlat('jup_mdisc_kh3e7_rmp90','p',Req,aeq,Ep(i),theta);
end

if 0
subplot(211)
semilogx(Ep,lm,Ep,lmc)
xlabel('E [MeV]')
ylabel('\lambda_m [deg]')
end
str1 = sprintf('R_{eq}=%dR_J \\alpha_{eq}=%d deg',Req,aeq);
%title(str)
legend({[str1 'no Fc'],[str1 ' w/ Fc']})


Req = 10;
aeq = 20;
for i=1:length(Ep),
[lm2(i),lmc2(i),lmcv2(i)] = mirrorlat('jup_mdisc_kh3e7_rmp90','p',Req,aeq,Ep(i),theta);
end

%subplot(212)
semilogx(Ep,lm1,Ep,lmc1,Ep,lm2,Ep,lmc2)
xlabel('E [MeV]')
ylabel('\lambda_m [deg]')
str2 = sprintf('R_{eq}=%dR_J \\alpha_{eq}=%d deg',Req,aeq);
%title(str)
legend({[str1 ' w/o Fc'],[str1 ' w/ Fc'],[str2 ' w/o Fc'],[str2 ' w/ Fc']},...
'Location','SouthEast')

orient tall
%orient landscape; set(gcf,'PaperOrientation','portrait');
% Bounds [tight]/loose
% BoundsCode [internal]/mcode
% LockAxes [1]/0
% FontMode [scaled]/fixed
% LineMode []/scaled/fixed
opts = struct('Color','cmyk',...
              'Bounds','tight',...
              'BoundsCode','mcode',...
              'FontMode','scaled','FontSize',1.0,...
              'LineMode','scaled','LineWidth',2.5,...
              'LockAxes',1);%,'Width',20,'Height',18);
exportfig(gcf,'testcentrip.eps',opts);

figure
semilogx(Ep,lm1,Ep,lmcv1,Ep,lm2,Ep,lmcv2)
xlabel('E [MeV]')
ylabel('\lambda_m [deg]')
str2 = sprintf('R_{eq}=%dR_J \\alpha_{eq}=%d deg',Req,aeq);
%title(str)
legend({[str1 ' w/o Fc'],[str1 ' w/ Fc'],[str2 ' w/o Fc'],[str2 ' w/ Fc']},...
'Location','SouthEast')

save centrip
