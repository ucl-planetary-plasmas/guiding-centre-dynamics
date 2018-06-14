function I = Omegac(s,c,beta)
% function I = Omegac(s,c,beta)

%
% $Id: Omegac.m,v 1.13 2018/06/14 14:52:31 patrick Exp $
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

opts = {'AbsTol',1e-12,'RelTol',1e-9};
%opts = {'AbsTol',1e-6,'RelTol',1e-3};

switch lower(c.type),

  case {'d','dip','dipole'},

    B = s.dip.B;
    Br = s.dip.Br;
    Bt = s.dip.Bt;

  case {'m','md','mdisc'},

    B = s.md.B;
    Br = s.md.Br;
    Bt = s.md.Bt;

  otherwise

    error('magnetic field type c.type not recognised',c.type)

end

EPS = 1e-10;
EPS = 0;

% zero at end point lm due to f1(lm) = 0
% f1(lm) can become pure imaginary
lm = getLatMP(s,c,beta)-EPS;
Bm = B(c.rt(lm),sin(lm));

% zr should be real near zero
zr = f1(lm,c,Bm);
for i=1:length(beta),
  if ~isreal(zr(i)),
    fprintf(1,'Omega-> lm=%f f1(lm,c,Bm)=(%f+i%f)\n',...
            lm(i),real(zr(i)),imag(zr(i)));
  end
end

I = zeros(size(beta));
for i=1:length(beta),
  %fprintf(1,'lm=%f\n', lm(i));
	t = linspace(0,lm(i),100);
	%clf, plot(t,c.kappa(t),'-o',t,Kappad(c.r0,t)),title('\kappa'); pause
	%clf, plot(t,c.kappa(t)./B(c.rt(t),sin(t)),'-o'),title('\kappa/B'); pause
	%clf, plot(t,f(t,c,Bm(i)),'-o'),title('\Omega_c'); pause
  I(i) = 1/c.r0.^2*integral(@(t)f(t,c,Bm(i)),0,lm(i),opts{:},'Waypoints',lm(i));
end

function y=f(t,c,Bm)
r = c.rt(t);
st = sin(t);
K = c.kappa(t);
br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);
y = sqrt(1-b/Bm).*(K./b).*sqrt(1+(br./bt).^2)./cos(t)/3;
end

function y=f1(t,c,Bm)
r = c.rt(t);
st = sin(t);
y = sqrt(1-B(r,st)./Bm);
end


end

