function y = thomsen10h2p(r)
% Thomsen 2010 Fig 7b :effective equatorial temperatures (eV)
% L: 6.5-16.5; H_2^+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<6.5 || x>16.5
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 6.5 && x<8.5
        f = fctloglin(6.5, 18, 8.5, 30);
        y(i) = f(x);
    elseif x>= 8.5 && x<12.5
        f = fctloglin(8.5, 30, 12.5, 40);
        y(i) = f(x);
    elseif x>= 12.5 && x<14.5
        f = fctloglin(12.5, 40, 14.5, 50);
        y(i) = f(x);
    elseif x>= 14.5 && x<=16.5
        f = fctloglin(14.5, 50, 16.5, 130);
        y(i) = f(x);
    end

end