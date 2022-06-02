function y = mauk96hotelec(r)
% Mauk1996, Fig4 average energy for hot plasma distribution : elec
% E0 (keV) >> in eV here
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>20
        disp("out of domain of definition");
        y(i) = nan;
    elseif x>= 5 && x<9.6
        f = fctloglin(5, 650e3, 9.6, 500e3);
        y(i) = f(x);
    elseif x>= 9.6 && x<=20
        f = fctloglin(9.6, 500e3, 20, 200e3);
        y(i) = f(x);
    end

end