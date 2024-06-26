function mdintegral(mdiscfile)
% function mdintegral(mdiscfile)

%
% $Id: mdintegral.m,v 1.26 2019/06/10 14:25:42 patrick Exp $
%
% Copyright (c) 2018 Patrick Guio <patrick.guio@gmail.com>
% All Rights Reserved.
%
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by the
% Free Software Foundation; either version 3 of the License, or (at your
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
% Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.

s = readMdisc(mdiscfile);

plot1(s);

[c1d,c2d,c1m,c2m] = plot2(s);

plot3(s)

plot4(s,c1d,c2d,c1m,c2m)

plot5(s,c1d,c2d,c1m,c2m)

plot6(s)

plot7(s,c1d,c2d,c1m,c2m)

plot8(s)

plot9(s,mdiscfile)

plot10(s,mdiscfile)

plot11(s)

plot12(s,mdiscfile)

plot13(s,mdiscfile)


function plot1(s)

fprintf(1,'plot1\n');

t0 = pi/10;
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

fprintf(1,'Press return\n');
pause

function [c1d,c2d,c1m,c2m] = plot2(s)

fprintf(1,'plot2\n');

r1 = 5; 
r2 = 20;

c1d = getMFc(s,'d',r1);
c2d = getMFc(s,'d',r2);
fprintf(1,'%f ', [c1d.rt([0,.5]),[c1d.tmn,c1d.tmx,c2d.tmn,c2d.tmx]]);
fprintf(1,'\n');

c1m = getMFc(s,'m',r1);
c2m = getMFc(s,'m',r2);
fprintf(1,'%f ', [c1m.rt([0,.5]),[c1m.tmn,c1m.tmx,c2m.tmn,c2m.tmx]]);
fprintf(1,'\n');

tmn = max([c1d.tmn,c2d.tmn,c1m.tmn,c2m.tmn]);
tmx = min([c1d.tmx,c2d.tmx,c1m.tmx,c2m.tmx]);

c1e = getMFcd(s,'d',r1);
c2e = getMFcd(s,'d',r2);

clf
% Avoid boundary effects for derivatives
EPS = 1e-1;
ti = linspace(tmn*(1-EPS),tmx*(1-EPS),100)';

subplot(231),
h=polarplot(ti,c1d.rt(ti),ti,c1m.rt(ti),ti,c1e.rt(ti));
set(h(end),'LineStyle',':');
subplot(232)
plot(...%ti,D1t(c1d.r,ti),ti,D1t(c1m.r,ti),...
     ...%ti,Dct(c1d.rt,ti),ti,Dct(c1m.rt,ti),...
     ti,c1d.drt(ti),ti,c1m.drt(ti),...
		 ti,c1e.drt(ti),':')
subplot(233)
plot(...%ti,D1tt(c1d.r,ti),ti,D1tt(c1m.r,ti),...
     ...%ti,Dctt(c1d.rt,ti),ti,Dctt(c1m.rt,ti),...
		 ti,c1d.d2rtt(ti),ti,c1m.d2rtt(ti),...
		 ti,c1e.d2rtt(ti),':')
subplot(234),
h=polarplot(ti,c2d.rt(ti),ti,c2m.rt(ti),ti,c2e.rt(ti));
set(h(end),'LineStyle',':');
subplot(235)
plot(...%ti,D1t(c2d.r,ti),ti,D1t(c2m.r,ti),...
     ...%ti,Dct(c2d.rt,ti),ti,Dct(c2m.rt,ti),...
		 ti,c2d.drt(ti),ti,c2m.drt(ti),...
		 ti,c2e.drt(ti),':')
subplot(236)
plot(...%ti,D1tt(c2d.r,ti),ti,D1tt(c2m.r,ti),...
     ...%ti,Dctt(c2d.rt,ti),ti,Dctt(c2m.rt,ti),...
		 ti,c2d.d2rtt(ti),ti,c2m.d2rtt(ti),...
		 ti,c2e.d2rtt(ti),':')
%legend({'D1(d)','D1(m)','Dc(d)','Dc(m)','Di(d)','Di(m)','De(d)'})
legend({'Di(d)','Di(m)','De(d)'})

fprintf(1,'Press return\n');
pause

function plot3(s,r)

fprintf(1,'plot3\n');

r = 10;
fprintf(1,'r=%f lmd=%f\n', r, getLmd(s,r))

Li = [1:.5:40]';
Lmdi = getLmd(s,Li);
subplot(211), 
plot(Li,[Li,Lmdi])
set(gca,'xlim',[0,40]);
subplot(212), 
plot(Li,[Li,Lmdi]),
set(gca,'xlim',[0,15]);

fprintf(1,'Press return\n');
pause

function plot4(s,c1d,c2d,c1m,c2m)

fprintf(1,'plot4\n');

tmn = max([c1m.tmn,c2m.tmn]);
tmx = min([c1m.tmx,c2m.tmx]);
n = max([c1m.nrt,c2m.nrt]);

clf

ti = linspace(tmn,tmx,n)';
si = sin(ti);

plot(ti, s.md.B(c1m.rt(0),0)./s.md.B(c1m.rt(ti),si),...
     ti, s.md.B(c2m.rt(0),0)./s.md.B(c2m.rt(ti),si))

fprintf(1,'%f ',...
[getLC(s,c1m), getLC(s,c2m),...
 getLC(s,c1d), getLC(s,c2d),...
 getLCd(c1d.r0),getLCd(c2d.r0)]);
fprintf(1,'\n');

fprintf(1,'Press return\n');
pause

function plot5(s,c1d,c2d,c1m,c2m)

fprintf(1,'plot5\n');

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

fprintf(1,'Press return\n');
pause

function plot6(s)

fprintf(1,'plot6\n');

r3 = 2;
c3d = getMFc(s,'d',r3);
c3m = getMFc(s,'m',r3);

EPS = 1e-6;

fprintf(1,'%f ',...
[pi/10,pi/12,getLC(s,c3m),getLatMP(s,c3m,getLC(s,c3m)+EPS)])
fprintf(1,'\n');

ri = linspace(2,16,10)';
lid = zeros(length(ri),4);
lim = zeros(length(ri),4);
bd = [pi/3,pi/4,pi/6,getLC(s,c3d)+EPS];
bm = [pi/3,pi/4,pi/6,getLC(s,c3m)+EPS];
for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
	lid(i,:) = 180/pi*getLatMP(s,cd{i},bd);
  cm{i} = getMFc(s,'m',ri(i));
	lim(i,:) = 180/pi*getLatMP(s,cm{i},bm);
end

co = [0 0 1;
      0 0.5 0;
      1 0 0;
      0 0.75 0.75];
set(0,'DefaultAxesColorOrder',co);
plot(ri,lid,'--',ri,lim);
set(gca,'ylim',[0 50])

fprintf(1,'Press return\n');
pause

function plot7(s,c1d,c2d,c1m,c2m)

fprintf(1,'plot7\n');

beta = pi/6;

l1d = getLatMP(s,c1d,beta); t1d = linspace(-l1d,l1d,100);
l2d = getLatMP(s,c2d,beta); t2d = linspace(-l2d,l2d,100);
l1m = getLatMP(s,c1m,beta); t1m = linspace(-l1m,l1m,100);
l2m = getLatMP(s,c2m,beta); t2m = linspace(-l2m,l2m,100);

fprintf(1,'%f ',l1d,l2d,l1m,l2m);
fprintf(1,'\n');

polarplot(t1d, c1d.rt(t1d), t2d, c2d.rt(t2d),...
          t1m, c1m.rt(t1m), t2m, c2m.rt(t2m))

fprintf(1,'%f ',...
[testint(s,c1d,beta),testint(s,c2d,beta),...
 testint(s,c1m,beta),testint(s,c2m,beta)]);
fprintf(1,'\n');

fprintf(1,'Press return\n');

pause

function plot8(s)

fprintf(1,'plot8\n');

r = 10;
cm = getMFc(s,'m',r);
cd = getMFc(s,'d',r);
beta = pi/6;
lm = getLatMP(s,cm,beta); tm = linspace(0,lm,100);
ld = getLatMP(s,cd,beta); td = linspace(0,ld,100);
polarplot(tm, cm.rt(tm), td, cd.rt(td));
legend({'md','dip'})

[I1m,I2m] = testint2(s,cm,beta);
[I1d,I2d] = testint2(s,cd,beta);

fprintf(1,'%f ',I1m,I2m,I1d,I2d)
fprintf(1,'\n');


fprintf(1,'Press return\n');

pause

function plot9(s,planet)

fprintf(1,'plot9\n');

EPS = 1e-6;

ri = [2,5,10];
nb = 10;
phid = zeros(length(ri),nb);
phim = zeros(length(ri),nb);
phie = zeros(length(ri),nb);
phia = zeros(length(ri),nb);
phib = zeros(length(ri),nb);

% use loss cone of smaller r as smallest pitch angle
bmnd = getLC(s,getMFc(s,'d',ri(1)))+EPS;
bd = linspace(bmnd,pi/3,nb);
bmnm = getLC(s,getMFc(s,'m',ri(1)))+EPS;
bm = linspace(bmnm,pi/3,nb);
for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
	phid(i,:) = Phi(s,cd{i},bd);

  cm{i} = getMFc(s,'m',ri(i));
	phim(i,:) = Phi(s,cm{i},bm);

	phie(i,:) = Phid(ri(i),bd);
	phia(i,:) = Phia('d',ri(i),bd,planet);
	phib(i,:) = Phia('m',ri(i),bm,planet);
end

co = [0 0 1;
      0 0.5 0;
      1 0 0];
set(0,'DefaultAxesColorOrder',co);
subplot(211), 
plot(bd,phid,'--')
hold on
plot(bd,phie);
plot(bd,phia,':');
hold off

subplot(212), 
plot(bm,phim);
hold on
plot(bm,phib,':');
hold off
xlabel('\alpha_{eq}')

fprintf(1,'Press return\n');
pause

function plot10(s,planet)

fprintf(1,'plot10\n');

EPS = 1e-6;

ri = [2:2:14];
nb = 4;

phid = zeros(length(ri),nb);
phim = zeros(length(ri),nb);
phie = zeros(length(ri),nb);
phia = zeros(length(ri),nb);
phib = zeros(length(ri),nb);

% use loss cone of smaller r as smallest pitch angle
bmnd = getLC(s,getMFc(s,'d',ri(1)))+EPS;
bd = [pi/3,pi/4,pi/6,bmnd];
bmnm = getLC(s,getMFc(s,'m',ri(1)))+EPS;
bm = [pi/3,pi/4,pi/6,bmnm];
for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
	phid(i,:) = Phi(s,cd{i},bd);

  cm{i} = getMFc(s,'m',ri(i));
	phim(i,:) = Phi(s,cm{i},bm);

	phie(i,:) = Phid(ri(i),bd);
	phia(i,:) = Phia('d',ri(i),bd,planet);
	phib(i,:) = Phia('m',ri(i),bm,planet);
end

co = [0 0 1;
      0 0.5 0;
      1 0 0;
      0 0.75 0.75];
set(0,'DefaultAxesColorOrder',co);
subplot(211), 
plot(ri,phid,'--')
hold on
plot(ri,phie);
plot(ri,phia,':');
hold off

subplot(212), 
plot(ri,phim);
hold on
plot(ri,phib,':');
hold off
xlabel('r_{eq}')

fprintf(1,'Press return\n');
pause

function plot11(s)

fprintf(1,'plot11\n');

r = 10;
beta = pi/6;
cd = getMFc(s,'d',r);
ce = getMFcd(s,'d',r);
cm = getMFc(s,'m',r);

omdc = Omegadc(r,beta);
omc = Omegac(s,ce,beta); 
omdg = Omegadg(r,beta); 
omg = Omegag(s,ce,beta);
omd  = Omegad(r,beta);
om = Omega(s,ce,beta);
fprintf(1,'%f ',[omdc,omdg,omd,omdc+omdg]);
fprintf(1,'\n');
fprintf(1,'%f ',[omc,omg,om,omc+omg]);
fprintf(1,'\n');

omc = Omegac(s,cd,beta);
omg = Omegag(s,cd,beta);
om = Omega(s,cd,beta);
fprintf(1,'%f ',[omc,omg,om,omc+omg]);
fprintf(1,'\n');


fprintf(1,'Press return\n');
pause


function plot12(s)

fprintf(1,'plot12\n');

EPS = 1e-6;

ri = [2,5,10]';
nb = 10;
omd = zeros(length(ri),nb);
omm = zeros(length(ri),nb);
ome = zeros(length(ri),nb);

phid = zeros(length(ri),nb);
phim = zeros(length(ri),nb);
phie = zeros(length(ri),nb);

oOpd = zeros(length(ri),nb);
oOpm = zeros(length(ri),nb);
oOpe = zeros(length(ri),nb);
oOpa = zeros(length(ri),nb);
oOpb = zeros(length(ri),nb);

% use loss cone of smaller r as smallest pitch angle
bmnd = getLC(s,getMFc(s,'d',ri(1)))+EPS;
bd = linspace(bmnd,pi/3,nb);
bmnm = getLC(s,getMFc(s,'m',ri(1)))+EPS;
bm = linspace(bmnm,pi/3,nb);

Ri = repmat(ri,1,nb);

for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
	phid(i,:) = Phi(s,cd{i},bd);
  omd(i,:) = Omega(s,cd{i},bd);

  cm{i} = getMFc(s,'m',ri(i));
	phim(i,:) = Phi(s,cm{i},bm);
  omm(i,:) = Omega(s,cm{i},bm);

	phie(i,:) = Phid(ri(i),bd);
  ome(i,:) = Omegad(ri(i),bd);

	oOpa(i,:) = OmegaOverPhia('d',ri(i),bd,planet);
	oOpb(i,:) = OmegaOverPhia('m',ri(i),bm,planet);
end

oOpd = omd./phid;
oOpm = omm./phim;
oOpe = ome./phie;

co = [0 0 1;
      0 0.5 0;
      1 0 0];
set(0,'DefaultAxesColorOrder',co);
subplot(211),
%plot(bd,omd,'--')
plot(bd,oOpd,'--')
hold on
%plot(bd,ome);
plot(bd,oOpe);
plot(bd,oOpa,':');
hold off

subplot(212),
%plot(bm,omm);
plot(bm,oOpm);
hold on
plot(bm,oOpb,':');
hold off

fprintf(1,'Press return\n');
pause

function plot13(s)

fprintf(1,'plot13\n');

EPS = 1e-6;

ri = [2:2:14]';
nb = 4;

omd = zeros(length(ri),nb);
omm = zeros(length(ri),nb);
ome = zeros(length(ri),nb);

phid = zeros(length(ri),nb);
phim = zeros(length(ri),nb);
phie = zeros(length(ri),nb);

oOpd = zeros(length(ri),nb);
oOpm = zeros(length(ri),nb);
oOpe = zeros(length(ri),nb);
oOpa = zeros(length(ri),nb);
oOpb = zeros(length(ri),nb);

% use loss cone of smaller r as smallest pitch angle
bmnd = getLC(s,getMFc(s,'d',ri(1)))+EPS;
bd = [pi/3,pi/4,pi/6,bmnd];
bmnm = getLC(s,getMFc(s,'m',ri(1)))+EPS;
bm = [pi/3,pi/4,pi/6,bmnm];

Ri = repmat(ri,1,nb);

for i=1:length(ri),
  cd{i} = getMFc(s,'d',ri(i));
	phid(i,:) = Phi(s,cd{i},bd);
  omd(i,:) = Omega(s,cd{i},bd);

  cm{i} = getMFc(s,'m',ri(i));
	phim(i,:) = Phi(s,cm{i},bm);
  omm(i,:) = Omega(s,cm{i},bm);

	phie(i,:) = Phid(ri(i),bd);
  ome(i,:) = Omegad(ri(i),bd);

	oOpa(i,:) = OmegaOverPhia('d',ri(i),bd,planet);
	oOpb(i,:) = OmegaOverPhia('m',ri(i),bm,planet);
end

oOpd = omd./phid;
oOpm = omm./phim;
oOpe = ome./phie;

co = [0 0 1;
      0 0.5 0;
      1 0 0;
      0 0.75 0.75];
set(0,'DefaultAxesColorOrder',co);
subplot(211),
%plot(ri,omd,'--')
plot(ri,oOpd,'--')
hold on
%plot(ri,ome);
plot(ri,oOpe);
plot(ri,oOpa,':');
hold off

subplot(212),
%plot(ri,omm);
plot(ri,oOpm);
hold on
plot(ri,oOpb,':');
hold off


fprintf(1,'Press return\n');
pause


