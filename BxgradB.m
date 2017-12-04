function BxdB = BxgradB(t,c,Br,Bt,B)

st = sin(t);
r = c.rt(t);
dr = c.drt(t);

br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);

dbdr = D2r(B,r,st);
dbdt = D2t(B,r,t);

BxdB = abs(br./r.*dbdt-bt.*dbdr.*dr);


