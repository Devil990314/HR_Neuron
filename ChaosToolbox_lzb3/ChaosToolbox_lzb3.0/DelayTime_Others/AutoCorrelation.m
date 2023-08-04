function [tau] = AutoCorrelation(X,maxLags,IsPlot)
% ����ط������ʱ�������ع���ʱ���ӳ�
% ���������X         ����ʱ������
%           maxLags�� ���ʱ���ӳ�
% ���������tau����   ʱ���ӳ١�

ACF = autocorr(X,maxLags);   % ������غ���

% ����غ����½�����ʼֵ�� 1-1/e ʱ�� tau ��Ϊ���� (tau �� 1 ��ʼ)
gate = (1-exp(-1))*ACF(1);
temp = find(ACF<=gate);
if (isempty(temp))
    disp('err: max delay time is too small!')
    tau = [];
else
    tau = temp(1)-1    
end

if IsPlot
    figure;
    plot(0:length(ACF)-1,ACF,'.-',0:length(ACF)-1,ones(length(ACF),1)*gate,'r')
    xlabel('Lag');
    title('����ط���ʱ��');
end