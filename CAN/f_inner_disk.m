function y=f_inner_disk(A,r0,d1,d2,F1,F2,iter,Rs)
    for k=0:iter
                if (k==0)
                    y=(A*Rs)*(r0^2/2)*log((d2+F2)/(d1+F1));
                else
                    temp3 = legendre(2*k-1,d1/F1); 
                    temp4 = legendre(2*k-1,d2/F2);                    
                    y=y+(A*Rs)*((-1)^(k)*r0^(2*k+2)*factorial(2*k-1)/(2^(2*k)*factorial(k)^2*(2*k+2))*(temp3(1,1)./F1^(2*k) - temp4(1,1)/F2^(2*k)));
                end
    end
end 