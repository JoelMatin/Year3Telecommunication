close all;clear all; clc;
%%% simulation d'un radar 


load("aleatoireetape66.mat")
load("sumetape66.mat")

x = somme;

Q = 1024;     %nombres d'échantillons
fs = 44100;  %fréquence d'échantillonement
Ts = 1/fs;    %temps entre deux échantillons

t = 0:Ts:(Q-1)*Ts;
h = zeros(1,Q);

tr=6.58*10^-3;
td=1.47*10^-3;
alphad=1;
alphar=1/5;
id_td = round(td/Ts);
id_tr = round(tr/Ts);
h(id_td)= alphad;
h(id_tr)= alphar;
%figure(2)
%plot(h)


%Proba de fausse alarme (Détecter une cible sur les échantillons où il y en
%a pas ==> Pfa = prob(h(round(td/Ts))&h(round(tr/Ts)) < Seuil du SNR)
%Proba de détection manqué(Ne pas détecter la cible représentée par le
%second trajet) ==> Pd = prob(h(round(td/Ts))&h(round(tr/Ts)) > Seuil du SNR)
%semilogx(Pfa,Pd)

y = conv(x,h);
y = y(1:1024);
%figure(4)
%plot(y)
Psignal = sum(x.*x)/length(x);
%SNRdB = 18;
nb_seuil = 10/0.125;
nb_real = 50;
liste_Pdetec = zeros(40, nb_seuil); 
liste_PFA = zeros(40, nb_seuil);
counterSNR = 1;
for SNRdB = [2, 18]
    SNR = 10^(SNRdB/10);
    Pn = Psignal/SNR;
    counter = 0;
    for seuil = -30:0.125:-20-0.125
        P = 0; %%nombre de points à détecter (1 par réal = pic réfléchis)
        N = 0; %% nombre de points à pas détecter   
        FA = 0; 
        FN = 0;
        %TA = 0;
        %TN = 0; 
        for real = 1:nb_real
            P = P +1;
            n = randn(1, Q)*sqrt(Pn);
            yn = y + n;
            hbruit = rep_impulse(fs, 1024, aleatoire, yn);
            hbruit = abs(hbruit);
            hbruit = 10*log10(hbruit.^2/max(hbruit.^2));
%             figure(1)
%             plot(hbruit)
            hbruit = hbruit(id_td+5:end);
%             figure(1)
%             plot(hbruit);
            Ir = id_tr-id_td-5+1;   % nouveau indice du pic réfléchis après troncature de hbruit
            N = N + 1024-id_td-5-1; % on retire avant le premier pic compris et 1 car le petit pic est un cas positif
            pointdetectes = find(hbruit>seuil); % renvoie les indices
            L = length(pointdetectes);
            Lh = length(hbruit);
            % TN = Lh-1-L;    points de bruits non détectés
            if ~ismember(Ir, pointdetectes)
                
                FN = FN+1;  %pic réfléchis qui n'est pas détectés
                FA = FA +L; %tous les points détectés sont du bruit
            else
                
                %TA = TA +1; % pic réfléchis détectés, on doit en avoir 1 en + à chaque real
                FA = FA +L-1;   % points de bruits qui sont détectés
            end
        end
        PDetec = 1-FN/P; % en réalité = 1-FN/(FN+TA) mais FN + TA = P 
        PFA = FA/N;      % = FA/(FA+TN) mais FA+TN = N
        counter = counter +1;
        liste_PFA(counterSNR, counter) = PFA;  % il y a une probalité par seuil
        liste_Pdetec(counterSNR, counter) = PDetec;
    end
    figure(2)
    semilogx(liste_PFA(counterSNR,:), liste_Pdetec(counterSNR,:))
    hold on
    counterSNR = counterSNR +1;
end


