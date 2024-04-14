close all; clear all; clc; 
%%%génération du FSK


load("binaryimage16bis.mat")
for z=1:length(info)
    if info(z) == 11111111
        info(z) = 1;
    end
end

save binaryimage16bis.mat info

fs = 48000; 
Ts = 1/fs; 
b=2;
M = 2^b; 
df=1000;
f0 = 10000;
T = 1/(2*df); 
ntot = 200*200/b;
ttot = (ntot)*T;
stot = [];


for n =1:ntot
    m = bin2dec([num2str(info(2*n-1)), num2str(info(2*n))]);    %m vaut la valeur décimale formée par le nième groupe en binaire
    fm = f0 +df*m; 
    t = n*T:Ts:(n+1)*T-Ts;
    s_m = cos(2*pi*fm*t);
    stot = [stot, s_m];
end



audiowrite("randomsignalaudio16bis.wav",stot, fs)
save randomsignal16bis.mat stot






