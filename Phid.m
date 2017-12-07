function I = Phid(r,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

lm = getLatMPd(r,beta);

I = zeros(size(beta));
for i=1:length(beta),
  I(i) = integral(@(t)f(t,r,beta(i)),0,lm(i),opts{:});
end

function y=f(t,r,b)
y = cos(t).*sqrt(1+3*sin(t).^2)./ ...
    sqrt(1-sqrt(1+3*sin(t).^2)*sin(b)^2./cos(t).^6);
end

end

