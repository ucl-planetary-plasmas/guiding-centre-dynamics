clear all
clc

M=4.63e25;  %moment magnétique calculé a partir du B0
Rs=60280e3;
muI0=35e-9;  %je reste en tesla
R=1;
R1=6*R;
R2=20*R;
D=2.5*R;
A=muI0/2;

pas=0.1;
rho=0*R:0.05*R:30*R;
z=-15*R:0.05*R:15*R;
iter=10;    %nombre itération
for i=1:length(z)
    for j=1:length(rho)
        y1=f_infinite_disk(A,R1,D,rho(1,j),z(1,i),R,iter);   %br et bz semi disk 1
        y2=f_infinite_disk(A,R2,D,rho(1,j),z(1,i),R,iter);   %br et bz semi disk 2
        y=f_dipole(M,rho(1,j),z(1,i),Rs,R);                  %br et bz du dipole
        Brho(i,j)=y(1,1)+y1(1,1)-y2(1,1);    %br total
        Bz(i,j)=y(1,2)+y1(1,2)-y2(1,2);         %bz total
    end
end 


%%

B=sqrt(Bz.^2+Brho.^2);

figure
pcolor(rho,z,log10(B))
axis equal tight
shading flat
colormap(jet(100));
c=colorbar;
set(gca, 'FontSize', 22, 'fontName','Times');
caxis([0.4,4.6])
c.Label.String = 'log_1_0(B)(nT)';
xlabel('\rho (Rs)')
ylabel('z (Rs)')
hold on
rectangle('Position',[6 -2.5 14 5],'LineWidth',2)