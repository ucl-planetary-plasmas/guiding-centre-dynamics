function I = testint(s,c,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

lm = getLatMP(s,c,beta);

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = integral(@(t)fun(t,c),-lm(i),lm(i),opts{:});
end

function y=fun(t,c)
%y = sqrt(c.rt(t).^2+Dct(c.rt,t).^2);
y = sqrt(c.rt(t).^2+c.drt(t).^2);
end

end
