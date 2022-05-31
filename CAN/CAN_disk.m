clear all
clc

Rs=60330e3;
mu=4*pi*10^-7;
muI0=35e-9;   %je rest en tesla
R=1;
R1=6*R;
R2=20*R;
D=2.5*R;
A=muI0/2;

rho=0*R:0.02*R:30*R;
z=0*R:0.02*R:15*R;
iter=10;  %nombre itération
for i=1:length(z)
    for j=1:length(rho)
        y1=f_infinite_disk(A,R1,D,rho(1,j),z(1,i),R,iter);   %br et bz pour le infinite-disk1
        y2=f_infinite_disk(A,R2,D,rho(1,j),z(1,i),R,iter);     %br et bz pour le infinite-disk2
        Brho(i,j)=y1(1,1)-y2(1,1);       %calcul des composantes du CAN
        Bz(i,j)=y1(1,2)-y2(1,2);
    end
end 

B=sqrt(Bz.^2+Brho.^2);

%%
figure
pcolor(rho,z,log10(B))
axis equal tight
shading flat
colormap(jet(200))
c=colorbar;
caxis([-0.5,1])
set(gca, 'FontSize', 22, 'fontName','Times');
c.Label.String = 'log_1_0(B) (nT)';
xlabel('\rho (Rs)')
ylabel('z (Rs)')
rectangle('Position',[6 -2.5 14 5],'LineWidth',2)
%%
figure
zbis=[-flipud(z')' z(1,[2:end])];
Bbis=[flipud(B);B([2:end],:)];
pcolor(rho,zbis,log10(Bbis))
shading flat
axis equal tight
colormap(jet(200));
caxis([-0.5,1])
c = colorbar;
set(gca, 'FontSize', 22, 'fontName','Times');
c.Label.String = 'log_1_0(B) (nT)';
c.Label.FontSize = 30;
xlabel('\rho (Rs)','Fontsize',30); 
ylabel('z (Rs)','Fontsize',30);
rectangle('Position',[6 -2.5 14 5],'LineWidth',2)
