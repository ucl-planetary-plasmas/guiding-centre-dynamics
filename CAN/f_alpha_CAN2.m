function y=f_alpha_CAN2(A,r0,z0,d1,d2,F1bis,F2bis,a,iter,Rs,R,inf)
    F1=(d1.^2+a^2)^(0.5);
    F2=(d2.^2+a^2)^(0.5);
    F1inf=(d1.^2+inf^2)^(0.5);
    F2inf=(d2.^2+inf^2)^(0.5);    
    if (r0^2+z0^2 >= 0^2)
        if abs(r0)<=a    %a est le inner radius
            y=f_inner_disk(A,r0,d1,d2,F1,F2,iter,Rs)-f_inner_disk(A,a,d1,d2,F1,F2,iter,Rs);  %calcul l'inte de r à a
            for k=0:iter  %calcul de a à l'infini
                if (k==0)
                    Cinf=f_premiere_inte(A,Rs,r0,d1,d2,F2inf,F1inf);
                    Ca=f_premiere_inte(A,Rs,a,d1,d2,F2,F1);
                    y=y+Ca-Cinf;   %première integrale de alpha cf pdf 
                else
                    Dr1=integrale_pol_legendre(k,d1,F1inf);
                    Dr2=integrale_pol_legendre(k,d2,F2inf);
                    Da1=integrale_pol_legendre(k,d1,F1);
                    Da2=integrale_pol_legendre(k,d2,F2);                  
                    y=y+(A*Rs)*((-1)^(k)*a^(2*k)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2)*(Da1-Da2+Dr2-Dr1));  %deuxième partie de l'intégrale
                end
            end
        elseif abs(r0)>a
            for k=0:iter  %calcul inte de r à l'infini
                if (k==0)
                    Cr=f_premiere_inte(A,Rs,r0,d1,d2,F2bis,F1bis);
                    Cinf=f_premiere_inte(A,Rs,a,d1,d2,F2inf,F1inf);
                    y=Cr-Cinf;   
                else
                    Dr1=integrale_pol_legendre(k,d1,F1bis);
                    Dr2=integrale_pol_legendre(k,d2,F2bis);
                    Dinf1=integrale_pol_legendre(k,d1,F1inf);
                    Dinf2=integrale_pol_legendre(k,d2,F2inf);                  
                    y=y+(A*Rs)*((-1)^(k)*a^(2*k)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2)*(Dr1-Dr2+Dinf2-Dinf1));
                end
            end
        end    
    else
        y=NaN;
    end
end 