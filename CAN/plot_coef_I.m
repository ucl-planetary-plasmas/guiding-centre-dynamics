clear all
clc

%%

I=[10 20 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 140];
coefphi4=[1.276980,-0.505794,-0.014450;
    1.281685,-0.473918,-0.028259;
    1.283620,-0.439978,-0.041604;
    1.283569,-0.422228,-0.048112;
    1.282851,-0.403954,-0.054514;
    1.281484,-0.385130,-0.060824;
    1.279481,-0.365772,-0.067043;
    1.276843,-0.345835,-0.073182;
    1.273579,-0.325338,-0.079243;
    1.269693,-0.304260,-0.085229;
    1.265187,-0.282587,-0.091149;
    1.260065,-0.260286,-0.097008;
    1.254317,-0.237326,-0.102814;
    1.247953,-0.213697,-0.108573;
    1.240976,-0.189360,-0.114294;
    1.233384,-0.164325,-0.119977;
    1.225173,-0.138552,-0.125632;
    1.216348,-0.112030,-0.131263;
    1.206873,-0.084697,-0.136874;
    1.196752,-0.056516,-0.142477;
    1.185975,-0.027454,-0.148075;
    1.174533,+0.002534,-0.153679;
    1.162387,+0.033545,-0.159301;
    1.149527,+0.065617,-0.164946;
    1.135909,+0.098873,-0.170633];


coefOm4=[0.354815,+0.128006,+0.006670;
    0.357011,+0.105883,+0.014657;
    0.359422,+0.078493,+0.024213;
    0.360746,+0.062377,+0.029686;
    0.362204,+0.044465,+0.035668;
    0.363814,+0.024566,+0.042210;
    0.365544,+0.002315,+0.049405;
    0.367453,-0.022476,+0.057305;
    0.369564,-0.050213,+0.066011;
    0.371904,-0.081107,+0.075588;
    0.374472,-0.115804,+0.086199;
    0.377395,-0.154695,+0.097943;
    0.380639,-0.198540,+0.111023;
    0.384260,-0.248263,+0.125671;
    0.388340,-0.304681,+0.142107;
    0.392817,-0.369141,+0.160695;
    0.397925,-0.442936,+0.181769;
    0.403558,-0.528171,+0.205892;
    0.409964,-0.627363,+0.233690;
    0.417199,-0.743461,+0.265973;
    0.425338,-0.880748,+0.303872;
    0.434430,-1.045211,+0.348958;
    0.444660,-1.244694,+0.403318;
    0.455953,-1.490920,+0.470084;
    0.468381,-1.800826,+0.553826];

figure
plot(I,coefphi4(:,1)','r+-','linewidth',2)
hold on
plot(I,coefphi4(:,2)','b+-','linewidth',2)
hold on
plot(I,coefphi4(:,3)','g+-','linewidth',2)
legend('P_1','P_2','P_3')
set(gca, 'FontSize', 20, 'fontName','Times');
xlabel('\mu_0I_0 (nT)','Fontsize',30)
ylabel('\Phi fit parameters','Fontsize',30)


figure
plot(I,coefOm4(:,1)','r+-','linewidth',2)
hold on
plot(I,coefOm4(:,2)','b+-','linewidth',2)
hold on
plot(I,coefOm4(:,3)','g+-','linewidth',2)
legend('P_1','P_2','P_3')
set(gca, 'FontSize', 20, 'fontName','Times');
xlabel('\mu_0I_0 (nT)','Fontsize',30)
ylabel('\Omega/\Phi fit parameters','Fontsize',30)


