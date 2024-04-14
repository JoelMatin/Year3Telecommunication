close all; clear all; clc; 


load("etape3_aleatoire2.mat")

Q = 1024;     
fs = 48000;  
Ts = 1/fs;   
t = 0:Ts:(Q-1)*Ts;

son = audioread("etape_received5.m4a"); 
son = son(:, 1)';
figure(3)
plot(son)
start = 71000; 
son = son(start:start+Q-1); 

h = rep_impulse(fs, Q, aleatoire, son); 
figure(2)
plot(t, abs(h))

