clear all
clc
close all
%此程序可研究有可变耦合强度的情况下固定时滞时最大同步误差变化的情况
global a1;
global b1;
global c1;
global d1;
global s1;
global r1;
global x01;
global Iext1;

global a2;
global b2;
global c2;
global d2;
global s2;
global r2;
global x02;

global I0;
global k;

a1=1.0;
b1=3.0;
c1=1.0;
d1=5.0;
s1=4.0;
r1=0.002;
x01=-1.60;
Iext1=1.8;

a2=1.0;
b2=3.0;
c2=1.0;
d2=5.0;
s2=4.0;
r2=0.002;
x02=-1.60;
I0=2.3;
k=25;
err1=[];
% lentao=length(1:1:20);%
% err1(1:lentao,1)=1:1:20;
 
for k=10:1:30
    j=1;
for tao=0.05:0.01:0.09
   ddefun=@(t,y,z)[y(2)-a1*y(1)*y(1)*y(1)+b1*y(1)*y(1)+Iext1-y(3)+k*(z(4,1)-y(1));
    c1-d1*y(1)*y(1)-y(2);
    r1*s1*(y(1)-x01)-r1*y(3);
    y(5)-a2*y(4)*y(4)*y(4)+b2*y(4)*y(4)+I0-y(6)+k*(z(1,1)-y(4));
    c2-d2*y(4)*y(4)-y(5);
    r2*s2*(y(4)-x02)-r2*y(6)];
    % 定义时滞向量 —— lags
    lags = [tao];
    % 定义初值 —— history
    history =[-1.61045114054940	-11.9764876077047	1.45977669113604 -1.60815959722145	-11.9159578476135	1.98870321686002];
    %history =[0 0 0 0 0 0];
    % 定义时间积分区间 —— tspan
    tspan = [0:0.01:1000];
    sol=dde23(ddefun,lags,history,tspan);
    sol.y=(sol.y)';
    e1=abs(sol.y(:,1)-sol.y(:,4));
    e2=abs(sol.y(:,2)-sol.y(:,5));
    e3=abs(sol.y(:,3)-sol.y(:,6));
    err=(e1+e2+e3)/3;
    %b=max(err);
    % err1(round(10*k+1),2)=b;
    %err=max(e1);
    b=max(err);
    err1(k,j)=b;
    j=j+1;
    disp(k);
    disp(tao);
    end
end
% figure(4)
% plot(err1(:,1),err1(:,2),'r')
% xlabel('同步误差随时滞逐渐增加的变化趋势')
% ylabel('同步误差')
hold on
grid on