
% �ٽ����㷨��Ƕ��ά (False Nearest Neighbors, FNN)
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2
% 
% �ο�����: M.B.Kennel, R.Brown, H.D.I.Abarbanel. Determining embedding dimension for phase-space reconstruction using a geometrical construction[J]. Phys. Rev. A 1992,45:3403.

clc
clear
close all

%--------------------------------------------------------------------------
% ���� Lorenz ʱ������
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz ���̲��� a = 16 | 10
b = 4;                  %                 b = 4 | 8/3
r = 45.92;              %                 c = 45.92 | 28     

y = [-1;0;1];           % ��ʼ�� (3x1 ��������)
h = 0.01;               % ����ʱ�䲽��

k1 = 30000;             % ǰ��ĵ�������
k2 = 3000;              % ����ĵ�������

Z = LorenzData(y,h,k1+k2,sigma,r,b);
X = Z(k1+1:end,1);      % ʱ������(������)

%--------------------------------------------------------------------------
% ��������

t = 10;                 % ʱ��
dmax = 8;               % ���Ƕ��ά
r_tol = 15;             % �о�1����
a_tol = 2;              % �о�2����

tic
[P,P1,P2] = FNN(X,t,dmax,r_tol,a_tol);
t = toc

%--------------------------------------------------------------------------
% �����ͼ

figure;
plot(1:dmax,P1,'bx-',1:dmax,P2,'k+-',1:dmax,P,'ro-');
axis([1,dmax,0,100]);
xlabel('Ƕ��ά');
ylabel('�ٽ�����');
legend('�о�1','�о�2','�����о�');
grid on;












