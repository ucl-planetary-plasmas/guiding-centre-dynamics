function I = testint(s,c,beta)

lm = getLatMP(s,c,beta);

I = integral(@(t)fun(t,c),-lm,lm,'AbsTol',1e-9,'RelTol',1e-6);

function y=fun(t,c)
y = sqrt(c.rt(t).^2+Dct(c.rt,t).^2);
end

end