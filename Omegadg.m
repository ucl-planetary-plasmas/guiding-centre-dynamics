function I = Omegadg(r,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

EPS = 1e-12;

% singularity at end point lm
% f1(lm) can become pure imaginary
lm = getLatMPd(r,beta)-EPS;

% zr should be real near zero
zr = f1(lm,r,beta);
for i=1:length(beta),
  if ~isreal(zr(i)),
    fprintf(1,'Omegadg-> lm=%f f1(lm,r,beta)=(%f+i%f)\n',...
            lm(i),real(zr(i)),imag(zr(i)));
  end
end

I = zeros(size(beta));
for i=1:length(beta),
	%fprintf(1,'lm=%f\n', lm(i));
  t = linspace(0,lm(i),100); 
	%clf, plot(t,real(f(t,r,beta(i))),'-o',t,imag(f(t,r,beta(i))),'-o'),
	%clf, plot(t,f(t,r,beta(i)),'-o'), title('\Omega_{dg}'); pause
  I(i) = r.^2*integral(@(t)f(t,r,beta(i)),0,lm(i),opts{:},'Waypoints',lm(i));
end


function y=f(t,r,b)
y = sin(b)^2./sqrt(1-sqrt(1+3*sin(t).^2)*sin(b)^2./cos(t).^6)./cos(t).^3.* ...
    (1+sin(t).^2)./(1+3*sin(t).^2)/2;
end

function y=f1(t,r,b)
y = sqrt(1-sqrt(1+3*sin(t).^2).*sin(b).^2./cos(t).^6);
end

end

