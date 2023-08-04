
% Lorenz ��������ά��ռ�ͼ���������Ľ� Runge-Kutta ���õ�΢���̵���ɢ����
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
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz ���̲��� a = 16 | 10
b = 4;                  %                 b = 4 | 8/3
r = 45.92;              %                 c = 45.92 | 28    

y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
h = 0.01;            % ����ʱ�䲽��

k1 = 8000;           % ǰ��ĵ�������
k2 = 3000;           % ����ĵ�������

data = LorenzData(y,h,k1+k2,sigma,r,b);
data = data(k1+1:end,:);

%--------------------------------------------------------------------------

X = data(:,1);
Y = data(:,2);
Z = data(:,3);

figure
plot3(Z,Y,X);
xlabel('Z');ylabel('Y');zlabel('X');
title('Lorenz attractor');

