
% ���������ͼ��Ĺ���ά�� - ������1
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

clc
clear
close all

%-------------------------------------------------------------------------
% ���������ͼ��

c = imread('dla.gif');

figure
imagesc(~c)
colormap gray
axis square

%-------------------------------------------------------------------------
% �����ά��

q = 0;
[log2C,log2r] = GeneralizedDimension_2D(c,q);

figure
plot(log2r,log2C,'bo'); xlabel('log2(r)'); ylabel('log2(C(r))'); hold on;

%-------------------------------------------------------------------------
% ȷ����������

Linear = 1:length(log2C);
par = polyfit(log2r(Linear),log2C(Linear),1);
Dq = par(1)              % ��ά��

log2C_estimate = polyval(par,log2r(Linear),1);
plot(log2r(Linear),log2C_estimate,'r-'); hold off;

