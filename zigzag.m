clear;
L = 171.8;
u0 = 10.288;
rho = 1000;
m = newmodel(L, [u0, 0], rho);
angle = 10/57.3;
ddelta = 1/57.3;

l = 2500;
delta_t = 0;
yt = [u0, 0, 0, delta_t];
Y = zeros(l, 4);
psi = zeros(1, l);
delta = zeros(1, l);
i=1;
for times = 1:5
    while delta_t < angle
        yt = solveODE(m, 0, yt, 1);
		Y(i,:) = yt;
		i = i+1;
		delta(i) = delta_t;
		delta_t = delta_t + ddelta;
		yt(4) = delta_t;
		psi(i) = psi(i-1) + yt(3);
	end
	while psi(i) < angle
        yt = solveODE(m, 0, yt, 1);
		Y(i,:) = yt;
		i = i+1;
		delta(i) = delta_t;
		psi(i) = psi(i-1) + yt(3);
	end
	while delta_t > -angle
	    yt = solveODE(m, 0, yt, 1);
		Y(i,:) = yt;
		i = i+1;
		delta(i) = delta_t;
		delta_t = delta_t - ddelta;
		yt(4) = delta_t;
		psi(i) = psi(i-1) + yt(3);
	end
	while psi(i) > -angle
        yt = solveODE(m, 0, yt, 1);
		Y(i,:) = yt;
		i = i+1;
		delta(i) = delta_t;
		psi(i) = psi(i-1) + yt(3);
	end
end
plot(1:i-1, delta(1:i-1), 1:i-1, psi(1:i-1) );
title('Z形操舵试验');
xlabel('时间t/s');
ylabel('角度');
