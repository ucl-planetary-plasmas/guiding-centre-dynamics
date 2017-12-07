function I = Omegad(r,beta)

opts = {'AbsTol',1e-12,'RelTol',1e-9};

EPS = 1e-12;

% zero at end point lm due to f1(lm) = 0
% f1(lm) can become pure imaginary
lm = getLatMPd(r,beta)-EPS;

% zr should be real near zero
zr = f1(lm,r,beta);
for i=1:length(zr),
  if ~isreal(zr(i)),
    fprintf(1,'Omegad-> lm=%f f1(lm,r,beta)=(%f+i%f)\n',...
		        lm(i),real(zr(i)),imag(zr(i)));
  end
end

I = zeros(size(beta));
for i=1:length(beta),
	%fprintf(1,'lm=%f\n', lm(i));
  t = linspace(0,lm(i),100); 
	%clf, plot(t,f(t,r,beta(i)),'-o'),title('\Omega_d'); pause
  I(i) = integral(@(t)f(t,r,beta(i)),0,lm(i),opts{:},'Waypoints',lm(i));
end

function y=f(t,r,b)
y = (1-sqrt(1+3*sin(t).^2)*sin(b)^2/2./cos(t).^6)./ ...
    sqrt(1-sqrt(1+3*sin(t).^2)*sin(b)^2./cos(t).^6).* ...;
		cos(t).^3.*(1+sin(t).^2)./(1+3*sin(t).^2).^1.5;
end

function y=f1(t,r,b)
y = sqrt(1-sqrt(1+3*sin(t).^2).*sin(b).^2./cos(t).^6);
end

end

