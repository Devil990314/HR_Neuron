
% G-P �㷨�����ά(����ʱ����������)
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear all
close all

%--------------------------------------------------------------------------
% ���� Lorenz ʱ������
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz���̲���
r = 45.92;               
b = 4;          

y = [-1;0;1];           % ��ʼ�� (3x1 ��������)
h = 0.01;               % ����ʱ�䲽��

k1 = 30000;             % ǰ��ĵ�������
k2 = 5000;              % ����ĵ�������

X = LorenzData(y,h,k1+k2,sigma,r,b);
X = X(k1+1:end,1);      % ʱ������(������)

%--------------------------------------------------------------------------
% G-P�㷨�������ά

rr = 0.5;
Log2R = -6:rr:0;        % log2(r)
R = 2.^(Log2R);

t = 10;                 % ʱ��
dd = 2;                 % Ƕ��ά���
D = 2:dd:40;            % Ƕ��ά    
p = 50;                 % ���ƶ��ݷ��룬��������ƽ������(�����Ǹ�����ʱ p = 1)   

tic 
Log2Cr = log2(CorrelationIntegral(X,t,D,R,p));       % ���ÿһ�ж�Ӧһ��Ƕ��ά
toc

%--------------------------------------------------------------------------
% �����ͼ

figure
plot(Log2R,Log2Cr','k.-'); axis tight; grid on; hold on;
xlabel('log2(r)'); 
ylabel('log2(C(r))');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% ��С�������

Linear = [3:9];                       % �����ƺ�����
[A,B] = LM1(Log2R,Log2Cr,Linear);     % ��С������б��

for i = 1:length(D)
    Y = polyval([A(i),B(i)],Log2R(Linear),1);
    plot(Log2R(Linear),Y,'r');    
end
hold off;

%--------------------------------------------------------------------------
% ���ݶ�

Slope = diff(Log2Cr,1,2)/rr;           % ���ݶ�
xSlope = Log2R(1:end-1);               % �ݶ�����Ӧ��log2(r)

figure;
plot(xSlope,Slope','k.-'); axis tight; grid on;
xlabel('log2(r)'); 
ylabel('slope');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% ����ά����

figure;
plot(D,A,'k.-'); grid on; axis tight;
xlabel('m'); 
ylabel('Correlation Dimension');
title(['Lorenz, length = ',num2str(k2)]);

