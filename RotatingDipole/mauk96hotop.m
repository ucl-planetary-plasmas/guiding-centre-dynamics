function y = mauk96hotop(r)
% Mauk1996, Fig4 average energy for hot plasma distribution : O+
% E0 (keV) >> in eV here
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>20
        disp("out of domain of definition");
        y(i) = nan;
    elseif x>= 5 && x<5.9
        f = fctloglin(5, 200e3, 5.9, 120e3);
        y(i) = f(x);
    elseif x>= 5.9 && x<6.3
        f = fctloglin(5.9, 120e3, 6.3, 1.5e6);
        y(i) = f(x);
    elseif x>= 6.3 && x<=20
        f = fctloglin(6.3, 1.5e6, 20, 200e3);
        y(i) = f(x);
    end

end