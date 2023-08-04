%此程序可研究无时滞的情况下最大同步误差随耦合强度k变化的情况
clear all
clc
close all

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
x01=-1.60;%x02=-1.6013
Iext1=1.8;

a2=1.0;
b2=3.0;
c2=1.0;
d2=5.0;
s2=4.0;
r2=0.002;
x02=-1.60;%x02=-1.6013
I0=2.3;

dt=1/1024;
td=1000;
t=0:dt:td; 
err1=[];
%2022-09-21上午11点先只计算0-2的同步误差
n=length(0:0.01:3);
err1(1:n,1)=0:0.01:3;
j=1;
%系统误差已改为只有e1
for k=0:0.01:3
    %初值为t=1500时两种激励下的响应值
    %[t,y]=ode45('HR_neuron_2couple',t,[ -1.35389810066076	-8.23047992758630	1.55244510861234 -1.09821458511096	-5.22595016227622	1.99827887361598]);
    [t,y]=ode45('HR_neuron_2couple',t,[0 0 0 0 0 0]);
    
    e1=abs(y(:,1)-y(:,4));
    %e2=abs(y(:,2)-y(:,5));
    %e3=abs(y(:,3)-y(:,6));
    %err=(e1+e2+e3)/3;
    err=abs(e1);
    b=max(err);
   % err1(round(10*k+1),2)=b;
    err1(j,2)=b;
    j=j+1;
end
figure
plot(err1(:,1),err1(:,2),'r')
xlabel('同步误差随耦合强度k逐渐增加的变化趋势')
ylabel('同步误差')
hold on
grid on