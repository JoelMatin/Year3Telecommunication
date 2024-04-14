close all; clear all; clc;

son = audioread("Enregistrement16.m4a");
plot(son(:,1))
son = son(:,1);

save receivedFSK16.mat son






