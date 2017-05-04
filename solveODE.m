% Runge-Kutta Algorithm. A numerical method to solve ordinary differential equation (ODE).
% ˵�����ú�������һ����΢�ַ��̣���ʼ��ʹ���λ��x����øõ��ȡֵy

% myfun����΢�ַ��̣���������������ʽ���롣
% x_init����ʼ��ĺ����꣬Ϊһ������X����ʾ��΢�ַ�����Ψһ����֪��
% y_init����ʼ��������꣬Ϊһ������Y�������ĳ���Ϊ��Ԫ��΢�ַ��̵�δ֪������
% x�������ĺ����꣬����Ϊһ������
% h��������ȱʡֵΪ0.5
% result��������󣬾����������������x�ĳ��ȣ��������������δ֪���ĸ�����
%         ����ÿһ�д���һ������������δ֪����

% Test sample:
% wavefun = @(x,y) [y(2), -y(1)];
% x0=0;
% y0=[0 1];
% x=0:pi/6:pi*2;
% y=solveODE(wavefun, x0, y0, x)

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
    h = 0.5;
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
