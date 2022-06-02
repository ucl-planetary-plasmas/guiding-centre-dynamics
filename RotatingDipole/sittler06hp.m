function y = sittler06hp(r)
% Sittler 2006, Fig. 15 (from erratum)
% L:3.5-10; H^+
% Ion Temperature (eV) fit : T_H = 2.2*(L/4)^2.5 

L = r;
for i = 1:length(r)
    if r(i)<3.5 || r(i)>10
        L(i) = nan;
    end
end
y = 2.2.*(L./4).^2.5;
end