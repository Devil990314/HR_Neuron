
% Logistic ӳ��
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear all
close all

%--------------------------------------------------------------------------
% ���ʽ
% x(n+1) = lambda * x(n) * (1 - x(n)) 
% �� lambda �� 3 �� 4 �Ĺ���ͼ��
% �μ�<<���綯��ѧ����>>��ʿ����½�������� P46

lambda = 3:5e-4:4;
x = 0.4*ones(1,length(lambda));

k1 = 400;                   % ǰ��ĵ�������
k2 = 100;                   % ����ĵ�������

f = zeros(k1+k2,length(lambda));
for i = 1:k1+k2
    x = lambda .* x .* (1 - x);
    f(i,:) = x;
end
f = f(k1+1:end,:);

%--------------------------------------------------------------------------

figure(1)
plot(lambda,f,'k.','MarkerSize',1)
xlabel('\lambda')
ylabel('x');
