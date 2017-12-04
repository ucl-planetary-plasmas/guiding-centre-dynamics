function BxdB = BxgradB(t,c,Br,Bt,B)

st = sin(t);
r = c.rt(t);
dr = c.drt(t);

br = Br(r,st);
bt = Bt(r,st);
b = B(r,st);

gradBr = D2r(B,r,st);
gradBt = 1./r.*D2t(B,r,st);

% + sign due to orientation!
BxdB = abs(br.*gradBt + bt.*gradBr);

return

subplot(311), plot(t,BxdB), title('BxdB components');
subplot(312), plot(t,br.*gradBt),
subplot(313), plot(t,bt.*gradBr),
pause
