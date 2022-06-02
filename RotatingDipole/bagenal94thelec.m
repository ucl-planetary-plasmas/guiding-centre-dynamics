function y = bagenal94thelec(r)
% Bagenal 1994, Fig.1, thermal electrons temp in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>10
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<5.35
        f = fctloglin(5, 1, 5.35, 4);
        y(i) = f(x);
    elseif x>= 5.35 && x<7.4
        f = fctloglin(5.35, 4, 7.4, 8);
        y(i) = f(x);
    elseif x>= 7.4 && x<7.8
        f = fctloglin(7.4, 8,7.8, 25);
        y(i) = f(x);
    elseif x>= 7.8 && x<=10
        f = fctloglin(7.8, 25, 10, 30);
        y(i) = f(x);
    end

end