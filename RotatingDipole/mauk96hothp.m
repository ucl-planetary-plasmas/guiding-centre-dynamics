function y = mauk96hothp(r)
% Mauk1996, Fig4 average energy for hot plasma distribution; H+
% E0 (keV) >> in eV here
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>20
        disp("out of domain of definition");
        y(i) = nan;
    elseif x>= 5 && x<5.9
        y(i) = 100e3;
    elseif x>= 5.9 && x<6.6
        f = fctloglin(5.9, 100e3, 6.6, 2e6);
        y(i) = f(x);
    elseif x>= 6.6 && x<=20
        f = fctloglin(6.6, 2e6, 20, 200e3);
        y(i) = f(x);
    end

end