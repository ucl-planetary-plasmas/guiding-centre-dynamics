close all; clear all;

%% Planets
filename = 'planets.mat';
mu0 = 1.2567e-6; %μ0 = 1.25663706212(19)×10−6 H/m

% Saturn
Saturn.Rp = {60330e3, 'm'}; 
Saturn.Tp = {10.543, 'h'};
Saturn.Op = {2*pi/(Saturn.Tp{1}*3600), 'Hz'};
Saturn.Mp = {600*7.906e15, 'T.m3'};
Saturn.Bp = {mu0*Saturn.Mp{1}/(4*pi*Saturn.Rp{1}^3), 'T'};

% Jupiter
Jupiter.Rp = {71398e3, 'm'}; 
Jupiter.Tp = {9.925, 'h'};
Jupiter.Op = {2*pi/(Jupiter.Tp{1}*3600), 'Hz'};
Jupiter.Mp = {20000*7.906e15, 'T.m3'};
Jupiter.Bp = {mu0*Jupiter.Mp{1}/(4*pi*Jupiter.Rp{1}^3), 'T'};

% Earth
Earth.Rp = {6373e3, 'm'}; 
Earth.Tp = {23.934, 'h'};
Earth.Op = {2*pi/(Earth.Tp{1}*3600), 'Hz'};
Earth.Mp = {7.906e15, 'T.m3'};
Earth.Bp = {mu0*Earth.Mp{1}/(4*pi*Earth.Rp{1}^3), 'T'};

save(filename, 'Saturn', 'Jupiter', 'Earth');

%% Particles
filename = 'particles.mat';

% particle [q, m]
en = [-1, 5.486e-4];% 5.48579909065(16)×10−4 Da==u==uma
hp = [1, 1];
h2p = [1, 2];
wp = [1, 17.6];%approx from wilson2015, in Sittler 2006 ranges
op = [1, 16];
opp = [2, 16];
ohp = [1, 17];
h2op = [1, 18];
h3op = [1, 19];
sp = [1, 32];
spp = [2, 32];
sppp = [3, 32];

save(filename, 'en', 'hp', 'h2p', 'wp', ...
    'op', 'opp', 'ohp', 'h2op', 'h3op', ...
    'sp', 'spp', 'sppp');