function mults = multipliers(c)
% mults = multipliers(c)
% Description:
% Compute the multiplying factors entering into the computation of the
% period of motion for the case studied (c).
%
% Inputs:
% c : structure: parameters of the case studied
% c.planet: Rp, Bp, Tp
% c.particle: q, m
% c.distrib: L, E0, a0, subcorot
%
% Outputs:
% mults: struct : containing B, P, D
%
% $Author: Sabine Ogier-Collin$
% $Date: 2022-05-18$
% $Version: 0$

mults.B = computeB(c);
mults.P = computeP(c);
mults.D = (2*pi.*mults.B)./mults.P;

% % % for testing purpose only:
% d = computeD(c);
% disp(['mults.B = ', num2str(mults.B)]);
% disp(['mults.P = ', num2str(mults.P)]);
% disp(['B/P = ', num2str(mults.B./mults.P)]);
% disp(['mults.D = ', num2str(mults.D)]);
% disp(['D = ', num2str(d)]);
% disp(['D*P/2pi = ', num2str(d.*mults.P./(2*pi))]);
% mults.D = d;

% % local functions
    function B = computeB(c)
        L = c.distrib.L;
        E0 = ev2j(c.distrib.E0);
        B = 4*c.planet(1).*L.*sqrt(amu2kg(c.particle(2))./(2.*E0));
    end

    function P = computeP(c)
        L2 = c.distrib.L.^2;
        E0 = ev2j(c.distrib.E0);
        P = (4.*L2.*sqrt(2.*amu2kg(c.particle(2)).*E0))./ ...
            (ev2j(abs(c.particle(1)))*c.planet(1)*c.planet(2));
    end

    function D = computeD(c)
%         E0L = ev2j(c.distrib.E0).*c.distrib.L;
%         D = pi.*ev2j(c.particle(1)).*c.planet(2).*c.planet(1).^2./E0L;
        E0L = c.distrib.E0.*c.distrib.L;
        D = pi.*c.particle(1).*c.planet(2).*c.planet(1).^2./E0L;
    end

end