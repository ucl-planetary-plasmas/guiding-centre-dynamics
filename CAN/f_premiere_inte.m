function y=f_premiere_inte(A,Rs,r0,d1,d2,F2bis,F1bis)
    y=A*Rs*((r0^2/2)*log((d2+F2bis)/(d1+F1bis))+(d2/2)*F2bis-(d1/2)*F1bis);
end
