function y = thomsen10wp(r)
% Thomsen 2010 Fig 7b :effective equatorial temperatures (eV)
% L: 6.5-16.5; W+
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<6.5 || x>16.5
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 6.5 && x<9.5
        f = fctloglin(6.5, 45, 9.5, 100);
        y(i) = f(x);
    elseif x>= 9.5 && x<11.5
        f = fctloglin(9.5, 100, 11.5, 150);
        y(i) = f(x);
    elseif x>= 11.5 && x<12
        f = fctloglin(11.5, 150, 12, 220);
        y(i) = f(x);
    elseif x>= 12 && x<14.5
        y(i) = 220; 
    elseif x>= 14.5 && x<=16.5
        f = fctloglin(14.5, 220, 16.5, 600);
        y(i) = f(x);
    end

end