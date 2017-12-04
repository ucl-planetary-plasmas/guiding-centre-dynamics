function BxdB = BxgradB(t,c,Br,Bt,B)

st = sin(t);
r = c.rt(t);
dr = c.drt(t);

br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);

gradBr = D2r(B,r,st);
gradBt = 1./r.*D2t(B,r,t);

BxdB = abs(br.*gradBt - bt.*gradBr);


