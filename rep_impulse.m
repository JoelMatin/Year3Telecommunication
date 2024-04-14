function h = rep_impulse(fs,Q,aleatoire,y)
H = zeros(1,Q/2);
Ts = 1/fs;
t = 0:Ts:(Q-1)*Ts;
f = 0:fs/Q:(Q/2-1)*fs/Q;

H(:)= sum(aleatoire.* y'.*exp(-1i*2*pi*t'*f));    %%% ici on fait t'*f pour avoir un produit matriciel et chaque freq à chaque temps


Hfinal= [conj(flip(H(1:end))),H];
f = -fs/2:fs/Q:fs/2-fs/Q;
figure(1)
plot(f, abs(10*log10(Hfinal)))
h = ifft(Hfinal);

end


