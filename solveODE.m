% Runge-Kutta Algorithm.
% A numerical method to solve ordinary differential equation (ODE).
% 说明：该函数读入一个常微分方程，初始点和待求位置x，求得该点的取值y

% myfun：常微分方程，以匿名函数的形式读入。
% x_init：初始点的横坐标，为一个标量X，表示常微分方程中唯一的已知量
% y_init：初始点的纵坐标，为一个向量Y，向量的长度为多元常微分方程的未知量个数
% x：待求点的横坐标，可以为一个向量
% h：步长，缺省值为0.02
% result：结果矩阵，矩阵的行数等于向量x的长度，矩阵的列数等于未知量的个数。
%         矩阵每一行代表一个待求点的所有未知量。

% Test sample:
% wavefun = @(x,y) [y(2), -y(1)];
% x0=0;
% y0=[0 1];
% x=0:pi/6:pi*2;
% y=getODEsolu(wavefun, x0, y0, x)

% Answer:
% y =
% 
%          0    1.0000
%     0.5000    0.8660
%     0.8660    0.5000
%     1.0000    0.0000
%     0.8660   -0.5000
%     0.5000   -0.8660
%     0.0000   -1.0000
%    -0.5000   -0.8660
%    -0.8660   -0.5000
%    -1.0000   -0.0000
%    -0.8660    0.5000
%    -0.5000    0.8660
%    -0.0000    1.0000


function [result] = solveODE(myfun, x_init, y_init, x, h)

if nargin == 4
    h = 0.02;
end
if nargin < 4
    error('not enough parameter for this function');
end
if ~h>0
    error('h must be a positive number');
end
n = length(x);
p = zeros(n, length(y_init) );
for i=1:n
    p(i,:) = RGKT(myfun, x_init, y_init, x(i), h);
	x_init = x(i);
	y_init = p(i,:);
end
result = p;
end

function p = RGKT(f, t0, p0, t, h)

m = ceil( abs(t-t0)/h );
if m==0
    p = p0;
    return
end
dt = (t-t0)./m;
p = p0;
t = t0;
for i=1:m
    k1=f(t, p);
    k2=f(t + dt./2, p + dt./2 .* k1);
    k3=f(t + dt./2, p + dt./2 .* k2);
    k4=f(t + dt,p + dt .* k3);
    t = t + dt;
    p = p + dt.*(k1 + 2.*k2 + 2.*k3 + k4)/6;
end

end
