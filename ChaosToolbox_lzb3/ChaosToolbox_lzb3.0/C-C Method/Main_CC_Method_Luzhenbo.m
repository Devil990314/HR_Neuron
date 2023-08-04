
% C-C�����ع���ռ� - ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½��
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���41670240@qq.com
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear all
close all

%--------------------------------------------------------------------------
% ���� Lorenz ʱ������
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;          % Lorenz ���̲���
b = 4;               %               
r = 45.92;           %                           

y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
h = 0.01;            % ����ʱ�䲽��

k1 = 30000;          % ǰ��ĵ�������
k2 = 3000;           % ����ĵ�������

Z = LorenzData(y,h,k1+k2,sigma,r,b);
X = Z(k1+1:end,1);
%X=X_gk;
maxLags = 200;      % ���ʱ��

%--------------------------------------------------------------------------
% ����
tic
[S_mean,delta_S_mean,S_cor] = CC_luzhenbo(X,maxLags);
toc

%--------------------------------------------------------------------------
% �����ͼ

figure    
subplot(311)
plot(1:maxLags,S_mean); grid; title('S mean')
subplot(312)
plot(1:maxLags,delta_S_mean); grid; title('delta S mean')
subplot(313)
plot(1:maxLags,S_cor); grid; title('S cor')
