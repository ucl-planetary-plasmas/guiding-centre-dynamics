function y=f_alpha_0(A,r0,z0,d1,d2,a,iter,Rs,R,inf)
    F1=(d1.^2+a^2)^(0.5);
    F2=(d2.^2+a^2)^(0.5);
    F1inf=(d1.^2+inf^2)^(0.5);
    F2inf=(d2.^2+inf^2)^(0.5);
    if (r0^2+z0^2 >= R^2)
            y=f_inner_disk(A,0,d1,d2,F1,F2,iter,Rs)-f_inner_disk(A,a,d1,d2,F1,F2,iter,Rs);
            for k=0:iter  
                if (k==0)
                    Cinf=f_premiere_inte(A,Rs,inf,d1,d2,F2inf,F1inf);
                    Ca=f_premiere_inte(A,Rs,a,d1,d2,F2,F1);
                    y=y+Ca-Cinf;
                else
                    Dinf1=integrale_pol_legendre(k,d1,F1inf);
                    Dinf2=integrale_pol_legendre(k,d2,F2inf);
                    Da1=integrale_pol_legendre(k,d1,F1);
                    Da2=integrale_pol_legendre(k,d2,F2);                  
                    y=y-(A*Rs)*((-1)^(k)*a^(2*k)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2)*(Dinf1-Dinf2+Da2-Da1));
                end
            end
    else   
        y=NaN;
    end
end 