function lm = getLatMPd(L,aeq)

% numerically
%tic
opts = optimset('fzero');
fun = @(x,a) cos(x).^6-sin(a)^2.*sqrt(1+3*sin(x).^2);
lm = fzero(@(x) fun(x,aeq),pi/4,opts);
%toc

return

% symbolically takes longer time and requires symbolic toolbox
%tic
M = sym('M','positive');
eqn = M.^6 + 3*M*(sin(aeq)).^4 == 4*(sin(aeq)).^4;
COS2M = vpasolve(eqn,M,0.5);
COSM = double(sqrt(COS2M(2)));
lm1 = acos(COSM);
%toc

lm,lm1,lm-lm1
