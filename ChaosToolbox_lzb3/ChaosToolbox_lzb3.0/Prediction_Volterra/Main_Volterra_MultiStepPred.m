
% ����ʱ�����е� volterra Ԥ��(�ಽԤ��) -- ������
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
X = normalize_a(X,1);      % �źŹ�һ������ֵΪ0,���Ϊ1


%--------------------------------------------------------------------------
% ��ز���

t = 10;                 % ʱ��
d = 3;                  % Ƕ��ά��
p = 3;                  % volterra����
n_tr = 1000;            % ѵ��������
n_te = 1000;            % ����������

%--------------------------------------------------------------------------
% ��ռ��ع�

X = X(1:n_tr+n_te);

[XN_TR,DN_TR] = PhaSpaRecon(X(1:n_tr),t,d);
[XN_TE,DN_TE] = PhaSpaRecon(X(n_tr+1:n_tr+n_te),t,d);

%--------------------------------------------------------------------------
% ѵ��

[Wn,err_mse1] = volterra_train_lu(XN_TR,DN_TR,p);
err_mse1 = err_mse1/var(X)

%--------------------------------------------------------------------------
% �ಽԤ��

n_pr = 300;

X_ST = X(n_tr-(d-1)*t:n_tr);
DN_PR = zeros(n_pr,1);
for i=1:n_pr
    XN_ST = PhaSpaRecon(X_ST,t,d);
    DN_PR(i) = volterra_test(XN_ST,p,Wn);    
    X_ST = [X_ST(2:end);DN_PR(i)];
end
DN_TE = X(n_tr+1:n_tr+n_pr);

%--------------------------------------------------------------------------
% ��ͼ

figure;
subplot(211)
plot(n_tr+1:n_tr+n_pr,DN_TE,'r+-',...
     n_tr+1:n_tr+n_pr,DN_PR,'b-');
title('��ʵֵ(+)��Ԥ��ֵ(.)')
subplot(212)
plot(n_tr+1:n_tr+n_pr,DN_TE-DN_PR,'k'); grid;
title('Ԥ��������')

