
% ����ʱ�����е� volterra Ԥ��(һ��Ԥ��) -- ������
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

sigma = 16;          % Lorenz���̲���
r = 45.92;               
b = 4;          

y = [-1;0;1];        % ��ʼ�� (3x1 ��������)
h = 0.01;            % ����ʱ�䲽��

k1 = 30000;          % ǰ��ĵ�������
k2 = 5000;           % ����ĵ�������

Z = LorenzData(y,h,k1+k2,sigma,r,b);
X = Z(k1+1:end,1);   % ʱ������(������)
X = normalize_a(X,1);   % �źŹ�һ������ֵΪ0,���Ϊ1

%--------------------------------------------------------------------------
% ��ز���

t = 1;                  % ʱ��
d = 3;                  % Ƕ��ά��
p = 3;                  % Volterra����
n_tr = 1000;            % ѵ��������
n_te = 1000;            % ����������

%--------------------------------------------------------------------------
% ��ռ��ع�

X_TR = X(1:n_tr);
X_TE = X(n_tr+1:n_tr+n_te);

[XN_TR,DN_TR] = PhaSpaRecon(X_TR,t,d);
[XN_TE,DN_TE] = PhaSpaRecon(X_TE,t,d);

%--------------------------------------------------------------------------
% ѵ����Ԥ��

[Wn,err_mse1] = volterra_train_lu(XN_TR,DN_TR,p);
perr1 = err_mse1/var(X)

DN_PR = volterra_test(XN_TE,p,Wn);
ERR2 = DN_TE - DN_PR;
err_mse2 = sum(ERR2.^2)/length(ERR2);
perr2 =  err_mse2/var(X)

%--------------------------------------------------------------------------
% �����ͼ

figure;
subplot(211);
plot(1:length(ERR2),DN_TE,'r+-',1:length(ERR2),DN_PR,'b-');
title('��ʵֵ(+)��Ԥ��ֵ(.)')
subplot(212);
plot(ERR2,'k');
title('Ԥ��������')


