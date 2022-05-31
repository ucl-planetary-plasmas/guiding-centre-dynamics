clear all
clc

Rs=60330e3;
R=1;
mu=4*pi*10^-7;
M=4.64e25;
rho= 0*R:0.05*R:30*R;
z1= -15*R:0.05*R:15*R;
pas=0.05;
%%
for i=1:length(z1)
    for j=1:length(rho)
        alphadip(i,j)=f_alpha_dipole(M,rho(1,j),z1(1,i),R,Rs);
    end 
end 
%%
figure
pcolor(rho,z1,log10(alphadip))
shading flat
axis equal tight
colormap(jet(50));
caxis([-0.5,3])
colorbar
c = colorbar;

set(gca, 'FontSize', 22, 'fontName','Times');
c.Label.String = 'log_1_0(\alpha) (T.m)';
c.Label.FontSize = 30;
xlabel('\rho (Rs)','Fontsize',30); 
ylabel('z (Rs)','Fontsize',30);
    

hold on
a=log10(alphadip(301,5/pas+1));
[C,h]=contour(rho,z1,log10(alphadip)./a.*5,[5 5],'k','linewidth',1.5);
clabel(C,h,'LabelSpacing',100,'FontSize',15)
hold on
a=log10(alphadip(301,10/pas+1));
[C,h]=contour(rho,z1,log10(alphadip)./a.*10,[10 10],'k','linewidth',1.5);
clabel(C,h,'LabelSpacing',200,'FontSize',15)
hold on
a=log10(alphadip(301,15/pas+1));
[C,h]=contour(rho,z1,log10(alphadip)./a.*15,[15 15],'k','linewidth',1.5);
clabel(C,h,'LabelSpacing',300,'FontSize',15)
hold on
a=log10(alphadip(301,20/pas+1));
[C,h]=contour(rho,z1,log10(alphadip)./a.*20,[20 20],'k','linewidth',1.5);
clabel(C,h,'LabelSpacing',300,'FontSize',15)
hold on
a=log10(alphadip(301,25/pas+1));
[C,h]=contour(rho,z1,log10(alphadip)./a.*25,[25 25],'k','linewidth',1.5);
clabel(C,h,'LabelSpacing',300,'FontSize',15)

%%
hold on
L=3:3:18;
for i=1:length(L)
    a=log10(f_alpha_dipole(M,L(1,i)*R,0,R,Rs));
    c=contour(rho,z1,log10(alphadip),[a a],'k');
    depart(1,i)=c(1,end);
    depart(2,i)=c(2,end);
    hold on
end



