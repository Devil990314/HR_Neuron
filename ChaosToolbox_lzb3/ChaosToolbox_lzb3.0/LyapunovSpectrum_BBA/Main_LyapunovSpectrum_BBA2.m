
% �������ʱ������Lyapunovָ���׵�BBA�㷨 - Lorenz����
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% �ο�����: 
%  Brown R, Bryant P, Abarbanel H D I. Computing the Lyapunov exponents of a dynamical system from oberseved time series[J]. Phys.Rev.A,1991,34:2787-2806.

clc
clear all
close all

%--------------------------------------------------------------------------
% ���� Lorenz ʱ������
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz ���̲��� a = 16 | 10
b = 4;                  %                 b = 4 | 8/3
r = 45.92;              %                 c = 45.92 | 28    

y = [-1,0,1];           % ��ʼ�� (1 x 3 ��������)
h = 0.01;               % ����ʱ�䲽��

k1 = 8000;              % ǰ��ĵ�������
k2 = 5000;              % ����ĵ�������

z = LorenzData(y,h,k1+k2,sigma,r,b);
z = z(k1+1:end,:);
X = z(:,1);

%--------------------------------------------------------------------------
% ��������

fs = 1/h;                 % ����Ƶ��
t = 10;                   % �ع�ʱ��
t2 = 2;                   % ����ʱ��
dl = 3;                   % �ֲ�Ƕ��ά
dg = 6;                   % ȫ��Ƕ��ά
o = 3;                    % ����ʽ��Ͻ���    
p = 50;                   % ����ƽ������ (�����Ǹ�����ʱ p = 1)

%--------------------------------------------------------------------------
% Lyapunovָ���׵�BBA�㷨

tic
[LE,K] = LyapunovSpectrum_BBA(X,fs,t,t2,dl,dg,o,p);
t = toc

%--------------------------------------------------------------------------
% �����ͼ

figure;
plot(K,LE); grid on;
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% �����ʾ

LE = LE(:,end)
