function y=f_alpha_MP(r0,z0,B1,X1,B2,X2,R)
    if (r0^2+z0^2 >= R^2)
        y=(1/X1-X2)*(B1*(r0-X2)+B2*(X1-r0));
    else
        y=NaN;
    end 
end 