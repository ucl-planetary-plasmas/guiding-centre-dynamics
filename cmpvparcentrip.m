function cmpvparcentrip(planet)
% function cmpvparcentrip(planet)

switch lower(planet),
  case 'jupiter'
    mdisc = 'jup_mdisc_kh3e7_rmp90';
		runit = 'R_J';
	case 'saturn',
    mdisc = 'sat_mdisc_kh2e6_rmp25';
		runit = 'R_S';
  otherwise,
	  error('unknown planet');
end

part = 'p';

naeq = 51;
steps = 10;

EPS = 1e-12;
% energy in MeV
Ep = [.001];
aeq = linspace(20,80,naeq);

lm1 = zeros(size(aeq));
lmc1 = zeros(size(aeq));
lmcv1 = zeros(size(aeq));
b1 = zeros(size(aeq));
lm2 = zeros(size(aeq));
lmc2 = zeros(size(aeq));
lmcv2 = zeros(size(aeq));
b2 = zeros(size(aeq));

opts = {'AbsTol',1e-12,'RelTol',1e-9};
d2r = pi/180;

close all

Req = 20;
tilt = 10; % degree
for i=1:length(aeq),
[lm1(i),lmc1(i),lmcv1(i),b1(i)] = mirrorlat(mdisc,part,Req,aeq(i),Ep,tilt);
lat1{i} = linspace(0,lm1(i)-EPS,200);
vp1{i} = vpar(lat1{i},aeq(i));
I1(i) = d2r*integral(@(l)1./vpar(l,aeq(i)),0,lm1(i)-EPS,...
                opts{:},'Waypoints',lm1(i));
latc1{i} = linspace(0,lmc1(i)-EPS,200);
vpc1{i} = vparc(latc1{i},aeq(i),b1(i));
Ic1(i) = d2r*integral(@(l)1./vparc(l,aeq(i),b1(i)),0,lmc1(i)-EPS,...
                opts{:},'Waypoints',lmc1(i));
vpca1{i} = vparca(latc1{i},aeq(i),b1(i));
Ica1(i) = d2r*integral(@(l)1./vparca(l,aeq(i),b1(i)),0,lmc1(i)-EPS,...
                opts{:},'Waypoints',lmc1(i));
if 0
vpca1{i} = oneovervparca(latc1{i},aeq(i),b1(i));
plot(lat1{i},1./vp1{i},latc1{i},1./vpc1{i},latc1{i},vpca1{i});
set(gca,'ylim',[0,10])
pause
Ica1(i) = d2r*integral(@(l)oneovervparca(l,aeq(i),b1(i)),0,lmc1(i)-EPS,...
                opts{:},'Waypoints',lmc1(i));
end
end

set(gcf,'position',[900, 300, 950, 800])

lgdstr = @(aeq) ['\alpha_{eq} = ' num2str(aeq,'%.1f') ' deg'];

subplot(211)
i = 1;
j = 1;
cmx = 6;
cmx = 9;
ics = 1:cmx;
ics = [1:3 7:cmx];
cs = {lat1{i},1./vp1{i},'-',latc1{i},1./vpc1{i},'-.',latc1{i},vpca1{i},':'};
hi = plot(cs{ics},'SeriesIndex',i);
h(i) = hi(1);
lgd{i} = lgdstr(aeq(i));
hold on
for i=steps+1:steps:length(aeq),
	j = j+1;
  cs = {lat1{i},1./vp1{i},'-',latc1{i},1./vpc1{i},'-.',latc1{i},vpca1{i},':'};
  hi = plot(cs{ics}, 'SeriesIndex',i);
	h(j) = hi(1);
  lgd{j} = lgdstr(aeq(i));
end
hold off
xlabel('\lambda')
ylabel('1/v_{||}')
title(['R_{eq} = ' num2str(Req) ' ' runit  ' - E = ' num2str(Ep) ' MeV'])
legend(h,lgd)
set(gca,'ylim',[0,10])

subplot(212)
plot(sind(aeq),I1,sind(aeq),Ic1,sind(aeq),Ica1)
%plot(sind(aeq),I1,sind(aeq),Ic1)
xlabel('sin(\alpha_{eq})')
ylabel('\Phi(R_{eq},\alpha_{eq})')
legend('No centrip','Centrip')
set(gca,'ylim',[0.65,1.01])

