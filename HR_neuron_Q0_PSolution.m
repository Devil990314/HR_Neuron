clear all
clc
close all

global a1;global b1;global c1;global d1;global s1;global r1;global x01;
global Iext1;
global Q0;
global omega;
global f01;

a1=1.0;b1=3.0;c1=1.0;d1=5.0;s1=4.0;r1=0.002;x01=-1.60;

Iext1=4.0;
Q0=11;
f01=200;
omega=(2*3.1415926*f01)/1000;
%omega=2;


  N=1000;

  dt=1/N;
  td=1000;
  tspan=0:dt:td; 
tspend=100;
  xx=[0 0 0];
  
[t,y]=ode45('HR_neuron_Q0',tspan,xx);
figure(1)
subplot(2,2,1)
plot(y(:,1))
hold on
subplot(2,2,2)
plot(y(:,2))
hold on
subplot(2,2,3)
plot(y(:,3))
hold on
subplot(2,2,4)
plot3(y(tspend:end,1),y(tspend:end,2),y(tspend:end,3))


figure(2)
subplot(2,2,1)
plot(y(tspend:end,1),y(tspend:end,2))
hold on
subplot(2,2,2)
plot(y(tspend:end,1),y(tspend:end,3))
hold on
subplot(2,2,3)
plot(y(tspend:end,2),y(tspend:end,3))


format long
y(end,1)
y(end,2)
y(end,3)

