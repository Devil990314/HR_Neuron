
% G-P �㷨ͬʱ�����ά��Kolmogorov�� (����ʱ����������)
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% �ο�����: �Թ��,ʯ�׸�,���ķ��.�ӻ�������ͬʱ�������ά��Kolmogorov��[J].��������,1999;16(5):309~315

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

fs = 1/h;               % �źŲ���Ƶ��
t = 10;                 % ʱ��
dd = 4;                 % Ƕ��ά���
D = 4:dd:36;            % Ƕ��ά    
p = 50;                 % ���ƶ��ݷ��룬��������ƽ������(�����Ǹ�����ʱ p = 1)  

tic 
Log2Cr = log2(CorrelationIntegral(X,t,D,R,p));   % ���ÿһ�ж�Ӧһ��Ƕ��ά
toc

%--------------------------------------------------------------------------
% �����ͼ

figure
plot(Log2R,Log2Cr','k.-'); axis tight; hold on; grid on;
xlabel('log2(r)'); 
ylabel('log2(C(r))');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% ��С�������

Linear = [6:10];                            % �����ƺ�����
[a,B] = LM2(Log2R,Log2Cr,Linear);           % ��С������б�ʺͽؾ�

disp(sprintf('Correlation Dimension = %.4f',a));

for i = 1:length(D)
    Y = polyval([a,B(i)],Log2R(Linear),1);
    plot(Log2R(Linear),Y,'r');
end
hold off;

%--------------------------------------------------------------------------
% ���ݶ�

Slope = diff(Log2Cr,1,2)/rr;                % ���ݶ�
xSlope = Log2R(1:end-1);                    % �ݶ�����Ӧ��log2(r)

figure;
plot(xSlope,Slope','k.-'); axis tight; grid on;
xlabel('log2(r)'); 
ylabel('Slope');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% �����K��

KE = -diff(B)/(dd*t)*fs*log(2);             % �ò���Ƶ�� fs �͹�ʽ log(x) = log2(x)*log(2) ����λת���� nats/s
D_KE = D(1:end-1);                          % K������Ӧ��Ƕ��ά

figure;
plot(D_KE,KE,'k.-'); grid on; hold on;
xlabel('m'); 
ylabel('Kolmogorov Entropy (nats/s)');
title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% �����ʾ

disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));



