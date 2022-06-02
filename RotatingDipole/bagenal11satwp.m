function y = bagenal11satwp(r)
% Bagenal 2011, Fig 4 Sat temperature (eV)
% L:3-16, W+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<3 || x>16
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 3 && x<10
        f = fctloglog(3,20,10,300);
        y(i) = f(x);
    elseif x>= 10 && x<13
        f = fctloglog(10, 300, 13, 400);
        y(i) = f(x);
    elseif x>= 13 && x<=16
        f = fctloglog(13, 400, 16, 600);
        y(i) = f(x);
    end

end