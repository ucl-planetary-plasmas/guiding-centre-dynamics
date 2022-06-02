function y = bagenal11sathp(r)
% Bagenal 2011, Fig 4 Sat temperature (eV)
% L:4-20; H+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<4 || x>20
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 4 && x<9
        f = fctloglog(4, 0.25, 9, 1);
        y(i) = f(x);
    elseif x>= 9 && x<10
        f = fctloglog(9, 1, 10, 30);
        y(i) = f(x);
    elseif x>= 10 && x<14
        f = fctloglog(10, 30, 14, 200);
        y(i) = f(x);
    elseif x>= 14 && x<=20
        f = fctloglog(14, 200, 20, 400);
        y(i) = f(x);
    end

end