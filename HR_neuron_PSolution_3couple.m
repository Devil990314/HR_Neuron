clear all
clc
close all

global a1;global b1;global c1;global d1;global s1;global r1;global x01;global Iext1;global H;
global a2;global b2;global c2;global d2;global s2;global r2;global x02;global Iext2;
global a3;global b3;global c3;global d3;global s3;global r3;global x03;global Iext3;global H;
global Q0;global omega;

a1=1.0;b1=3.0;c1=1.0;d1=5.0;s1=4.0;r1=0.0021;x01=-1.6013;Iext1=3.0;
a2=1.0;b2=3.0;c2=1.0;d2=5.0;s2=4.0;r2=0.0021;x02=-1.6013;Iext2=3.0;
a3=1.0;b3=3.0;c3=1.0;d3=5.0;s3=4.0;r3=0.0021;x03=-1.6013;Iext3=3.0;

Q0=0.0;
H=1.0;
omega=0.0;


  N=2048;

  dt=1/N;
  td=3500;
  t=0:dt:td; 
  
% xx=3*rand(3,1);
% x1=xx(1,1);x2=xx(2,1);x3=xx(1,1);
  x1=1.396183227193100;  x2=-5.954309518830213;  x3=2.650451475381197;
  x4=2.396183227193100;  x5=-5.954309518830213;  x6=2.650451475381197;
  x7=3.396183227193100;  x8=-5.954309518830213;  x9=2.650451475381197;
  
  xx=[x1,x2,x3,x4,x5,x6,x7,x8,x9];
  
[t,y]=ode45('HR_neuron_3couple',t,xx);


Np=500;

figure(1)
subplot(2,2,1)
plot(y(end-Np*N:end,1))
title('x1')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,2))
title('y1')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,3))
title('z1')
hold on
subplot(2,2,4)
plot3(y(end-Np*N:end,1),y(end-Np*N:end,2),y(end-Np*N:end,3))
title('x1 vs y1 vs z1')


figure(2)
subplot(2,2,1)
plot(y(end-Np*N:end,4))
title('x2')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,5))
title('y2')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,6))
title('z2')
hold on
subplot(2,2,4)
plot3(y(end-Np*N:end,4),y(end-Np*N:end,5),y(end-Np*N:end,6))
title('x2 vs y2 vs z2')


figure(3)
subplot(2,2,1)
plot(y(end-Np*N:end,7))
title('x2')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,8))
title('y2')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,9))
title('z2')
hold on
subplot(2,2,4)
plot3(y(end-Np*N:end,7),y(end-Np*N:end,8),y(end-Np*N:end,9))
title('x2 vs y2 vs z2')



figure(10)
subplot(2,2,1)
plot(y(end-Np*N:end,1),y(end-Np*N:end,2))
title('x1 vs y1')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,1),y(end-Np*N:end,3))
title('x1 vs z1')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,2),y(end-Np*N:end,3))
title('y1 vs z1')


figure(11)
subplot(2,2,1)
plot(y(end-Np*N:end,4),y(end-Np*N:end,5))
title('x2 vs y2')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,4),y(end-Np*N:end,6))
title('x2 vs z2')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,5),y(end-Np*N:end,6))
title('y2 vs z2')


figure(12)
subplot(2,2,1)
plot(y(end-Np*N:end,7),y(end-Np*N:end,8))
title('x3 vs y3')
hold on
subplot(2,2,2)
plot(y(end-Np*N:end,7),y(end-Np*N:end,9))
title('x3 vs z3')
hold on
subplot(2,2,3)
plot(y(end-Np*N:end,8),y(end-Np*N:end,9))
title('y3 vs z3')



numb=160000;
Nnumb=1024;

figure(21)
subplot(2,2,1)
plot(t(end-numb:end),y(end-numb:end,1))
hold on
plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,4),'o-')
title('x1 vs x2')
subplot(2,2,2)
plot(t(end-numb:end),y(end-numb:end,2))
hold on
plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,5),'o-')
title('y1 vs y2')
subplot(2,2,3)
plot(t(end-numb:end),y(end-numb:end,3))
hold on
plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,6),'o-')
title('z1 vs z2')
subplot(2,2,4)
plot3(y(end-numb:end,1),y(end-numb:end,2),y(end-numb:end,3))
hold on
plot3(y(end-numb:Nnumb:end,4),y(end-numb:Nnumb:end,5),y(end-numb:Nnumb:end,6),'o')
title('x1 y1 z1 vs x2 y2 z2')

format long
y(end,1)
y(end,2)
y(end,3)
y(end,4)
y(end,5)
y(end,6)
y(end,7)
y(end,8)
y(end,9)