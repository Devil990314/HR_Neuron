
% �������ʱ������Kolmogorov�ص�STB�㷨
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% �ο�����: 
% Schouten J C,Takens F,van den Bleek C M. Maximum-likelihood Estimation of the Entropy of an Attractor[J]. Phys.Rev.E,1994,49(1):126-129

clc
clear all
close all

%--------------------------------------------------------------------------
% ���� Lorenz ʱ������
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;                 % Lorenz���̲���
r = 45.92;               
b = 4;          

y = [-1;0;1];               % ��ʼ�� (3x1 ��������)
h = 0.01;                   % ����ʱ�䲽��

k1 = 30000;                 % ǰ��ĵ�������
k2 = 50000;                 % ����ĵ�������

X = LorenzData(y,h,k1+k2,sigma,r,b);
X = X(k1+1:end,1);          % ʱ������(������)

%--------------------------------------------------------------------------

fs = 1/h;                   % �źŲ���Ƶ��
t = 10;                     % �ع�ʱ��
dd = 4;                     % Ƕ��ά���
D = 4:dd:50;                % �ع�Ƕ��ά
bmax = 60;                  % �����ɢ����ֵ
p = 100;                    % ����ƽ������ (�����Ǹ�����ʱ p = 1)

%--------------------------------------------------------------------------
% ����ÿһ��Ƕ��ά��Ӧ��Kolmogorov��

tic
KE = KolmogorovEntropy(X,fs,t,D,bmax,p);
t = toc

%--------------------------------------------------------------------------
% �����ͼ

figure;
plot(D,KE,'k.-'); grid on;
xlabel('m'); 
ylabel('Kolmogorov Entropy (nats/s)');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% �����ʾ

disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));



