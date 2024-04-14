close all; clear all; clc; 
%%%performance de la communication audio

%load("receivedbinary15.mat")
load("binaryimage16.mat")
load("randomsignal16.mat")

y = stot; 
L = length(y); 
P = sum(y.^2)/length(y);

SNRdB_vector = 0:10;
error_vector = zeros(1, length(SNRdB_vector));
counter_error = 1; 
errors_tot = 0; 
nb_real = 5; 

for SNRdB = 0:10
    for real = 1:nb_real
        SNR = 10^(SNRdB/10); 
        Pn = P/SNR; % SNR
        noise = randn(1, L)*sqrt(Pn); 
        yn = y+noise; 
        nb_errors = recepteur_non_coherent(yn, info); 
        errors_tot = errors_tot + nb_errors; 
    end 
    errors_vector(counter_error)= errors_tot/length(info)*nb_real; 
    counter_error = counter_error +1; 
    errors_tot = 0; 
end

semilogy(SNRdB_vector, errors_vector)
