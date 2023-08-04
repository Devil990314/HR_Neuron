function [tau] = AverageDisplacement(X,maxLags,m)
% ƽ��λ�Ʒ������ʱ�������ع���ʱ���ӳ�(��֪ m,�� tau)
% ���������X         ����ʱ������
%           maxLags�� ���ʱ���ӳ�
%           m         Ƕ��ά
% ���������tau����   ʱ���ӳ١�
%
% �ο�����:����.����ʱ�����з�����Ӧ��.P62
%

maxLags = maxLags + 1;              % ��Ϊ����Ҫ��һ����֣���������Ҫ��1

S_tau = zeros(1,maxLags);
for tau = 1:maxLags
    xn = PhaSpaRecon(X,tau,m);      % �ع���ռ�
    xn_cols = size(xn,2);
    temp = zeros(1,xn_cols);
    for i = 2:m
        temp = temp + (xn(i,:) - xn(1,:)).^2;
    end
    S_tau(tau) = mean(sqrt(temp));  % tau ����Ӧ��ƽ��λ��
end

% ������б�ʵ�һ�ν�Ϊ��ʼб�ʵ� 0.4 ����ʱ�� tau ��Ϊ���� (tau �� 1 ��ʼ)
slope = diff(S_tau);                % ���� tau ֮���б��
rate = 0.4;
gate = slope(1)*rate;

temp = find(slope<=gate);
if (isempty(temp))
    disp('err: max delay time is too small!')
    tau = [];
else
    tau = temp(1);    
end



