clear all
clc
close all

global a;  global b;  global c;
global d;  global s;  global r;
global x0; global Iext;


a=1.0; b=3.0; c=1.0; d=5.0;
s=4.0; r=0.002; x0=-1.60;

% a=1.0015; b=3.0122; c=1.0008; d=4.9994;
% s=3.9907; r=0.002137; x0=-1.6014;
Iext=1.267;

tspan=0:0.01:1500;
 [t,y]=ode45('HR_neuron',[tspan],[0 0 0]);
tend=60000;

figure(1)
subplot(2,3,1)
plot(y(:,1),'-b','LineWidth',1.5)
%set(gca,'looseInset',[0 0 0 0]) 
grid on;
hold on
a=xlabel('time,t');
b=ylabel('x')
c=title('(a)');
% set(a,'unit','normalized','Position',[0,-0.05],'fontsize',15,'fontname','Times New Roman');
% % 
% set(b,'unit','normalized','Position',[-0.05,1],'fontsize',15,'fontname','Times New Roman');
% % 
% set(c,'fontsize',15,'fontname','Times New Roman');

subplot(2,3,2)
plot(y(:,2),'-b','LineWidth',1.5)
hold on
grid on;
xlabel('time,t');
ylabel('y')
title('(b)');

subplot(2,3,3)
plot(y(:,3),'-b','LineWidth',1.5)
hold on
grid on;
xlabel('time,t');
ylabel('z')
title('(c)');

subplot(2,3,4)
plot(y(tend:end,1),y(tend:end,2),'-b','LineWidth',1.5)
%plot(y(:,1),y(:,2),'-b','LineWidth',1.5);
hold on;
grid on;
xlabel('x');
ylabel('y');
title('(d)');

subplot(2,3,5)
plot(y(tend:end,1),y(tend:end,3),'-b','LineWidth',1.5)
%plot(y(:,1),y(:,3),'-b','LineWidth',1.5);
hold on;
grid on;
xlabel('x');
ylabel('z');
title('(e)');

subplot(2,3,6)
plot(y(tend:end,2),y(tend:end,3),'-b','LineWidth',1.5);
%plot(y(:,2),y(:,3),'-b','LineWidth',1.5);
hold on;
grid on;
xlabel('y');
ylabel('z');
%axis([-12 -3 1 1.42]);
title('(f)');

fullname  = ['C:\Users\Asus\Desktop\','I=1.267_6picture','.tif']
print('-dtiff','-r600',fullname)

% set(gca, 'fontsize', 14);
% 
% % set(gca, 'XMinorTick', 'on');
% % 
% % set(gca, 'YMinorTick', 'on');
% 
% set(gca, 'XGrid', 'on');
% 
% set(gca, 'YGrid', 'on');
% 
% set(gca, 'LineWidth', 1.5)
%创建坐标轴、标题、图例的对象
% 
% >> a=xlabel('x (time)');b=ylabel('y (m)');c=title('sin(x) and cos(x)');d=legend('sin(x)','cos(x)');
% 
% %位置、大小、字体大小、字体样式设置
% 
% >> set(a,'unit','normalized','Position',[0,-0.05],'fontsize',15,'fontname','Times New Roman');
% 
% >> set(b,'unit','normalized','Position',[-0.05,1],'fontsize',15,'fontname','Times New Roman');
% 
% >> set(c,'fontsize',15,'fontname','Times New Roman');
% 
% >> set(d,'unit','normalized','Position',[0.2,0.2,0.1,0.1],'fontsize',10)

