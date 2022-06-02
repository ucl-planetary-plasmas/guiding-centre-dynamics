function al = computealphaloss(b0, L)
al = (1-b0.*(1-L.^(-3)))./...
    sqrt(4.*L.^6 - 3.*L.^5);
end