function BxdB = BxgradBd(t,r)

% obs expression for BxgradB/(\omega_gB) not BxgradB!
BxdB = 3*r.^2.*cos(t).^5.*(1+sin(t).^2)./(1+3*sin(t).^2).^2;


