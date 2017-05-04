
function [result] = newmodel(L, U0, rho)
% 返回一个关于u, v, rad, delta的多元常微分方程组。若参数为空，取默认值：L=171.8m, u0=10.288 m/s, v0=0, rho = 1000 kg/m^3。
% Author: YanZhiyong/严志勇
% 此函数用于建立基于Abkowitz的船舶操纵模型
switch nargin
    case 3
	case 2
	    rho = 1000;
	case 0
	    L = 160.93;
		U0 = [10.288, 0];
		rho = 1000;
	otherwise
	    error('no appropriate input for this function');
end
u0 = U0(1);
v0 = U0(2);
U = sqrt(u0.^2 + v0.^2);
p = rho;
a=[-0.0253,0.00948,-0.00217,-0.189,0.00379,-0.02,0.168,0.0196,-0.008,-0.244,-1.702,-0.008,-0.105,3.23,-0.0586,0.00975,-0.25,0.00059,-0.0555,0.345,0.00264,-0.0349,-1.158,0.0293,-0.00482,-0.1032];
b(1)=a(1)*0.5*p*U*L^2;
b(2)=a(2)*0.5*p*L^2;
b(3)=a(3)*0.5*p*L^2/U;
b(4)=a(4)*0.5*p*L^2;
b(5)=a(5)*0.5*p*L^4;
b(6)=a(6)*0.5*p*U^2*L^2;
b(7)=a(7)*0.5*p*L^3;
b(8)=a(8)*0.5*p*U*L^2;
b(9)=0;
b(10)=a(10)*0.5*p*U*L^2;
b(11)=a(11)*0.5*p*L^2/U;
b(12)=a(12)*0.5*p*U*L^2;
b(13)=a(13)*0.5*p*U*L^3;
b(14)=a(14)*0.5*p*L^3/U;
b(15)=a(15)*0.5*p*L^2*U^2;
b(16)=a(16)*0.5*p*L^2*U^2; 
b(17)=a(17)*0.5*p*L^2;
b(18)=0;
b(19)=a(19)*0.5*p*U*L^3;
b(20)=a(20)*0.5*p*L^3/U;
b(21)=a(21)*0.5*p*U*L^3;
b(22)=a(22)*0.5*p*U*L^4;
b(23)=a(23)*0.5*p*L^4/U;
b(24)=a(24)*0.5*p*L^3*U^2;
b(25)=a(25)*0.5*p*L^3*U^2;  
b(26)=a(26)*0.5*p*L^3;
du= @(u, v, r, d) (b(1)*(u-u0)+b(2)*(u-u0)^2+b(3)*(u-u0)^3+b(4)*v^2+b(5)*r^2+b(6)*d^2+b(7)*v*r+b(8)*v*d)/(0.177*0.5*p*L^3);
dv= @(u, v, r, d) ((b(9)+b(10)*v+b(11)*v^3+b(12)*v*d^2+b(13)*r+b(14)*r*v^2+b(15)*d+b(16)*d^3+b(17)*d*v^2)*(0.0175*0.5*p*L^5)-(b(18)+b(19)*v+b(20)*v^3+b(21)*v*d^2+b(22)*r+b(23)*r*v^2+b(24)*d+b(25)*d^3+b(26)*d*v^2)*(-0.0018*0.5*p*L^4))/((0.327*0.5*p*L^3)*(0.0175*0.5*p*L^5)-(-0.0018*0.5*p*L^4)*(-0.00478*0.5*p*L^4));
dr= @(u, v, r, d) ((b(18)+b(19)*v+b(20)*v^3+b(21)*v*d^2+b(22)*r+b(23)*r*v^2+b(24)*d+b(25)*d^3+b(26)*d*v^2)*(0.327*0.5*p*L^3)-(b(9)+b(10)*v+b(11)*v^3+b(12)*v*d^2+b(13)*r+b(14)*r*v^2+b(15)*d+b(16)*d^3+b(17)*d*v^2)*(-0.00478*0.5*p*L^4))/((0.327*0.5*p*L^3)*(0.0175*0.5*p*L^5)-(-0.0018*0.5*p*L^4)*(-0.00478*0.5*p*L^4));
result = @(x, Y) [du(Y(1), Y(2), Y(3), Y(4)), dv(Y(1), Y(2), Y(3), Y(4)), dr(Y(1), Y(2), Y(3), Y(4)), 0];
end