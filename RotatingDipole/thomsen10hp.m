function y = thomsen10hp(r)
% Thomsen 2010 Fig 7b :effective equatorial temperatures (eV)
% L: 6.5-16.5; H+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<6.5 || x>16.5
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 6.5 && x<8.5
        f = fctloglin(6.5, 15, 8.5, 30);
        y(i) = f(x);
    elseif x>= 8.5 && x<14.5
        f = fctloglin(8.5, 30, 14.5, 45);
        y(i) = f(x);
    elseif x>= 14.5 && x<=16.5
        f = fctloglin(14.5, 45, 16.5, 70);
        y(i) = f(x);
    end

end