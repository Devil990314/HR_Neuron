function [tau] = DelayTime_ComplexAutoCorrelation(X,maxLags,m,IsPlot)
% (ȥƫ)������ط������ʱ�������ع���ʱ���ӳ�(��֪ m,�� tau)
% ���������X         ����ʱ������
%           maxLags�� ���ʱ���ӳ�
%           m         Ƕ��ά
% ���������tau����   ʱ���ӳ١�
%
% �ο�����:����.����ʱ�����з�����Ӧ��.P63
%

X_mean = mean(X);
C_tau = zeros(1,maxLags);
for tau_i = 1:maxLags
    xn = PhaSpaRecon(X,tau_i,m);      % �ع���ռ�
    xn_cols = size(xn,2);
    temp = zeros(1,xn_cols);
    for i = 2:m
        temp = temp + (xn(1,:)-X_mean).*(xn(i,:)-X_mean);
    end
    C_tau(tau_i) = mean(temp);  % tau ����Ӧ��ƽ��λ��
end

% ȥƫ������غ����½�����ʼֵ�� 1-1/e ʱ�� tau ��Ϊ���� (tau �� 1 ��ʼ)

gate = (1-exp(-1))*C_tau(1);
temp = find(C_tau<=gate);
if (isempty(temp))
    disp('err: max delay time is too small!')
    tau = [];
else
    tau = temp(1);    
end

if IsPlot
    figure;
    plot(1:maxLags,C_tau,'.-',1:maxLags,gate*ones(1,maxLags),'r')
    xlabel('Lag');
    title('(ȥƫ)������ط�');
end
