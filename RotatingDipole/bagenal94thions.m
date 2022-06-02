function y = bagenal94thions(r)
% Bagenal 1994, Fig.1, thermal ion temp in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>10
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<5.8
        f = fctloglin(5, 1, 5.8, 60);
        y(i) = f(x);
    elseif x>= 5.8 && x<7.45
        y(i) = 60;
    elseif x>= 7.45 && x<=10
        f = fctloglin(7.45, 60, 10, 350);
        y(i) = f(x);
    end

end