% �������ʱ������ Lyapunov ָ�� - Lorenz ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear
close all

disp('********** Lorenz ***********')

%-----------------------------------------------------------------
% ���� Lorenz ����ʱ������

% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz ���̲��� a = 16 | 10
b = 4;                  %                 b = 4 | 8/3
r = 45.92;              %                 c = 45.92 | 28           

y = [-1,0,1];           % ��ʼ�� (1 x 3 ��������)
h = 0.01;               % ����ʱ�䲽��

k1 = 30000;             % ǰ��ĵ�������
k2 = 5000;              % ����ĵ�������

Z = LorenzData(y,h,k1+k2,sigma,r,b);
X = Z(k1+1:end,1);      % ʱ������

%-----------------------------------------------------------------
% Lorenz ��ڲ���

fs = 1/h;               % ����Ƶ��
t = 10;                 % ʱ��
d = 3;                  % Ƕ��ά
tmax = 300;             % �����ɢ����ʱ��
p = 50;                 % ����ƽ������

%-----------------------------------------------------------------
% ���ü��㺯��

tic
Y = Lyapunov_rosenstein_2(X,fs,t,d,tmax,p);
t = toc

I = [0:length(Y)-1]';

linear = [60:180]';  % ��������
F1 = polyfit(I(linear),Y(linear),1);
Y1 = polyval(F1,I(linear),1);

%-----------------------------------------------------------------
% �����ʾ

figure
subplot(211); 
plot(I,Y,'k-'); grid; xlabel('i'); ylabel('y(i)'); hold on;
plot(I(linear),Y1,'r-'); hold off;
subplot(212); 
plot(I(1:end-1),diff(Y),'k-'); grid; xlabel('n'); ylabel('slope');

Lyapunov1_2 = F1(1)
Lyapunov1_e = F1(1)*log(2)
