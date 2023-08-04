%此程序可用于计算两个神经元耦合后的同步情况
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

k=20;

%   N=1024;
% 
%   dt=1/N;
%   td=1500;
  t=0:0.01:1500;
  %[t,y]=ode45('HR_neuron_2couple_chidu',t,[0 0 0 0 0 0]);
[t,y]=ode45('HR_neuron_2couple',t,[0 0 0 0 0 0]);
%神经元处膜电位于最低点x y z的值
%[t,y]=ode45('HR_neuron_2couple',t,[-1.60875058732268	-11.9448311155518	1.77684534527088;-1.59545058409589	-11.7086356884141	2.26803108688947]);
%初值为t=1500时的值
%[t,y]=ode45('HR_neuron_2couple',t,[-1.35389810066076	-8.23047992758630	1.55244510861234 -1.09821458511096	-5.22595016227622	1.99827887361598]);
figure(1)
subplot(2,2,1)
plot(y(:,1))
title('x1')
hold on
subplot(2,2,2)
plot(y(:,2))
title('y1')
hold on
subplot(2,2,3)
plot(y(:,3))
title('z1')
hold on
subplot(2,2,4)
plot3(y(:,1),y(:,2),y(:,3))
title('x1 vs y1 vs z1')


figure(2)
subplot(2,2,1)
plot(y(:,4))
title('x2')
hold on
subplot(2,2,2)
plot(y(:,5))
title('y2')
hold on
subplot(2,2,3)
plot(y(:,6))
title('z2')
hold on
subplot(2,2,4)
plot3(y(:,4),y(:,5),y(:,6))
title('x2 vs y2 vs z2')

figure(3)
subplot(2,2,1)
plot(y(:,1),y(:,2))
title('x1 vs y1')
hold on
subplot(2,2,2)
plot(y(:,1),y(:,3))
title('x1 vs z1')
hold on
subplot(2,2,3)
plot(y(:,2),y(:,3))
title('y1 vs z1')


figure(4)
subplot(2,2,1)
plot(y(:,4),y(:,5))
title('x2 vs y2')
hold on
subplot(2,2,2)
plot(y(:,4),y(:,6))
title('x2 vs z2')
hold on
subplot(2,2,3)
plot(y(:,5),y(:,6))
title('y2 vs z2')

figure(5)
subplot(3,1,1)
plot(t,y(:,1)-y(:,4))
title('x1-x2')
hold on 
subplot(3,1,2)
plot(t,y(:,2)-y(:,5))
title('y1-y2')
hold on 
subplot(3,1,3)
plot(t,y(:,3)-y(:,6))
title('z1-z2')
hold on 
grid on

numb=160000;
Nnumb=1024;

% figure(10)
% subplot(2,2,1)
% plot(t(end-numb:end),y(end-numb:end,1))
% hold on
% plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,4),'r-')
% title('x1 vs x2')
% subplot(2,2,2)
% plot(t(end-numb:end),y(end-numb:end,2))
% hold on
% plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,5),'o-')
% title('y1 vs y2')
% subplot(2,2,3)
% plot(t(end-numb:end),y(end-numb:end,3))
% hold on
% plot(t(end-numb:Nnumb:end),y(end-numb:Nnumb:end,6),'o-')
% title('z1 vs z2')
% subplot(2,2,4)
% plot3(y(end-numb:end,1),y(end-numb:end,2),y(end-numb:end,3))
% hold on
% plot3(y(end-numb:Nnumb:end,4),y(end-numb:Nnumb:end,5),y(end-numb:Nnumb:end,6),'o')
% title('x1 y1 z1 vs x2 y2 z2')
%提取数据至txt
fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\matlab_Coupled_data\1','k=20.txt'],'w');%写入文件路径
[r,c]=size(y);            % 得到矩阵的行数和列数
 for i=1:r
  for j=1:c
  fprintf(fid,'%f\t',y(i,j));
  end
  fprintf(fid,'\r\n');
 end
fclose(fid);

 fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\matlab_Coupled_data\1','k=20_time.txt'],'w');%写入文件路径
[r,c]=size(t);            % 得到矩阵的行数和列数
 for i=1:r
  for j=1:c
  fprintf(fid,'%f\t',t(i,j));
  end
  fprintf(fid,'\r\n');
 end
fclose(fid);

format long
y(end,1)
y(end,2)
y(end,3)
y(end,4)
y(end,5)
y(end,6)