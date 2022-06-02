function f = fctloglin(xa, ya, xb, yb)
f = @(x) ya.*10.^(((x-xa)/(xb-xa)).*log10(yb/ya));
end 