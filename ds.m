function ys = ds(x,y)

if 0,
  [ys,rho] = smooth(x,y);
	fprintf(1,'smooth: rho=%f\n',rho);
else
  ys = y;
end
