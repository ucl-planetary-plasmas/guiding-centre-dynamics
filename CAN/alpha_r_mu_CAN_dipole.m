clear all
clc
%%
M=4.63e25;
Rs=60280e3;
mu=4*pi*10^-7;
muI0=30e-9;  %je reste en tesla
R=1;
R1=6*R;  %inner radius
R2=20*R;    %outer radius
D=0.4*R;
A=muI0/2;
Bs=1.67e-5;
pas=1;
r=1.1:pas:30;
mu=-1:1/250:1;
iter=10;   %nombre itération
inf=1e7;   %borne infini de l'integrale
%%
for i=1:length(mu)
    i
    for j=1:length(r)
        z=r(1,j)*mu(1,i);
        rho=r(1,j)*sqrt(1-mu(1,i)^2);
        d1=z-D;
        d2=z+D;
        F1bis=(d1.^2+rho^2)^(0.5);
        F2bis=(d2.^2+rho^2)^(0.5);
        alpha(i,j)=f_alpha_dipole(M,rho,z,R,Rs)+alphas(Bs,rho)+f_alpha_CAN2(A,rho,z,d1,d2,F1bis,F2bis,R1,iter,Rs,R,inf)-f_alpha_CAN2(A,rho,z,d1,d2,F1bis,F2bis,R2,iter,Rs,R,inf);
        %somme des alpha dipole et disques
        if alpha(i,j)<0
            alpha(i,j)=0.3;  %evite les valeurs négative en rho=0
        end
    end
end 
  

%%

figure
pcolor(r,mu,log10(alpha))
shading flat
colormap(jet(50));
caxis([-0.5,3])
colorbar


%%

for i=1:length(mu)
    for j=1:length(r)
        z=r(1,j)*mu(1,i);
        rho=r(1,j)*sqrt(1-mu(1,i)^2);
        y1=f_infinite_disk(A,R1,D,rho,z,R,iter);   %br et bz semi disk 1
        y2=f_infinite_disk(A,R2,D,rho,z,R,iter);   %br et bz semi disk 2
        y=f_dipole(M,rho,z,Rs,R);                  %br et bz du dipole
        Brho(i,j)=y(1,1)+y1(1,1)-y2(1,1);    %br total
        Bz(i,j)=y(1,2)+y1(1,2)-y2(1,2);   %bz total
        Br(i,j)=Brho(i,j)*cos(asin(mu(1,i)))+Bz(i,j)*mu(1,i);
        Blambda(i,j)=Brho(i,j)*mu(1,i)-Bz(i,j)*cos(asin(mu(1,i)));
    end
end 
%%
B=sqrt(Bz.^2+Brho.^2);

figure
pcolor(r,mu,log10(B))

shading flat
colormap(jet(100));
c=colorbar;

B1=sqrt(Br.^2+Blambda.^2);

figure
pcolor(r,mu,log10(B1))

shading flat
colormap(jet(100));
c=colorbar;



%%
CAN.B=B;
CAN.Br=Br;
CAN.Bt=Blambda;
CAN.Brho=Brho;
CAN.Bz=Bz;
CAN.alpha=alpha;
CAN.r=r;
CAN.mu=mu;

save('Sat_CAN_test.mat','CAN')



