function mdintegral(mdiscfile)

s = readMdisc(mdiscfile);

t0 = pi/10;
plot1(s, t0);

pause

r1 = 5; r2 = 20;
[c1d,c2d,c1m,c2m] = plot2(s,r1,r2);

pause

r0 = 10;
plot3(s, r0)

pause

plot4(s,c1d,c2d,c1m,c2m)

pause

plot5(s,c1d,c2d,c1m,c2m)

pause

r3 = 2;
plot6(s,r3)

pause

plot7(s,c1d,c2d,c1m,c2m)

function plot1(s, t0)

ri = [s.MD.dims.r(1):s.MD.dims.r(end)]';
s0 = sin(t0)*ones(size(ri));

subplot(231), 
plot(ri,s.dip.a(ri,s0),ri,s.md.a(ri,s0))
set(gca,'xlim',[0,90],'ylim',[0,.16])
subplot(232)
plot(ri,D2r(s.dip.a,ri,s0),ri,D2r(s.md.a,ri,s0))
set(gca,'xlim',[0,90],'ylim',[-7e-3,0])
subplot(233)
plot(ri,D2rr(s.dip.a,ri,s0),ri,D2rr(s.md.a,ri,s0))
set(gca,'xlim',[0,90],'ylim',[-2e-4,8e-4])
subplot(234), 
plot(ri,s.dip.B(ri,s0),ri,s.md.B(ri,s0))
set(gca,'xlim',[0,90],'ylim',[0,7e-4])
subplot(235)
plot(ri,D2r(s.dip.B,ri,s0),ri,D2r(s.md.B,ri,s0))
set(gca,'xlim',[0,90],'ylim',[-1e-4,0])
subplot(236)
plot(ri,D2rr(s.dip.B,ri,s0),ri,D2rr(s.md.B,ri,s0))
set(gca,'xlim',[0,90],'ylim',[-5e-6,25e-6])


function [c1d,c2d,c1m,c2m] = plot2(s,r1,r2)

c1d = getMFc(s,'d',r1);
c2d = getMFc(s,'d',r2);
fprintf(1,'%f ', [c1d.r(sin([0,.5])),asin([c1d.mn,c1d.mx,c2d.mn,c2d.mx])]);
fprintf(1,'\n');

c1m = getMFc(s,'m',r1);
c2m = getMFc(s,'m',r2);
fprintf(1,'%f ', [c1m.r(sin([0,.5])),asin([c1m.mn,c1m.mx,c2m.mn,c2d.mx])]);
fprintf(1,'\n');

tmn = asin(max([c1d.mn,c2d.mn,c1m.mn,c2m.mn]));
tmx = asin(min([c1d.mx,c2d.mx,c1m.mx,c2m.mx]));

clf
EPS = 2e-1;
ti = linspace(tmn*(1-EPS),tmx*(1-EPS),100)';

subplot(231),
polarplot(ti,c1d.rt(ti),ti,c1m.rt(ti))
subplot(232)
plot(ti,D1t(c1d.r,ti),ti,D1t(c1m.r,ti),...
     ti,Dct(c1d.rt,ti),ti,Dct(c1m.rt,ti),...
     ti,c1d.drt(ti),ti,c1m.drt(ti))
subplot(233)
plot(ti,D1tt(c1d.r,ti),ti,D1tt(c1m.r,ti),...
     ti,Dctt(c1d.rt,ti),ti,Dctt(c1m.rt,ti),...
		 ti,c1d.d2rtt(ti),ti,c1m.d2rtt(ti))
subplot(234),
polarplot(ti,c2d.rt(ti),ti,c2m.rt(ti))
subplot(235)
plot(ti,D1t(c2d.r,ti),ti,D1t(c2m.r,ti),...
     ti,Dct(c2d.rt,ti),ti,Dct(c2m.rt,ti),...
		 ti,c2d.drt(ti),ti,c2m.drt(ti))
subplot(236)
plot(ti,D1tt(c2d.r,ti),ti,D1tt(c2m.r,ti),...
     ti,Dctt(c2d.rt,ti),ti,Dctt(c2m.rt,ti),...
		 ti,c2d.d2rtt(ti),ti,c2m.d2rtt(ti))
