function y = sittler06wp(r)
% Sittler 2006, Fig. 15 (from erratum)
% L:3.5-10; w^+
% Ion Temperature (eV) fit : T_W = 35.0*(L/4)^2.0 

L = r;
for i = 1:length(r)
    if r(i)<3.5 || r(i)>10
        L(i) = nan;
    end
end
y = 35.*(L./4).^2;
end