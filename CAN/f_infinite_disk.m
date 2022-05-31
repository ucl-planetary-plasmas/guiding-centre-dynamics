function y=f_infinite_disk(A,a,D,rho0,z0,R,iter)
    d1=z0-D;
    d2=z0+D;
    F1=(d1.^2+a^2)^(0.5);
    F2=(d2.^2+a^2)^(0.5);
    F1bis=(d1.^2+rho0^2)^(0.5);
    F2bis=(d2.^2+rho0^2)^(0.5);
    Brho=0;
    Bz=0;
    if (rho0^2+z0^2 >= R^2)
        if abs(rho0)<=a
            for k=0:iter
                temp1 = legendre(2*k,d1/F1); 
                temp2 = legendre(2*k,d2/F2); 
                Brho= Brho+2*A*(((-1)^k*rho0^(2*k+1)*factorial(2*k)/(2^(2*k+2)*factorial(k)^2*(k+1))*(temp1(1,1)/F1^(2*k+1) - temp2(1,1)/F2^(2*k+1))));
                    
                if (k==0)
                    Bz=A*log((d2+F2)/(d1+F1));
                else
                    temp3 = legendre(2*k-1,d1/F1); 
                    temp4 = legendre(2*k-1,d2/F2);                    
                    Bz=Bz+A*((-1)^(k)*rho0^(2*k)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2)*(temp3(1,1)./F1^(2*k) - temp4(1,1)/F2^(2*k)));
                end
            end
        elseif abs(rho0)>a
            for k=0:iter  
                if (k==0)
                    Bz=A*log((d2+F2bis)/(d1+F1bis));
                    Brho=A/rho0*(2*sign(z0)*min(abs(z0),D)+F1bis-F2bis);
                else
                    temp5 = legendre(2*k-1,d1/F1bis); 
                    temp6 = legendre(2*k-1,d2/F2bis);
                    Bz=Bz+A*((-1)^k*a^(2*k)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2)*(temp5(1,1)/F1bis^(2*k) - temp6(1,1)/F2bis^(2*k)));
                    Brho=Brho-A/rho0*((-1)^k*a^(2*k)*rho0*factorial(2*k-2)/(2^(2*k)*factorial(k)^2)*(temp5(2,1)./F1bis^(2*k) - temp6(2,1)/F2bis^(2*k)));
                end
            end
        end    
    else
        Bz=NaN;
        Brho=NaN;
    end
    y=[Brho*1e9,Bz*1e9];
end 