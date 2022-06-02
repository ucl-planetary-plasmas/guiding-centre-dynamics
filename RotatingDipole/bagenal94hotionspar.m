function y = bagenal94hotionspar(r)
% Bagenal 1994, Fig.2, hot ions parallel temperature in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>10
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<8.8
        f = fctloglin(5, 10, 8.8, 250);
        y(i) = f(x);
    elseif x>= 8.8 && x<10
        f = fctloglin(8.8, 250, 10, 300);
        y(i) = f(x);
    end

end