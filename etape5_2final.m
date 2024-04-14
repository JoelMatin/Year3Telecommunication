close all; clear all; clc; 
%%% test de récepteur cohérent

load("randomsignal16.mat")
load("binaryimage16.mat")

fs = 48000; 
Ts = 1/fs; 
b=2;
M = 4; 
df=1000;
f0 = 10000;
T = 1/(2*df); 
ntot = 200*200/b;
pas = Ts;
ttot = ntot*T;
infor = [];
final = [];
a = T/Ts;
phi = pi;

for n = 0:ntot-1
    t = n*T:Ts:(n+1)*T-Ts;
    t = n*T:Ts:(n+1)*T-Ts;
    fi = [f0, f0+df, f0+2*df, f0+3*df];
    [~, I] = max(abs(trapz(stot(n*a+1:(n+1)*a)'.*exp(-1i*2*pi*t'*fi+phi))));
    m = dec2bin(I-1,2); %%% on fait -1 car si on a le max en corr(4), ça correspond à i = m = 3
    infor = [infor, m];
end 


for i=1:length(info)
    final = [final, str2num(infor(i))];
   
end

compare = final' == info;
errors = length(find(compare<1));     %trouve le nombre d'erreurs
image = reshape(final,[200, 200]);
figure(1)
imshow(image)
hold on