orient tall
orient landscape; set(gcf,'PaperOrientation','portrait');
% Bounds [tight]/loose
% BoundsCode [internal]/mcode
% LockAxes [1]/0
% FontMode [scaled]/fixed
% LineMode []/scaled/fixed
popts = struct('Color','cmyk',...
              'Bounds','tight',...
              'BoundsCode','mcode',...
              'FontMode','scaled','FontSize',1.0,...
              'LineMode','scaled','LineWidth',2.5,...
              'LockAxes',1);%,'Width',20,'Height',18);
exportfig(gcf,'cmpvparcentrip1.eps',popts);

figure
set(gcf,'position',[900, 300, 950, 800])


Req = 10;
%Req = 2;
for i=1:length(aeq),
[lm2(i),lmc2(i),lmcv2(i),b2(i)] = mirrorlat(mdisc,part,Req,aeq(i),Ep,tilt);
lat2{i} = linspace(0,lm2(i)-EPS,100);
vp2{i} = vpar(lat2{i},aeq(i));
I2(i) = d2r*integral(@(l)1./vpar(l,aeq(i)),0,lm2(i)-EPS,...
                opts{:},'Waypoints',lm2(i));
latc2{i} = linspace(0,lmc2(i)-EPS,100);
vpc2{i} = vparc(latc2{i},aeq(i),b2(i));
Ic2(i) = d2r*integral(@(l)1./vparc(l,aeq(i),b2(i)),0,lmc2(i)-EPS,...
                opts{:},'Waypoints',lmc2(i));
vpca2{i} = oneovervparca(latc2{i},aeq(i),b2(i));
Ica2(i) = d2r*integral(@(l)oneovervparca(l,aeq(i),b2(i)),0,lmc2(i)-EPS,...
                opts{:},'Waypoints',lmc2(i));
end

subplot(211)
i = 1;
j = 1;
cs = {lat2{i},1./vp2{i},'-',latc2{i},1./vpc2{i},'-.',latc2{i},vpca2{i},':'};
hi = plot(cs{ics},'SeriesIndex',i);
h(i) = hi(1);
lgd{i} = lgdstr(aeq(i));
hold on
for i=steps+1:steps:length(aeq),
  j = j+1;
  cs = {lat2{i},1./vp2{i},'-',latc2{i},1./vpc2{i},'-.',latc2{i},vpca2{i},':'};
  hi = plot(cs{ics},'SeriesIndex',i);
	h(j) = hi(1);
  lgd{j} = lgdstr(aeq(i));
end
hold off
xlabel('\lambda')
ylabel('1/v_{||}')
title(['R_{eq} = ' num2str(Req) ' ' runit ' - E = ' num2str(Ep) ' MeV'])
legend(h,lgd)
set(gca,'ylim',[0,10])


subplot(212)
plot(sind(aeq),I2,sind(aeq),Ic2,sind(aeq),Ica2)
%plot(sind(aeq),I2,sind(aeq),Ic2)
legend('No centrip','Centrip')
xlabel('sin(\alpha_{eq})')
ylabel('\Phi(R_{eq},\alpha_{eq})')
set(gca,'ylim',[0.65,1.01])

orient tall
orient landscape; set(gcf,'PaperOrientation','portrait');
exportfig(gcf,'cmpvparcentrip2.eps',popts);

save cmpvparcentrip

function v = vpar(lat,aeq)
v = sqrt(1-sqrt(1+3*sind(lat).^2)./cosd(lat).^6*sind(aeq)^2);
if ~isempty(find(imag(v~=0)))
v
end

function v = vparc(lat,aeq,b)
c = sqrt(1+b*(cosd(lat).^6-1));
v = c.*sqrt(1-sqrt(1+3*sind(lat).^2)./cosd(lat).^6*sind(aeq)^2./c.^2);
if ~isempty(find(imag(v~=0)))
v
end

function v = vparca(lat,aeq,b)
v0 = sqrt(1-sqrt(1+3*sind(lat).^2)./cosd(lat).^6*sind(aeq)^2);
v = v0+b/2*(cosd(lat).^6-1)./v0;
if ~isempty(find(imag(v~=0)))
v
end

function y = oneovervparca(lat,aeq,b)
v0 = sqrt(1-sqrt(1+3*sind(lat).^2)./cosd(lat).^6*sind(aeq)^2);
y = 1./v0+b/2.*(1-cosd(lat).^6).*v0;
if ~isempty(find(imag(y~=0)))
y
end


