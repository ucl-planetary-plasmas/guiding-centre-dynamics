function e = k2ev(t)
% Convert temperature in Kelvin to 'Energy' in eV.
% Boltzmann constant CODATA 2018:8.617 333 262...  x 10-5 eV K-1
kb = 8.617e-5;
e = t.*kb;
end