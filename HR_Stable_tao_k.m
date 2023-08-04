clear all
clc
close all
%此程序可研究固定时滞及固定耦合强度k时最大同步误差变化的情况
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
k=10;

ddefun=@(t,y,z)[y(2)-a1*y(1)*y(1)*y(1)+b1*y(1)*y(1)+Iext1-y(3)+k*(z(4,1)-y(1));
    c1-d1*y(1)*y(1)-y(2);
    r1*s1*(y(1)-x01)-r1*y(3);
    y(5)-a2*y(4)*y(4)*y(4)+b2*y(4)*y(4)+I0-y(6)+k*(z(1,1)-y(4));
    c2-d2*y(4)*y(4)-y(5);
    r2*s2*(y(4)-x02)-r2*y(6)];

% 定义历史 —— history
history =[-1.61045114054940	-11.9764876077047	1.45977669113604 -1.60815959722145	-11.9159578476135	1.98870321686002];
%history =[0 0 0 0 0 0];
% 定义时间积分区间 —— tspan
tspan = [0:0.01:1000];
sol=dde23(ddefun,[0.30],history,tspan);
%将解矩阵转置
sol.y=(sol.y)';
figure(1)
subplot(2,2,1)
plot(sol.x,sol.y(:,1))
title('x1')
hold on
subplot(2,2,2)
plot(sol.x,sol.y(:,2))
title('y1')
hold on
subplot(2,2,3)
plot(sol.x,sol.y(:,3))
title('z1')
hold on
subplot(2,2,4)
plot3(sol.y(:,1),sol.y(:,2),sol.y(:,3))
title('x1 vs y1 vs z1')

figure(2)
subplot(2,2,1)
plot(sol.x,sol.y(:,4))
title('x2')
hold on
subplot(2,2,2)
plot(sol.x,sol.y(:,5))
title('y2')
hold on
subplot(2,2,3)
plot(sol.x,sol.y(:,6))
title('z2')
hold on
subplot(2,2,4)
plot3(sol.y(:,4),sol.y(:,5),sol.y(:,6))
title('x2 vs y2 vs z2')

figure(3)
subplot(2,2,1)
plot(sol.y(:,1),sol.y(:,2))
title('x1 vs y1')
hold on
subplot(2,2,2)
plot(sol.y(:,1),sol.y(:,3))
title('x1 vs z1')
hold on
subplot(2,2,3)
plot(sol.y(:,2),sol.y(:,3))
title('y1 vs z1')
subplot(2,2,4)
plot(sol.y(:,1),sol.y(:,4))
title('x1 vs x2')


figure(4)
subplot(2,2,1)
plot(sol.y(:,4),sol.y(:,5))
title('x2 vs y2')
hold on
subplot(2,2,2)
plot(sol.y(:,4),sol.y(:,6))
title('x2 vs z2')
hold on
subplot(2,2,3)
plot(sol.y(:,5),sol.y(:,6))
title('y2 vs z2')
subplot(2,2,4)
plot(sol.y(:,2),sol.y(:,5))
title('y1 vs y2')

figure(5)
plot(sol.y(:,3),sol.y(:,6))
title('z1 vs z2')

figure(6)
plot(sol.x,sol.y(:,1)-sol.y(:,4))
title('x1-x2')
hold on 
grid on
% fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\时滞数据\1','tao=0.30,k=1.txt'],'w');%写入文件路径
% [r,c]=size(sol.y);            % 得到矩阵的行数和列数
%  for i=1:r
%   for j=1:c
%   fprintf(fid,'%f\t',sol.y(i,j));
%   end
%   fprintf(fid,'\r\n');
%  end
% fclose(fid);
% 
%  fid=fopen(['C:\Users\Asus\Desktop\Matlab_data\时滞数据\1','tao=0.30,k=1_time.txt'],'w');%写入文件路径
%  sol.x1=sol.x';
% [r,c]=size(sol.x1);            % 得到矩阵的行数和列数
%  for i=1:r
%   for j=1:c
%   fprintf(fid,'%f\t',sol.x1(i,j));
%   end
%   fprintf(fid,'\r\n');
%  end
% fclose(fid);