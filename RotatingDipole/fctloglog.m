function f = fctloglog(xa, ya, xb, yb)
% return lin fct Y = mX+b on a loglog plot passing by (xa, ya) and (xb, yb)
m = log10(yb/ya)/log10(xb/xa);
f = @(x) ya.*(x./xa).^m;
end 