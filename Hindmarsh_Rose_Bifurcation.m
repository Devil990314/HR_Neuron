%利用庞佳莱截面绘制分岔图
%截面采用公式Ax+By+Cz+D=0;的形式
%Rossler方程
clear
clc
close all
h=2e-3;%时间步长
x0=0:h:1500;%时间
y0=[1;1 ;1];

%不同的c开始循环
c=1.2:0.01:3.6;
N_c=length(c);
N_P=300;%假设穿过截面的共有300个点
BF=nan(N_c,N_P);
for k=1:N_c
    c_k=c(k);disp(c_k)
    %计算出轨迹
    [y1,~]=ODE_RK4_hyh(x0,h,y0,[1,3,1,5,4,0.002,-1.6,c_k]);
    %计算Poincare平面
    Plane=[1;0;0;0.1];%x=0.1平面(正方向)
    [tP_List,yP_List]=Solve_Poincare(x0,y1,Plane);%计算Poincare平面
    %储存y值作为待会分岔图的点
    N_P_temp=size(tP_List,2);
    if N_P_temp>N_P
        BF(k,1:N_P)=yP_List(2,1:N_P);
    else
        BF(k,1:N_P_temp)=yP_List(2,1:N_P_temp);
    end
end

%绘制分岔图
figure()
hold on
for k=1:N_c
    c_k=c(k);
    plot(c_k*ones(1,N_P-30+1),BF(k,30:N_P),...
        'LineStyle','none','Marker','.','MarkerFaceColor','k','MarkerEdgeColor','k',...
        'MarkerSize',1)
end
hold off

%后置函数
function [tP_List,yP_List]=Solve_Poincare(t,y,Plane)
%截面方程z=0
% Plane=[0;0;1;0];%一般情况下是个垂直某个轴的平面
%一般只记录从负到正穿越。如果想反向也记录，可以设置Plane=-Plane。

%第二步，插值得到线与面的交点
yP_List=[];
tP_List=[];
Dis=DistancePlane(y,Plane);
N=size(y,2);
for k=1:N-1
    if Dis(k)<=0 && Dis(k+1)>0
        t0=t(k);t1=t(k+1);
        yP0=y(:,k);yP1=y(:,k+1);
        Dis0=Dis(k);Dis1=Dis(k+1);
        %一维线性插值，求Dis=0时的t和y
        %（相比较前面积分的4阶RK，这里用线性插值精度有点低）
        yP=yP0+(yP1-yP0)/(Dis1-Dis0)*(0-Dis0);
        tP=t0+(t1-t0)/(Dis1-Dis0)*(0-Dis0);
        %储存
        yP_List=[yP_List,yP];
        tP_List=[tP_List,tP];
    end
end
end

%点到平面的距离
function Dis=DistancePlane(xk,Plane)
% xk，坐标点，如果是3维坐标，大小就是3*N的矩阵。
% Plane，平面，形如Ax+By+Cz+D=0形式的平面。
N=size(xk,2);%计算总共多少个点
xk2=[xk;ones(1,N)];
Dis=dot(xk2,Plane*ones(1,N),1)./norm(Plane(1:end-1));
end

%两点线性插值
function y=interp2point_linear(x0,x1,y0,y1,x)
y=y0+(y1-y0)/(x1-x0)*(x-x0);
end

%两点3次插值
function y=interp2point_spline(x0,x1,y0,y1,x)
%y0包含y0的值和y0的导数,yy=y0(1),dy=y0(2)
xx0=x0;
xx1=x1;
yy0=y0(1);dy0=y0(2);
yy1=y1(1);dy1=y1(2);
cs = csape([xx0,xx1],[dy0,yy0,yy1,dy1],[1,1]);
y=ppval(cs,x);
end

function[F,Output]=Fdydx(x,y,Input)
a = Input(1);b = Input(2);c0 = Input(3);d = Input(4);s = Input(5);
r = Input(6);x0 = Input(7);c = Input(8);
dy(1)=y(2)-a*y(1)*y(1)*y(1)+b*y(1)*y(1)-y(3)+c;%此处C代表Iext,
dy(2)=c0-d*y(1)*y(1)-y(2);%此处C0代表c,
dy(3)=r*s*(y(1)-x0)-r*y(3);
F=[dy(1);dy(2);dy(3)];
Output=[];
end
% function [F,Output]=Fdydx(x,y,Input)
% %形式为Y'=F(x,Y)的方程，参见数值分析求解常系数微分方程相关知识
% %高次用列向量表示，F=[dy(1);dy(2)];y(1)为函数，y(2)为函数导数
% %Rossler 吸引子
% a=Input(1);
% b=Input(2);
% c=Input(3);
% 
% dy(1)=-y(2)-y(3);
% dy(2)=y(1)+a*y(2);
% dy(3)=b+y(3)*(y(1)-c);
% 
% F=[dy(1);dy(2);dy(3)];
% Output=[];
% end

function [y,Output]=ODE_RK4_hyh(x,h,y0,Input)
%4阶RK方法
%h间隔为常数的算法
y=zeros(size(y0,1),size(x,2));
y(:,1)=y0;
for ii=1:length(x)-1
    yn=y(:,ii);
    xn=x(ii);
    [K1,~]=Fdydx(xn    ,yn       ,Input);
    [K2,~]=Fdydx(xn+h/2,yn+h/2*K1,Input);
    [K3,~]=Fdydx(xn+h/2,yn+h/2*K2,Input);
    [K4,~]=Fdydx(xn+h  ,yn+h*K3  ,Input);
    y(:,ii+1)=yn+h/6*(K1+2*K2+2*K3+K4);
end
Output=[];
end
