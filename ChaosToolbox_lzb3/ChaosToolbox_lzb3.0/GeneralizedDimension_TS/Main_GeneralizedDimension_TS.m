
% ����ʱ�����еĹ���ά�� - ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear all
close all

%--------------------------------------------------------------------------
% produce the FBM time series��Set parameter H to 0.6 and sample length

rand('state',sum(100*clock))
H = 0.6; lg = 1024;
s = wfbm(H,lg);                    % ʱ������

figure; plot(s,'.-')

%--------------------------------------------------------------------------

q = 0;                             % �������ά����q
partition = 2^7;                   % ÿһά�����ϵķָ���
[log2C,log2r] = GeneralizedDimension_TS(s,q,partition);

figure
plot(log2r,log2C,'bo'); xlabel('log2(r)'); ylabel('log2(C(r))'); hold on;

%--------------------------------------------------------------------------
% ȷ����������

Linear = 1:length(log2C);
par = polyfit(log2r(Linear),log2C(Linear),1);
Dq = par(1)              % ��ά��

log2C_estimate = polyval(par,log2r(Linear),1);
plot(log2r(Linear),log2C_estimate,'r-'); hold off;

