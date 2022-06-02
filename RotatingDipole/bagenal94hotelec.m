function y = bagenal94hotelec(r)
% Bagenal 1994, Fig.2, hot electrons temp in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>10
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<7.8
        f = fctloglin(5, 100, 7.8, 300);
        y(i) = f(x);
    elseif x>= 7.8 && x<10
        f = fctloglin(7.8, 300, 10, 250);
        y(i) = f(x);
    end

end