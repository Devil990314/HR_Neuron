
% Duffing2 ��������ά��ռ�ͼ���������Ľ� Runge-Kutta ���õ�΢���̵���ɢ����
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
% dx/dt = y
% dy/dt = -delta*y + a*x*(1-x^2) + f*cos(z)
% dz/dt = omega

delta = 0.05;
a = 0.5;
f = 7.5;
omega = 1;

y = [-1,0,1];         % ��ʼ�� (1 x 3 ��������)
h = 0.05;             % ����ʱ�䲽��

k1 = 30000;           % ǰ��ĵ�������
k2 = 3000;            % ����ĵ�������

data = DuffingData2(y,h,k1+k2,delta,a,f,omega);
data = data(k1+1:end,:);

%--------------------------------------------------------------------------

X = data(:,1);
Y = data(:,2);
Z = data(:,3);

figure
plot3(Z,Y,X);
xlabel('Z');ylabel('Y');zlabel('X');
title('Duffing attractor');

