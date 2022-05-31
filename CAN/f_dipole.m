function y =f_dipole(M,rho0,z0,Rs,R)
    mu=4*pi*10^-7;
    if (rho0^2+z0^2 >= R^2)
        Br=(1/Rs^3)*((mu*M)/(4*pi*(rho0^2+z0^2).^(3/2)))*2*cos(atan(rho0/z0));
        Bo=(1/Rs^3)*((mu*M)/(4*pi*(rho0^2+z0^2).^(3/2)))*sin(atan(rho0/z0));
    else
        Br=NaN;
        Bo=NaN;
    end
    Brho=Br*sin(atan(rho0/z0))+Bo*cos(atan(rho0/z0));
    Bz=Br*cos(atan(rho0/z0))-Bo*sin(atan(rho0/z0));
    y=[1e9*Brho 1e9*Bz];
    end 
    