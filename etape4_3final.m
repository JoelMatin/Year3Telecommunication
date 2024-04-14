close all; clear all; clc; 

load("randomsignal16.mat") % pour la carte du monde

fs = 48000; 
Ts = 1/fs; 
b=2;
M = 2^b; 
df=1000;
T = 1/(2*df); 
ntot = 200*200/b;
ttot = (ntot)*T;
[PSD, ff] = welch(stot,10, 20000, 15000); 
plot(ff, PSD)