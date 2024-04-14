close all; clear all; clc; 
%%%conversation d'une image noire et blanche en binaire
%%%actuellement, binaryimage 16 bis est le logo batman, 16 la carte du
%%%monde et 17 un dessin batman mais vous pouvez attribuez une matrice à
%%%chaque image 
A = imread("binaryimage16bis.mat");
b=2;
M = 2^b; 
df=1000;
f0 = 10000; 
T = 1/(2*df); 


info = str2num(dec2bin(reshape(A(:,:,1),[1, numel(A(:,:,1))]), 8));

for i = 1:length(info)
    if (info(i) ~=11111111)&& info(i) ~=0
        info(i)
        info(i) = 1;
    end
end

save binaryimage16bis.mat info






