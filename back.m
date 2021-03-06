clear;
L = 171.8;
u0 = 10.288;
rho = 1000;
delta = 15/57.3;
m = newmodel(L, [u0, 0], rho);
ta = 100;
tb = 450;
y_init = [6.9133, -1.2124, 0.0155, 0.2618];
Ya = solveODE(m, 0, y_init, 0:ta-1);
Yb = solveODE(m, ta-1, [Ya(ta,1:3), 0], ta:tb-1);
% plot(ta:tb-1, Yb(:,3));
T = 0:tb-1;
Y = [Ya ; Yb];
psi = cumsum(Y(:,3));
xi = cumsum(Y(:,1).*cos(psi) - Y(:,2).*sin(psi));
yi = cumsum(Y(:,1).*sin(psi) + Y(:,2).*cos(psi));
subplot(1, 3, 1);
plot(xi, -yi); % 图1：回舵试验运行轨迹
xlabel('X');
ylabel('Y');
axis equal;
title('回舵试验轨迹曲线')
subplot(1, 3, 2);
plot(T, cumsum(Y(:,3))); % 图2：回舵试验首向角psi变化
title('回舵试验首向角\psi变化');
xlabel('时间t/s')
ylabel('首向角\psi');
subplot(1, 3, 3);
semilogy(T, Y(:,3) ); % 图3：回舵试验角速度r变化
title('回舵试验角速度r 变化');
xlabel('时间t /s')
ylabel('角速度 (s^{-1})');
