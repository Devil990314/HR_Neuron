
% Rossler ��������ά��ռ�ͼ���������Ľ� Runge-Kutta ���õ�΢���̵���ɢ����
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear all
close all

%--------------------------------------------------------------------------
% ���̱��ʽ
% dx/dt = -(y+z)
% dy/dt = x + d*y
% dz/dt = e + z*(x-f)

d = 0.2;           % Rossler ���̲��� a = 0.15 | 0.2
e = 0.2;           %                  b = 0.2 | 0.2           
f = 5;             %                  c = 10 | 5

y = [-1,0,1];      % ��ʼ�� (1 x 3 ��������)
h = 0.05;          % ����ʱ�䲽��

k1 = 50000;        % ǰ��ĵ�������
k2 = 3000;         % ����ĵ�������

data = RosslerData(y,h,k1+k2,d,e,f);
data = data(k1+1:end,:);

%--------------------------------------------------------------------------

X = data(:,1);
Y = data(:,2);
Z = data(:,3);

figure
plot3(X,Y,Z);grid;
xlabel('x');ylabel('y');zlabel('z');
title('Rossler attractor');

