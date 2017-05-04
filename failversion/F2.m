function [F2] = F2(u,v,r,rad,u0)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
P=1000;    %水密度为1000  kg/m^3
L = 160.93;
%L=171.8;   %船长171.8  m
V=sqrt(u^2+v^2);   %得到航速
%将水动力导数有量纲化
a1=P*L*L*L/2;
a2=P*L*L*V/2*(u-u0);
a3=P*L*L/2*(u-u0)^2;
a4=P*L*L/(2*V)*(u-u0)^3;
a5=P*L*L/2*v^2;
a6=P*L*L*L*L/2*r^2;
a7=P*L*L*V*V/2*rad^2;
a8=P*L*L/(2*V)*v^2*(u-u0);
a9=P*L*L*L*L/(2*V)*r^2*(u-u0);
a10=P*L*L*V/2*rad^2*(u-u0);
a11=P*L*L*L/2*v*r;
a12=P*L*L*V/2*v*rad;
a13=P*L*L*L*V/2*r*rad;
a14=P*L*L*L/(2*V)*v*r*(u-u0);
a15=P*L*L/2*v*rad*(u-u0);
a16=P*L*L*L/2*r*rad*(u-u0);
a17=P*L*L*V*V/2*0;
b1=P*L*L*L/2;
b2=P*L*L*L*L/2;
b3=P*L*L*V/2*v;
b4=P*L*L/(2*V)*v^3;
b5=P*L*L*L*L/(2*V)*v*r^2;
b6=P*L*L*V/2*v*rad^2;
b7=P*L*L/2*v*(u-u0);
b8=P*L*L/(2*V)*v*(u-u0)^2;
b9=P*L*L*L*V/2*r;
b10=P*L*L*L*L*L/(2*V)*r^3;
b11=P*L*L*L/(2*V)*r*v^2;
b12=P*L*L*L*V/2*r*rad^2;
b13=P*L*L*L/2*r*(u-u0);
b14=P*L*L*L/(2*V)*r*(u-u0)^2;
b15=P*L*L*V*V/2*rad;
b16=P*L*L*V*V/2*rad^3;
b17=P*L*L/2*rad*v^2;
b18=P*L*L*L*L/2*rad*r^2;
b19=P*L*L*V/2*rad*(u-u0);
b20=P*L*L/2*rad*(u-u0)^2;
b21=P*L*L*L/2*v*r*rad;
b22=P*L*L*V*V/2*0;
b23=P*L*L*V/2*(u-u0);
b24=P*L*L/2*(u-u0)^2;
xf1=[a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17];
xf2=[b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24];
xf3=L*xf2;
a=[-0.0253 0.00948 -0.00217 -0.189 0.00379 -0.02 0 0 0 0.168 0.0196 0 0 0 0 0];
a=a.';
b=[-0.244	-1.702	0	-0.008	0	0	-0.105	0	3.23	0	0	0	-0.0586	0.00975	-0.25	0	0	0	0	-0.008	0	0];
b=b.';
c=[-0.0555	0.345	0	0.00264	0	0	-0.0349	0	-1.158	0	0	0	0.0293	-0.00482	-0.1032	0	0	0	0	0.00059	0	0];
c=c.';
f2 = xf2*b;
f3 = xf3*c;
F2 = (b2*L*0.0175*f2+b2*0.0018*f3)/(b1*b2*L*0.327*0.0175-b1*b2*L*0.0018*0.00478);


end