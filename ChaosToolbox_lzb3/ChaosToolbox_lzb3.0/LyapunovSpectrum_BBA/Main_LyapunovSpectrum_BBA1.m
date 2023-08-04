
% �������ʱ������Lyapunovָ���׵�BBA�㷨 - Henon����
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
% Henonӳ�� 
% x(n+1) = 1 - a * x(n)^2 + y(n);  
% y(n+1) = b * x(n)

a = 1.4;
b = 0.3;

x0 = 0.25;
y0 = 0.25;

k1 = 500;                  % ǰ��ĵ�������
k2 = 5000;                % ����ĵ�������

Z = zeros(k1+k2,2);
for i = 1:k1+k2
    x = 1 - a * x0^2 + y0 ;
    y = b * x0;
    x0 = x;
    y0 = y;
    
    Z(i,1) = x;
    Z(i,2) = y;
end
X = Z(k1+1:end,1);

%--------------------------------------------------------------------------
% ��������

fs = 1;                   % ����Ƶ��
t = 1;                    % �ع�ʱ��
t2 = 1;                   % ����ʱ��
dl = 2;                   % �ֲ�Ƕ��ά
dg = 4;                   % ȫ��Ƕ��ά
o = 2;                    % ����ʽ��Ͻ���    
p = 1;                    % ����ƽ������ (�����Ǹ�����ʱ p = 1)

%--------------------------------------------------------------------------
% Lyapunovָ���׵�BBA�㷨

tic
[LE,K] = LyapunovSpectrum_BBA(X,fs,t,t2,dl,dg,o,p);
t = toc

%--------------------------------------------------------------------------
% �����ͼ

figure;
plot(K,LE)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
title(['Henon, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% �����ʾ

LE = LE(:,end)