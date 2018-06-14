function testgint(u0,g)
% function testgint(u0,g)

%
% $Id: testgint.m,v 1.2 2018/06/14 15:11:06 patrick Exp $
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

EPS = 1e-6;

zmax = u0^2/(2*g);

fprintf(1,'zmax=%g, f1(zmax)=%g\n', zmax, f1(zmax,u0,g))


In = integral(@(z)f(z,u0,g),0,zmax,opts{:},'Waypoints',zmax);
Ie = u0/g;

fprintf(1,'In=%g Ie=%g AbsErr=%g RelErr=%g\n', In, Ie, In-Ie, (In-Ie)/Ie)

function y=f(z,u0,g)
y = 1./sqrt(u0^2-2*g*z);

function y=f1(z,u0,g)
y = sqrt(u0^2-2*g*z);
