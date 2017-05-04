clear;
L = 171.8;
u0 = 10.288;
rho = 1000;
delta = 15/57.3;
m = newmodel(L, [u0, 0], rho);
ta = 100;
tb = 360;
y_init = [6.9133, -1.2124, 0.0155, 0.2618];
Ya = solveODE(m, 0, y_init, 0:ta-1, 0.5);
Yb = solveODE(m, ta-1, [Ya(ta,1:3), 0], ta:tb-1, 0.5);
% plot(ta:tb-1, Yb(:,3));
T = 0:tb-1;
Y = [Ya ; Yb];
psi = cumsum(Y(:,3));
xi = cumsum(Y(:,1).*cos(psi) - Y(:,2).*sin(psi));
yi = cumsum(Y(:,1).*sin(psi) + Y(:,2).*cos(psi));
plot(xi, -yi); % 图1：回舵试验运行轨迹
% plot(T, cumsum(Y(:,3))); % 图2：回舵试验首向角psi变化
% plot(T, log( Y(:,3) ) ); % 图3：回舵试验角速度r变化