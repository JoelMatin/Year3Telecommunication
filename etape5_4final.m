close all; clear all; clc; 
load("receivedFSK16.mat")
load("binaryimage16.mat")
figure(4)
plot(son)

i = 1;
while son(i)<0.8
    i = i+1;
end

start = i;
son = son(start:start+480000-1);   %on repère quand le son commence


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

for n = 0:ntot-1
    t = n*T:Ts:(n+1)*T-Ts;
    fi = [f0, f0+df, f0+2*df, f0+3*df];
    [~, I] = max(abs(trapz(son(n*a+1:(n+1)*a).*exp(-1i*2*pi*t'*fi))));
    m = dec2bin(I-1,2); %%% on fait -1 car si on a le max en corr(4), ça correspond à i = m = 3
    infor = [infor, m];
end 

r = 0;

for i=1:40000
    final = [final, str2num(infor(i))];
end

save receivedbinary16.mat final 

compare = final' == info;
error = length(find(compare<1));
image = reshape(final,[200, 200]);
figure(5)
imshow(image)
