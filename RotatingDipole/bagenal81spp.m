function y = bagenal81spp(r)
% Bagenal81, Fig.7, S++
% plasma temperature in K >> convert to kbT in eV
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>9
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 5 && x<6
        f = fctloglin(5, 4e3, 6, 5e5);
        y(i) = k2ev(f(x));
    elseif x>= 6 && x<=9
        f = fctloglin(6, 5e5, 9, 1e6);
        y(i) = k2ev(f(x));
    end

end