legend({'D1(d)','D1(m)','Dc(d)','Dc(m)','Di(d)','Di(m)'})

function plot3(s,r)

fprintf(1,'lmd = %f\n', getLmd(s,r))

Li = [1:.5:40]';
Lmdi = getLmd(s,Li);
subplot(211), 
plot(Li,[Li,Lmdi])
set(gca,'xlim',[0,40]);
subplot(212), 
plot(Li,[Li,Lmdi]),
set(gca,'xlim',[0,15]);


function plot4(s,c1d,c2d,c1m,c2m)

tmn = max([c1m.tmn,c2m.tmn]);
tmx = min([c1m.tmx,c2m.tmx]);

clf

ti = linspace(tmn,tmx,151)';

plot(ti, s.md.B(c1m.rt(0),sin(0))./s.md.B(c1m.rt(ti),sin(ti)),...
     ti, s.md.B(c2m.rt(0),sin(0))./s.md.B(c2m.rt(ti),sin(ti)))

fprintf(1,'%f ',...
[getLC(s,c1m), getLC(s,c2m),...
 getLC(s,c1d), getLC(s,c2d),...
 getLCd(c1d.r0),getLCd(c2d.r0)]);
fprintf(1,'\n');

function plot5(s,c1d,c2d,c1m,c2m)

beta0 = pi/4;
fprintf(1,'%f ',...
[getLatMP(s,c1m,beta0),getLatMP(s,c2m,beta0),...
 getLatMP(s,c1d,beta0),getLatMP(s,c2d,beta0),...
 getLatMPd(c1d.r0,beta0),getLatMPd(c2d.r0,beta0)]);
fprintf(1,'\n');

b1 = linspace(getLC(s,c1m),pi/2,50);
b2 = linspace(getLC(s,c2m),pi/2,50);
plot(b1,getLatMP(s,c1m,b1),...
     b2,getLatMP(s,c2m,b2));

function plot6(s,r3)

c3d = getMFc(s,'d',r3);
c3m = getMFc(s,'m',r3);

EPS = 1e-2;

fprintf(1,'%f ',...
[pi/10,pi/12,getLC(s,c3m),getLatMP(s,c3m,getLC(s,c3m))+EPS])
fprintf(1,'\n');

ri = [2:2:16]';
lid = zeros(length(ri),4);
lim = zeros(length(ri),4);
for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
  bd{i} = [pi/3,pi/4,pi/6,getLC(s,cd{i})+EPS];
	lid(i,:) = 180/pi*getLatMP(s,cd{i},bd{i});
  cm{i} = getMFc(s,'m',ri(i));
  bm{i} = [pi/3,pi/4,pi/6,getLC(s,cm{i})+EPS];
	lim(i,:) = 180/pi*getLatMP(s,cm{i},bm{i});
end


co = [0 0 1;
      0 0.5 0;
      1 0 0;
      0 0.75 0.75];
set(0,'DefaultAxesColorOrder',co);
plot(ri,lid,'--',ri,lim);

clf
plot(ri,lid,'--',ri,lim);

function plot7(s,c1d,c2d,c1m,c2m)

beta = pi/6;

fprintf(1,'%f ',...
[testint(s,c1d,beta),testint(s,c2d,beta),...
 testint(s,c1m,beta),testint(s,c2m,beta)]);
fprintf(1,'\n');

l1d = getLatMP(s,c1d,beta); t1d = linspace(-l1d,l1d,100);
l2d = getLatMP(s,c2d,beta); t2d = linspace(-l2d,l2d,100);
l1m = getLatMP(s,c1m,beta); t1m = linspace(-l1m,l1m,100);
l2m = getLatMP(s,c2m,beta); t2m = linspace(-l2m,l2m,100);

polarplot(t1d, c1d.rt(t1d), t2d, c2d.rt(t2d),...
          t1m, c1m.rt(t1m), t2m, c2m.rt(t2m))

