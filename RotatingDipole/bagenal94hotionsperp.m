function y = bagenal94hotionsperp(r)
% Bagenal 1994, Fig.2, hot ions perpendicular temperature in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>10
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<8.6
        f = fctloglin(5, 80, 8.6, 1200);
        y(i) = f(x);
    elseif x>= 8.6 && x<10
        f = fctloglin(8.6, 1200, 10, 2000);
        y(i) = f(x);
    end

end