function I = Omegad(r,beta)
% function I = Omegad(r,beta)

%
% $Id: Omegad.m,v 1.8 2018/06/14 14:52:31 patrick Exp $
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

EPS = 1e-12;

% zero at end point lm due to f1(lm) = 0
% f1(lm) can become pure imaginary
lm = getLatMPd(r,beta)-EPS;

% zr should be real near zero
zr = f1(lm,r,beta);
for i=1:length(zr),
  if ~isreal(zr(i)),
    fprintf(1,'Omegad-> lm=%f f1(lm,r,beta)=(%f+i%f)\n',...
		        lm(i),real(zr(i)),imag(zr(i)));
  end
end

I = zeros(size(beta));
for i=1:length(beta),
	%fprintf(1,'lm=%f\n', lm(i));
  t = linspace(0,lm(i),100); 
	%clf, plot(t,f(t,r,beta(i)),'-o'),title('\Omega_d'); pause
  I(i) = integral(@(t)f(t,r,beta(i)),0,lm(i),opts{:},'Waypoints',lm(i));
end

function y=f(t,r,b)
y = (1-sqrt(1+3*sin(t).^2)*sin(b)^2/2./cos(t).^6)./ ...
    sqrt(1-sqrt(1+3*sin(t).^2)*sin(b)^2./cos(t).^6).* ...;
		cos(t).^3.*(1+sin(t).^2)./(1+3*sin(t).^2).^1.5;
end

function y=f1(t,r,b)
y = sqrt(1-sqrt(1+3*sin(t).^2).*sin(b).^2./cos(t).^6);
end

end

