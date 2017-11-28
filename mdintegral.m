function mdintegral(mdiscfile)

s = readMdisc(mdiscfile);

t0 = pi/10;
plot1(s, t0);

pause

r1 = 5; r2 = 20;
[c1d,c2d,c1m,c2m] = plot2(s,r1,r2);

pause

plot3(s)

pause

plot4(s,r1,r2,c1d,c2d,c1m,c2m)

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
polarplot(ti,c1d.r(sin(ti)),ti,c1m.r(sin(ti)))
subplot(232)
plot(ti,D1t(c1d.r,ti),ti,D1t(c1m.r,ti),ti,Dct(c1d.rt,ti),ti,Dct(c1m.rt,ti))
subplot(233)
plot(ti,D1tt(c1d.r,ti),ti,D1tt(c1m.r,ti),ti,Dctt(c1d.rt,ti),ti,Dctt(c1m.rt,ti))
subplot(234),
polarplot(ti,c2d.r(sin(ti)),ti,c2m.r(sin(ti)))
subplot(235)
plot(ti,D1t(c2d.r,ti),ti,D1t(c2m.r,ti),ti,Dct(c2d.rt,ti),ti,Dct(c2m.rt,ti))
subplot(236)
plot(ti,D1tt(c2d.r,ti),ti,D1tt(c2m.r,ti),ti,Dctt(c2d.rt,ti),ti,Dctt(c2m.rt,ti))
legend({'D1(d)','D1(m)','Dc(d)','Dc(m)'})

function plot3(s)

fprintf(1,'lmd = %f\n', getLmd(s,10))

Li = [1:.5:40]';
Lmdi = getLmd(s,Li);
subplot(211), 
plot(Li,[Li,Lmdi])
set(gca,'xlim',[0,40]);
subplot(212), 
plot(Li,[Li,Lmdi]),
set(gca,'xlim',[0,15]);


function plot4(s,r1,r2,c1d,c2d,c1m,c2m)

tmn = asin(max([c1m.mn,c2m.mn]));
tmx = asin(min([c1m.mx,c2m.mx]));

clf

EPS = 2e-1;
ti = linspace(tmn,tmx,151)';

plot(ti, s.md.B(c1m.rt(0),sin(0))./s.md.B(c1m.rt(ti),sin(ti)),...
     ti, s.md.B(c2m.rt(0),sin(0))./s.md.B(c2m.rt(ti),sin(ti)))

fprintf(1,'%f ',...
[getLC(s,'m',c1m), getLC(s,'m',c2m),...
 getLC(s,'d',c1d), getLC(s,'d',c2d),...
 getLCd(r1),getLCd(r2)]);
fprintf(1,'\n');
