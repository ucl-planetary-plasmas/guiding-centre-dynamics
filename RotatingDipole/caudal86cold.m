function y = caudal86cold(r)
% Caudal1986, Fig.3
% Cold plasma temperature
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<5 || x>12
        disp("out of domain of definition");
        y(i) = nan;
    elseif x>= 5 && x<6
        f = fctloglin(5,1, 6, 35);
        y(i) = f(x);
    elseif x>= 6 && x<7
        y(i) = 35;
    elseif x>= 7 && x<9
        f = fctloglin(7, 35, 9, 90);
        y(i) = f(x);
    elseif x>= 9
        y(i) = 10*x;
        end

end