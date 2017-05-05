clear;
L = 171.8;
u0 = 10.288;
rho = 1000;
delta = [15/57.3, 35/57.3];
hold on;
for i = 1:2
    deltai = delta(i);
    m = newmodel(L, [u0, 0], rho);
    t = 0:600;
    Y = solveODE(m, 0, [u0, 0, 0, deltai], t);
    psi = cumsum(Y(:,3));
    xi = cumsum(Y(:,1).*cos(psi) - Y(:,2).*sin(psi));
    yi = cumsum(Y(:,1).*sin(psi) + Y(:,2).*cos(psi));
    subplot(2, 2, i*2-1);
    plot(xi, -yi);
	title('回转试验轨迹');
	xlabel('X');
	ylabel('Y');
    axis equal;
	subplot(2, 2, i*2);
	plot(t, Y(:,3));
	title('回转试验航向角速度曲线');
	xlabel('t');
	ylabel('r');
end

