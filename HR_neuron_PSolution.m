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
Iext=2.8;

% N=2048;
% dt=1/N;
% td=1500;
% t=0:dt:td; 

 [t,y]=ode45('HR_neuron',[0:0.01:1500],[0 0 0]);


figure(1)
subplot(2,2,1)
plot(y(:,1),'-b','LineWidth',1.5)
%set(gca,'looseInset',[0 0 0 0]) 
grid on;
hold on
%xlabel('t');
ylabel('x')

subplot(2,2,2)
plot(y(:,2),'-b','LineWidth',1.5)
hold on
grid on;
%xlabel('t');
ylabel('y')

subplot(2,2,3)
plot(y(:,3),'-b','LineWidth',1.5)
hold on
grid on;
%xlabel('t');
ylabel('z')

subplot(2,2,4)
%plot3(y(100000:end,1),y(100000:end,2),y(100000:end,3),'-b','LineWidth',1.5)
plot3(y(:,1),y(:,2),y(:,3),'-b','LineWidth',1.5)
grid on;
xlabel('x');
ylabel('y');
zlabel('z');

% fullname  = ['C:\Users\Asus\Desktop\','I=1.287','.tif']
% print('-dtiff','-r600',fullname)


% figure(2)
% subplot(2,2,1)
% plot(y(:,1),y(:,2))
% hold on
% subplot(2,2,2)
% plot(y(:,1),y(:,3))
% hold on
% subplot(2,2,3)
% plot(y(:,2),y(:,3))
% grid on;
% 
% figure(6)
% hold on
% plot(y(end-10*a:end,1),y(end-10*a:end,2))
% hold on
% plot(y(end-10*a:a:end,1),y(end-10*a:a:end,2),'r*')
% figure(7)
% hold on
% plot(y(end-10*a:end,3),y(end-10*a:end,4))
% hold on
% plot(y(end-10*a:a:end,3),y(end-10*a:a:end,4),'r*')


format long
y(end,1)
y(end,2)
y(end,3)
%提取数据至txt
% fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\1\1','I=3.5.txt'],'w');%写入文件路径
% [r,c]=size(y);            % 得到矩阵的行数和列数
%  for i=1:r
%   for j=1:c
%   fprintf(fid,'%f\t',y(i,j));
%   end
%   fprintf(fid,'\r\n');
%  end
% fclose(fid);
% 
%  fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\1\1','I=3.5_time.txt'],'w');%写入文件路径
% [r,c]=size(t);            % 得到矩阵的行数和列数
%  for i=1:r
%   for j=1:c
%   fprintf(fid,'%f\t',t(i,j));
%   end
%   fprintf(fid,'\r\n');
%  end
% fclose(fid);
% Nplot=1e+5
% for i=1:Nplot
%     for j=1:3
%     A(i,j)=y(end-i,j);
%     end
% end
% plot(A(:,1))
