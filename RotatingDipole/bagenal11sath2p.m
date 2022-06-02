function y = bagenal11sath2p(r)
% Bagenal 2011, Fig 4 Sat temperature (eV)
% L:3-20; H_2^+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<3 || x>20
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 3 && x<7.5
        f = fctloglog(3,10, 7.5, 60);
        y(i) = f(x);
    elseif x>= 7.5 && x<9
        f = fctloglog(7.5,60,9,150);
        y(i) = f(x);
    elseif x>= 9 && x<17
        f = fctloglog(9,150,17,475);
        y(i) = f(x);
    elseif x>= 17 && x<=20
        y(i) = 475;
    end

end