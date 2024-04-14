function [psd,f] = welch(x,T,L,D)
% INPUTS :
% - x : input signal
% - T : sample duration
% - L : segment size
% - D : delay between segments
% OUTPUTS :
% - psd : power spectral density
% - f : frequency range
% Gather segments in a matrix
N = floor((length(x)-L)/D + 1) ;
Xt = [] ;
for nn = 1 :N
    nn
    Xt = [Xt , x((nn-1)*D+1 :(nn-1)*D+L).'] ;
end 
% Multiply with window and compute FFT
W = 1 - ([0 :L-1]-(L-1)/2).^2 * 4/(L+1)^2 ;
Wt = repmat(W',1,N) ;
Yf = fftshift(fft(Xt.*Wt,L,1),1) ;
% Compute PSD
f = [-L/2 :L/2-1]/L/T ;
psd = sum(abs(Yf).^2,2)'/N ;
psd = psd/max(psd) ;
end