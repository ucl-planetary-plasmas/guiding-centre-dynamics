function [toms, params, mults, ints, intsnr] = timesofmotion(c)
% toms = timesofmotion(c)
% Description:
% Compute the times of motion:
% tb: bounce period
% td: drift period
% Inputs:
% c : structure: parameters of the case studied
% c.planet: Rp, Bp, Tp
% c.particle: q, m
% c.distrib: L, E0, a0, subcorot
%
% Outputs:
%
% $Author: Sabine Ogier-Collin$ 
% $Date: 2022-05-18$ first version

mults = multipliers(c);

% with rotation
% [al, b0] = dimensionless(c);
b0 = computebeta0(c);
al = computealphaloss(b0, c.distrib.L);
% c.distrib.a0 = [a0mx, na0];
[ints, alpha0] = integrals(al, b0,c.distrib.a0(1), c.distrib.a0(2));

% w/o rotation (b0 = 0)
alnr = computealphaloss(0, c.distrib.L);
[intsnr, a0nr] = integrals (alnr, 0,c.distrib.a0(1), c.distrib.a0(2));

% Save parameters
params = struct('case', c);
params.al = struct('rot', al, 'norot', alnr);
params.a0 = struct('rot', alpha0, 'norot', a0nr);
params.b0 = struct('rot', b0, 'norot', 0);


% Times of motion:
integrated = [ints, intsnr];
for i = 1:2
tb = mults.B.*integrated(i).phi;
dp = mults.P.*integrated(i).gamma;
td = mults.D.*integrated(i).phiOgamma;
% curv
dpc = mults.P.*integrated(i).gc;
tdc = mults.D.*integrated(i).pOgc;
% grad
dpg = mults.P.*integrated(i).gg;
tdg = mults.D.*integrated(i).pOgg;
% grad+curv=mag
dpcg = mults.P.*integrated(i).gcg;
tdcg = mults.D.*integrated(i).pOgcg;
% centrifugal
dpcf = mults.P.*integrated(i).gcf;
tdcf = mults.D.*integrated(i).pOgcf;

t(i) = struct('tb', tb, ...
    'dp', dp,'td', td, ...
    'dpc', dpc,'tdc', tdc, ...
    'dpg', dpg,'tdg', tdg, ...
    'dpcg', dpcg,'tdcg', tdcg, ...
    'dpcf', dpcf,'tdcf', tdcf ...
    );
end
toms.rot = t(1);
toms.norot = t(2);

return