function y=f_alpha_dipole(M,r0,z0,R,Rs)
    mu=4*pi*10^-7;
    if (r0^2+z0^2 >= R^2)
        y=(1/Rs^2)*((mu*M*r0^2)/(4*pi*(r0^2+z0^2).^(3/2)));
    else
        y=NaN;
    end
end 