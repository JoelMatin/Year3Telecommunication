close all; clear all; clc; 

fs = 44100;  %fréquence d'échantillonement
Q = 1024;     %nombres d'échantillons
Ts = 1/fs;    %temps entre deux échantillons
t = 0:Ts:(Q-1)*Ts;
h = zeros(1, fs); 

somme = zeros(1, 1024);

aleatoire = zeros(1, Q/2);
j = 1;
for f=0:fs/Q:fs/2-fs/Q
    i = 0; 
    while i ==0
        i = randi([-1, 1]);
    end
    somme= somme + i*cos(2*pi*f*t); 
    aleatoire(j) = i;
    j = j+1;
end 

save sumetape66.mat somme 
save aleatoireetape66.mat aleatoire

x = somme; 
plot(x)



