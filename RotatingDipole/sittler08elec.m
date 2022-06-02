function y = sittler08elec(r)
% Sittler 2008; Fig1 electron temp (eV) June30 2004 1600-2000 (wrt time)
% + L indication :
% l = [3.5, 3.9, 4.89, 5.3, 6.26, 7.0, 8.7, 10.2];
% sittler08e = [1, 1.4, 3, 4, 10, 20, 30, 100];
% Approximation:
y = zeros(1,length(r));
for i=1:length(r)
    x=r(i);
    if x<3.5 || x>10.2
        disp(['x = ', num2str(x), ' : out of domain of definition']);
        y(i) = nan;
    elseif x>= 3.5 && x<7
        f = fctloglin(3.5, 1, 7, 20);
        y(i) = f(x);
    elseif x>= 7 && x<8.7
        f = fctloglin(7, 20, 8.7, 30);
        y(i) = f(x);
    elseif x>= 8.7 && x<=10.2
        f = fctloglin(8.7, 30, 10.2, 100);
        y(i) = f(x);
    end

end