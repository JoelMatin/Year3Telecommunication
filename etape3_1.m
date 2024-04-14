close all; clear all; clc; 
%%génération du signal envoyé qui est une somme de cosinus 

Q = 1024;        %nombres d'échantillons
fs = 48000;      %fréquence d'échantillonement
Ts = 1/fs;       %temps entre deux échantillons
t = 0:Ts:(Q-1)*Ts;


somme = zeros(1, Q);

aleatoire = zeros(1, Q/2);
j = 1;
for f=0:fs/Q:fs/2-fs/Q
    i = 0; 
    while i ==0
        i = randi([-1, 1]);
    end
    aleatoire(j) = i;
    j = j+1;
end 

f = 0:fs/Q:fs/2-fs/Q; 
somme = sum(aleatoire.*cos(2*pi*t'*f), 2)';

for j = 1:7
    somme = [somme, somme];        % on répète le signal sur plusieurs périodes
end

figure(6)
plot(somme)

audiowrite("etape3_son2.wav", somme, 48000)
save etape3_aleatoire2 aleatoire