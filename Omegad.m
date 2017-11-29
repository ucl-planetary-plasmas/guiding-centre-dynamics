function I = Omegad(r,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

lm = getLatMPd(r,beta);

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = r.^2*integral(@(t)f(t,r,beta(i)),0,lm(i),opts{:});
end

function y=f(t,r,b)
y = (1-sqrt(1+3*sin(t).^2)*sin(b)^2/2./cos(t).^6)./ ...
    sqrt(1-sqrt(1+3*sin(t).^2)*sin(b)^2./cos(t).^6).* ...;
		cos(t).^3.*(sin(t).^2+1)./sqrt(1+3*sin(t).^2)./(1+3*sin(t).^2);
end

end

