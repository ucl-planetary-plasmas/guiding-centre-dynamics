clear all
clc

coefphi3=[1.271221,-0.530201,-0.002586;
    1.276768,-0.514755,-0.009848;
    1.280676,-0.505745,-0.014567;
    1.285350,-0.498063,-0.019362;
    1.291236,-0.491165,-0.024510;
    1.294759,-0.483809,-0.028969;
    1.296168,-0.475836,-0.032830;
    1.295851,-0.467083,-0.036235;
    1.294217,-0.457595,-0.039291;
    1.291656,-0.447567,-0.042071;
    1.288539,-0.437297,-0.044628;
    1.285220,-0.427164,-0.046991;
    1.283569,-0.422228,-0.048112;
    1.281952,-0.417411,-0.049194;
    1.278881,-0.408249,-0.051240;
    1.276068,-0.399781,-0.053134;
    1.265810,-0.366706,-0.060874;
    1.258914,-0.341260,-0.067288;
    1.252727,-0.317391,-0.073406;
    1.246447,-0.293946,-0.079243;
    1.240430,-0.272094,-0.084524;
    1.235065,-0.252632,-0.089159;
    1.230362,-0.235384,-0.093243];
    
coefOm3=[0.352447,+0.146283,+0.000309;
    0.354598,+0.138856,+0.002647;
    0.356756,+0.130912,+0.004763;
    0.358529,+0.124128,+0.006740;
    0.359403,+0.119185,+0.008561;
    0.359841,+0.114119,+0.010618;
    0.359886,+0.108674,+0.012937;
    0.359684,+0.102617,+0.015512;
    0.359334,+0.095639,+0.018355;
    0.359215,+0.087772,+0.021372;
    0.359496,+0.078722,+0.024559;
    0.360202,+0.068114,+0.027951;
    0.360746,+0.062377,+0.029686;
    0.361348,+0.056572,+0.031417;
    0.362475,+0.044791,+0.034900;
    0.363686,+0.033201,+0.038313;
    0.368411,-0.022911,+0.055024;
    0.371696,-0.077839,+0.071567;
    0.374025,-0.133568,+0.088381;
    0.375963,-0.190215,+0.105383;
    0.377508,-0.247416,+0.122422;
    0.378535,-0.304277,+0.139302;
    0.379160,-0.360080,+0.155867];

D=[0.1 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.5 2.6 2.8 3 4 5 6 7 8 9 10];

figure
plot(D,coefphi3(:,1)','r+-','linewidth',2)
hold on
plot(D,coefphi3(:,2)','b+-','linewidth',2)
hold on
plot(D,coefphi3(:,3)','g+-','linewidth',2)
legend('P_1','P_2','P_3')
xlabel('D (R_s)')
ylabel('\Phi fit parameters')
set(gca, 'FontSize', 20, 'fontName','Times');
xlabel('D (R_s)','Fontsize',30)
ylabel('\Phi fit parameters','Fontsize',30)


figure
plot(D,coefOm3(:,1)','r+-','linewidth',2)
hold on
plot(D,coefOm3(:,2)','b+-','linewidth',2)
hold on
plot(D,coefOm3(:,3)','g+-','linewidth',2)
legend('P_1','P_2','P_3')
set(gca, 'FontSize', 20, 'fontName','Times');
xlabel('D (R_s)','Fontsize',30)
ylabel('\Omega/\Phi fit parameters','Fontsize',30)




